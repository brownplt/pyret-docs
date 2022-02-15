#lang at-exp racket/base

;; TODO
; - get path for loading module docs
; - pull in everything under generated for all-docs
; - turn set-documentation! errors into warnings that report at end of module
; - relax xrefs to support items beyond strings (such as method names)
;   idea here is xref["list" '("get" "to" "method")], with anchor formed
;   by string-join if itemspec is a list.

;; Scribble extensions for creating pyret.code.org documentation

(require scribble/base
         scribble/core
         scribble/decode
         scribble/basic
         scribble/html-properties
         (only-in scriblib/footnote note)
         scribble/private/manual-tech
         (for-syntax racket/base racket/syntax)
         racket/bool
         racket/file
         racket/dict
         racket/list
         racket/path
         racket/string
         racket/runtime-path
         scheme/class
         racket/match
         "scribble-helpers.rkt"
         "ragged.rkt"
         "ebnf.rkt"
         )

(provide bnf
         py-prod
         prod-link
         prod-ref
         custom-index-block

         (all-from-out scribble/private/manual-tech)

         docmodule
         function
         value
         form
         render-fun-helper
         re-export from
         pyret pyret-id pyret-method pyret-block
         tag-name
         type-spec
         data-spec
         data-spec2
         method-doc
         method-spec
         variants
         collection-doc
         constructor-spec
         constructor-doc
         constr-spec
         singleton-spec
         singleton-doc
         singleton-spec2
         with-members
         shared
         examples repl-examples
         a-compound
         a-id
         a-arrow
         a-tuple
         a-named-arrow
         a-record
         a-field
         a-app
         a-pred
         a-dot
         members
         member-spec
         lod
         ignore
         ignoremodule
         xref
         init-doc-checker
         append-gen-docs
         curr-module-name
         make-header-elt-for
         tag-name
         code-style
         div-style
         span-style
         doc-internal
         internal-id
         )

;;;;;;;;; Parameters and Constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; tracks the module currently being processed
(define curr-module-name (make-parameter #f))
(define curr-data-spec (make-parameter #f))
(define curr-var-spec (make-parameter #f))
(define curr-method-location (make-parameter 'shared))
(define EMPTY-XREF-TABLE (make-hash))
(define (internal-id object id)
  (seclink (xref object id) (tt (list object "." id))))


(define (doc-internal base-obj name args return #:stack-unsafe [stack-unsafe #f])
  (define tag (list 'part (tag-name base-obj name)))
  (define toc-elt (toc-target-element code-style (tt (list base-obj "." name)) tag))
  (define arrow (if stack-unsafe "!→" "→"))
  (define args-part
    (cond
      [(not args)
       (nested #:style (div-style "boxed")
         (list toc-elt " :: " (tt return)))]
      [(< 2 (length args))
       (nested #:style (div-style "boxed")
         (apply para #:style (dl-style "multiline-args")
          (append
            (list (dt toc-elt "("))
            (map dt-indent (map tt args))
            (list (dt (tt ")")) (dt (tt arrow " " return))))))]
      [else
       (nested #:style (div-style "boxed")
        (append (list toc-elt (tt "(")) (add-between (map tt args) (tt ", ")) (list (tt ") " arrow " ") (tt return))))]))
  (define stack-warning (if stack-unsafe (list (note (tt "!→") " means this function is not " (seclink "s:running" "stack safe"))) (list)))
  (nested #:style (div-style "function")
    (list
;      (apply para #:style "boxed pyret-header"
        (append
          stack-warning
          (list args-part)))))


;;;;;;;;;; API for generated module information ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Each module specification has the form
;   (module name path (spec-type (field val) ...) ...)
; where
;  - spec-type is one of path, fun-spec, unknown-item, data-spec, constr-spec
;  - each spec-type has a field called name

(define mod-name second)
(define mod-path third)
(define mod-specs cdddr)
(define spec-type first)
(define (spec-fields l) (if (cons? l) (rest l) #f))
(define field-name first)
(define field-val second)



;;;;;;;;;; Functions to sanity check generated documentation ;;;;;;;;;;;;;;;;;;

;; Maybe something like this could be put in the Racket standard library?
(define-runtime-path HERE ".")

(define curr-doc-checks #f)

;; print a warning message, optionally with name of issuing function
(define (warning funname msg)
  (if funname
      (eprintf "WARNING in ~a: ~a~n" funname msg)
      (eprintf "WARNING: ~a~n" msg)))

(define (read-mod mod)
  (list (mod-name mod)
        (make-hash
         (map (lambda (spec)
                (cons (get-defn-field 'name spec) #f))
              (drop mod 3)))))
(define (init-doc-checker read-docs)
  (map read-mod read-docs))

(define (set-documented! modname name)
  (let ([mod (assoc modname curr-doc-checks)])
    (if mod
        (if (dict-has-key? (second mod) name)
            (if (dict-ref (second mod) name)
                (warning 'set-documented! (format "~s is already documented in module ~s" name modname))
                (dict-set! (second mod) name #t))
            (begin
              (warning 'set-documented! (format "Unknown identifier ~s in module ~s" name modname))))
        (warning 'set-documented! (format "Unknown module ~s" modname)))))

(define (report-undocumented modname)
  (let ([mod (assoc modname curr-doc-checks)])
    (if mod
        (dict-for-each
         (second mod)
         (lambda (key val)
           (unless val (warning 'report-undocumented
                                (format "Undocumented export ~s from module ~s"
                                        key modname)))))
        (warning 'report-undocumented (format "Unknown module ~s" modname)))))

;;;;;;;;;;; Functions to extract information from generated documentation ;;;;;;;;;;;;;;

;; finds module with given name within all files in docs/generated/arr/*
;; mname is string naming the module
(define (find-module mname)
  (let ([m (findf (lambda (mspec)
    (equal? (mod-name mspec) mname)) ALL-GEN-DOCS)])
    (unless m
      (error 'find-module (format "Module not found ~a~n" mname)))
    m))

;; finds definition in defn spec list that has given value for designated field
;; by-field is symbol, indefns is list<specs>
(define (find-defn/nowarn by-field for-val indefns)
  (if (or (empty? indefns) (not indefns))
      #f
      (let ([d (findf (lambda (d)
                        (with-handlers [(exn:fail:contract? (lambda(e) #f))]
                          (and (list? (spec-fields d))
                               (equal? for-val (field-val (assoc by-field (spec-fields d))))))) indefns)])
        d)))


;; finds definition in defn spec list that has given value for designated field
;; by-field is symbol, indefns is list<specs>
(define (find-defn by-field for-val indefns)
  (if (or (empty? indefns) (not indefns))
      #f
      (let ([d (findf (lambda (d)
                        (with-handlers [(exn:fail:contract? (lambda(e) #f))]
                          (and (list? (spec-fields d))
                               (equal? for-val (field-val (assoc by-field (spec-fields d))))))) indefns)])
        (unless d
          (warning 'find-defn (format "No definition for field '~a = \"~a\" in module ~s" by-field for-val indefns)))
        d)))

;; defn-spec is '(fun-spec <assoc>)
(define (get-defn-field field defn-spec)
  (if (or (empty? defn-spec) (not defn-spec)) #f
      (let ([f (assoc field (spec-fields defn-spec))])
        (if f (field-val f) #f))))

;; extracts the definition spec for the given function name
;; - will look in all modules to find the name
(define (find-doc mname fname)
  (let ([mdoc (find-module mname)])
    (find-defn 'name fname (drop mdoc 3))))
(define (find-doc/nowarn mname fname)
  (let ([mdoc (find-module mname)])
    (find-defn/nowarn 'name fname (drop mdoc 3))))

;;;;;;;;;; Styles ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define css-js-additions (list "style.css"))

(define (div-style name)
  (make-style name (cons (make-alt-tag "div") css-js-additions)))

(define (pre-style name)
  (make-style name (list (make-alt-tag "pre"))))

(define code-style (make-style "pyret-code" (cons (make-alt-tag "span") css-js-additions)))

(define (span-style name)
  (make-style name (cons (make-alt-tag "span") css-js-additions)))

; style that drops html anchor -- use only with elems
(define (anchored-elem-style anchor)
  (make-style "anchor" (list (make-alt-tag "span") (url-anchor anchor))))

(define (dl-style name) (make-style name (list (make-alt-tag "dl"))))
(define (dt-style name) (make-style name (list (make-alt-tag "dt"))))
(define (dd-style name) (make-style name (list (make-alt-tag "dd"))))

(define (pyret-block #:style [style #f] . body)
  (define real-style (if style (string-append "pyret-highlight " style) "pyret-highlight"))
  (nested #:style (pre-style "pyret-block")
          (nested #:style (pre-style real-style) (apply literal body))))
(define (pyret #:style [style #f] . body)
  (define real-style (if style (string-append "pyret-highlight " style) "pyret-highlight"))
  (elem #:style (span-style real-style) (apply tt body)))
(define (pyret-id id (mod (curr-module-name)))
  (seclink (xref mod id) (tt id)))
(define pyret-method
  (case-lambda
    [(datatype id)
     (seclink (xref (curr-module-name) datatype "shared methods" id) (tt (string-append "." id)))]
    [(datatype varname id)
     (seclink (xref (curr-module-name) datatype varname id) (tt (string-append "." id)))]
    [(datatype varname id mod)
     (seclink (xref mod datatype (or varname "shared methods") id) (tt (string-append "." id)))]))

;;;;;;;;;; Cross-Reference Infrastructure ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Uses the xref table for error checking that
;   we aren't generating links to unknown targets
; TODO: fix path to html file in "file" definition
(define (xref modname itemname . subitems)
  (apply tag-name (cons modname (cons itemname subitems))))
;  (let [(cur-mod (curr-module-name))]
;    (traverse-element
;     (lambda (get set!)
;       (traverse-element
;        (lambda (get set!)
;          (let* ([xref-table (get 'doc-xrefs '())]
;                 [entry (assoc itemname xref-table)])
;            (when (string=? modname cur-mod)
;                (unless (and entry (string=? (second entry) modname))
;                  (error 'xref "No xref info for ~a in ~a~nxref-table = ~s~n" itemname modname xref-table)))
;            (let* ([file (path->string
;                          (build-path (current-directory)
;                                      (string-append modname ".html#" itemname)))]) ; fix here if change anchor format
;              (hyperlink file itemname)))))))))

; drops an "a name" anchor for cross-referencing
(define (drop-anchor name)
  (elem #:style (anchored-elem-style name) ""))

;;;;;;;;;; Scribble functions used in writing documentation ;;;;;;;;;;;;;;;;;;;

(define (ignoremodule name) "")

(define (ignore specnames)
  (for-each (lambda (n) (set-documented! (curr-module-name) n))
            specnames))

; generates dt for use in dl-style itemizations
(define (dt . args)
  (elem #:style (dt-style "") args))
; generates dt for use in dl-style itemizations
(define (dt-indent . args)
  (elem #:style (dt-style "indent-arg") args))

; generates dd for use in dl-style itemizations
(define (dd . args)
  (elem #:style (dd-style "") args))

;; docmodule is a macro so that we can parameterize the
;; module name before processing functions defined within
;; the module.  Need this since module contents are nested
;; within the module specification in the scribble sources
@(define-syntax (docmodule stx)
   (syntax-case stx ()
     [(_ name args ...)
      (syntax/loc stx
        (parameterize ([curr-module-name name])
          (let ([contents (docmodule-internal name args ...)])
            (report-undocumented name)
            contents)))]))

;; render documentation for all definitions in a module
;; this function does the actual work after syntax expansion
@(define (docmodule-internal name
                             #:friendly-title (friendly-title #f)
                             #:noimport (noimport #f)
                             . defs)
    (list (title #:version #f #:tag (tag-name name) (or friendly-title name))
          (if noimport ""
                       (list (para "Usage:")
                             (para (pyret "include " name))
                             (para (pyret "import " name " as ..."))))
          defs))

@(define (lod . assocLst)
   (let ([render-for "bs"])
     (second (assoc render-for assocLst))))

;; render re-exports
@(define (re-export name from . contents)
   (set-documented! (curr-module-name) name)
   (list "For " (elem #:style (span-style "code") name) ", see " from))

@(define (from where)
   (secref where))

@(define (tag-name . args)
   (apply string-append (add-between args "_")))

@(define (type-spec type-name tyvars #:private (private #f) #:no-toc (no-toc #f). body)
  (when (not private) (set-documented! (curr-module-name) type-name))
  (define name-part (make-header-elt-for (seclink (xref (curr-module-name) type-name) (tt type-name)) type-name))
  (define vars (if (cons? tyvars) (append (list "<") (add-between tyvars ", ") (list ">")) ""))
  ;;(define content-text (string-split (string-trim (content->string body)) "\n"))
  (define index-tags (list (pyret type-name) (curr-module-name)))
  ;;(define blurb (first content-text))
  (list
   (if no-toc '()
       (let ((tag (make-generated-tag)))
         (make-index-element #f
                             (list (make-target-element #f '() `(idx ,tag)))
                             `(idx ,tag)
                             (cons type-name (rest index-tags))
                             index-tags
                             #f)))
   (para #:style (div-style "boxed")
         (list name-part (tt vars)))
   body))

@(define-syntax (data-spec2 stx)
  (syntax-case stx()
    [(_ name tyvars args ...)
      (syntax/loc stx
        (parameterize ([curr-data-spec (find-doc (curr-module-name) name)])
         (let ([contents (data-spec-internal2 name tyvars args ...)])
           contents)))]))

@(define (make-header-elt-for elt name)
  (define tag (list 'part (tag-name (curr-module-name) name)))
  (toc-target-element code-style elt tag))

@(define (data-spec-internal2 data-name tyvars variants #:private (private #f) #:no-toc (no-toc #f))
  (when (not private) (set-documented! (curr-module-name) data-name))
  (define name-part ((if no-toc (lambda(link name) link) make-header-elt-for)
                     (seclink (xref (curr-module-name) data-name) (tt data-name)) data-name))
  (define vars (if (cons? tyvars) (append (list "<") (add-between tyvars ", ") (list ">")) ""))
    (nested #:style (div-style "boxed")
      (list
        (tt "data " name-part vars ":")
        (apply para #:style (dl-style "multiline-args") variants)
        (tt "end"))))

@(define (singleton-doc data-name variant-name return #:style (style "boxed") . body)
  (define name-elt (make-header-elt-for (seclink (xref (curr-module-name) variant-name) (tt variant-name)) variant-name))
  (define detector-name (string-append "is-" variant-name))
  (append
    (list
      (para #:style (div-style style) (tt name-elt " :: " return))
      #;(render-fun-helper
       '(fun) detector-name
       (list 'part (tag-name (curr-module-name) detector-name))
       (a-arrow (a-id "Any") (a-id "Boolean" (xref "<global>" "Boolean")))
       (a-id "Boolean" (xref "<global>" "Boolean")) (list (list "value" #f)) '() '() '()))
    body))

@(define (constructor-doc data-name variant-name members return #:private (private #f) #:style (style "boxed pyret-header") . body)
  (when (not private) (set-documented! (curr-module-name) variant-name))
  (define name-part (make-header-elt-for variant-name variant-name))
  (define member-types (map (lambda (m) (cdr (assoc "contract" (rest m)))) members))
  (define members-as-args (map (lambda (m) `(,(first m) #f)) members))
  (define detector-name (string-append "is-" variant-name))
  (append
    (list
      (render-fun-helper
       '(fun) variant-name
       (list 'part (curr-module-name) variant-name)
       (apply a-arrow (append member-types (list return)))
       return members-as-args '()  #:style style '() '())
      #;(render-fun-helper
       '(fun) detector-name
       (list 'part (tag-name (curr-module-name) detector-name))
       (a-arrow (a-id "Any") (a-id "Boolean" (xref "<global>" "Boolean")))
       (a-id "Boolean" (xref "<global>" "Boolean")) (list (list "value" #f)) '() '() '()))
    body))

@(define (singleton-spec2 data-name variant-name #:private (private #f))
  (when (not private) (set-documented! (curr-module-name) variant-name))
  (define processing-module (curr-module-name))
  (define name (seclink (xref processing-module variant-name) (tt variant-name)))
  (list (dt-indent (tt "| " name))))

;; String String List<Member> -> Scribbly-thing
@(define (constructor-spec data-name variant-name members)
  (define processing-module (curr-module-name))
  (define args (map (lambda (m)
    (define name (first m))
    (define type (cdr (assoc "type" (rest m))))
    (define contract (cdr (assoc "contract" (rest m))))
    (define modifier (if (equal? type "ref") "ref " ""))
    (if (car contract) (tt modifier name " :: " contract) (tt modifier name))) members))
  (define name (seclink (xref processing-module variant-name) (tt variant-name)))
  (list (dt-indent (tt "| " name "(" (add-between args ", ") ")"))))


;@(define (member-spec2 data-name variant-name name type contract)

@(define-syntax (data-spec stx)
   (syntax-case stx ()
     [(_ name args ...)
      (syntax/loc stx
        (parameterize ([curr-data-spec (find-doc (curr-module-name) name)])
         (let ([contents (data-spec-internal name args ...)])
           contents)))]))
@(define (data-spec-internal name #:params (params #f) #:private (private #f) . members)
   (when (not private) (set-documented! (curr-module-name) name))
   (let ([processing-module (curr-module-name)])
     (interleave-parbreaks/all
      (list (drop-anchor name)
            (subsubsub*section #:tag (tag-name (curr-module-name) name))
            (traverse-block ; use this to build xrefs on an early pass through docs
             (lambda (get set!)
               (set! 'doc-xrefs (cons (list name processing-module)
                                      (get 'doc-xrefs '())))
               @para{}))
            (interleave-parbreaks/all members)))))
@(define (method-doc data-name var-name name
                      #:params (params #f)
                      #:contract (contract #f)
                      #:return (return #f)
                      #:args (args #f)
                      #:alt-docstrings (alt-docstrings #f)
                      #:examples (examples '())
                      . body)
  (let* ([spec (and var-name
                    (find-defn/nowarn 'name name
                      (get-defn-field 'with-members (find-doc/nowarn (curr-module-name) var-name))))]
         [spec (or spec
                   (find-defn/nowarn 'name name
                      (get-defn-field 'shared (find-doc/nowarn (curr-module-name) data-name))))]
         [spec (or spec
                   (find-defn/nowarn 'name name
                      (get-defn-field 'with-members
                         (find-defn/nowarn 'name var-name
                            (drop (find-doc/nowarn (curr-module-name) data-name) 3)))))])
      (unless spec
        (warning 'method-doc
          (format "No definition for method ~a for data ~a and variant ~a in module ~s"
                  name data-name (or var-name "shared methods") (curr-module-name))))
      (render-fun-helper
        spec name
        (list 'part (curr-module-name) data-name (or var-name "shared methods") name)
        contract return args alt-docstrings examples body)))
@(define (method-spec name
                      #:params (params #f)
                      #:contract (contract #f)
                      #:return (return #f)
                      #:args (args #f)
                      #:alt-docstrings (alt-docstrings #f)
                      #:examples (examples '())
                      . body)
   (let* ([methods (get-defn-field (curr-method-location) (curr-var-spec))]
          [var-name (get-defn-field 'name (curr-var-spec))]
          [spec (find-defn 'name name methods)])
     (render-fun-helper
      spec name
      (list 'part (curr-module-name) var-name name)
      contract return args alt-docstrings examples body)))
@(define (member-spec name #:type (type-in #f) #:contract (contract-in #f) . body)
   (let* ([members (get-defn-field 'members (curr-var-spec))]
          [member (if (list? members) (assoc name members) #f)]
          [contract (or contract-in (interp (get-defn-field 'contract member)))]
          [modifier (if (equal? type-in "ref") "ref " "")])
     (list (dt (if contract (tt modifier name " :: " contract) (tt modifier name)))
           (dd body))))

@(define-syntax (singleton-spec stx)
   (syntax-case stx ()
     [(_ name args ...)
      (syntax/loc stx
        (parameterize ([curr-var-spec (find-doc (curr-module-name) name)]
                       [curr-method-location 'with-members])
          (let ([contents (singleton-spec-internal name args ...)])
            contents)))]))
@(define (singleton-spec-internal name #:private (private #f) . body)
   (if private
       (list (subsubsub*section name) body)
       (begin
         (when (not private) (set-documented! (curr-module-name) name))
         (list (subsubsub*section #:tag (list (tag-name (curr-module-name) name) (tag-name (curr-module-name) (string-append "is-" name))) name) body))))

@(define-syntax (constr-spec stx)
   (syntax-case stx ()
     [(_ name args ...)
      (syntax/loc stx
        (parameterize ([curr-var-spec (find-doc (curr-module-name) name)]
                       [curr-method-location 'with-members])
          (let ([contents (constr-spec-internal name args ...)])
            contents)))]))
@(define (constr-spec-internal name #:params (params #f) #:private (private #f) . body)
   (if private
       (list (subsubsub*section name) body)
       (begin
         (when (not private) (set-documented! (curr-module-name) name))
         (list (subsubsub*section #:tag (list (tag-name (curr-module-name) name) (tag-name (curr-module-name) (string-append "is-" name))) name) body))))

@(define (with-members . members)
   (if (empty? members)
       empty
       (list "Methods" members)))
@(define (members . mems)
   (if (empty? mems)
       empty
       (list "Fields" (para #:style (dl-style "fields") mems))))
@(define (a-id name . args)
   (if (cons? args) (seclink (first args) (tt name)) (tt name)))
@(define (a-compound typ . args)
   (if (cons? args) (seclink (first args) typ) typ))
@(define (a-app base . typs)
   (append (list base "<") (add-between typs ", ") (list ">")))
@(define (a-pred base refinement)
   (list base "%(" refinement ")"))
@(define (a-dot base field)
   (list base "." field))
@(define (a-arrow . typs)
   (append (list "(") (add-between typs ", " #:before-last " -> ") (list ")")))
@(define (every-other lst)
  (cond
    [(empty? lst) empty]
    [(cons? lst)
      (define r (rest lst))
      (cond
        [(empty? r) lst]
        [(cons? r) (cons (first lst) (every-other (rest (rest lst))))])]))
@(define (a-named-arrow . names-and-typs)
   (define all-but-last (take names-and-typs (- (length names-and-typs) 1)))
   (define last (first (drop names-and-typs (- (length names-and-typs) 1))))
   (define names (every-other all-but-last))
   (define typs (every-other (rest all-but-last)))
   (define pairs (map (λ (n t) (list n " :: " t)) names typs))
   (append (list "(") (add-between (append pairs (list last)) ", " #:before-last " -> ") (list ")")))
@(define (a-record . fields)
   (append (list "{") (add-between fields ", ") (list "}")))
@(define (a-tuple . fields)
   (append (list "{") (add-between fields "; ") (list "}")))
@(define (a-field name type . desc)
   (list name " :: " type))
@(define (variants . vars)
   vars)
@(define-syntax (shared stx)
   (syntax-case stx ()
     [(_ args ...)
      (syntax/loc stx
        (parameterize ([curr-var-spec (curr-data-spec)]
                       [curr-method-location 'shared])
          (let ([contents (shared-internal args ...)])
            contents)))]))
@(define (shared-internal . shares)
   (if (empty? shares)
       empty
       (list "Shared Methods" shares)))

@(define (interp an-exp)
   (cond
     [(and (cons? an-exp) (symbol? (first an-exp)))
      (let* ([f (first an-exp)]
             [args (map interp (rest an-exp))])
        (cond
          [(symbol=? f 'a-record) (apply a-record args)]
          [(symbol=? f 'a-id) (apply a-id args)]
          [(symbol=? f 'a-compound) (apply a-compound args)]
          [(symbol=? f 'a-arrow) (apply a-arrow args)]
          [(symbol=? f 'a-field) (apply a-field args)]
          [(symbol=? f 'a-app) (apply a-app args)]
          [(symbol=? f 'a-pred) (apply a-pred args)]
          [(symbol=? f 'a-dot) (apply a-dot args)]
          [(symbol=? f 'xref) (apply xref args)]
          [#t an-exp]))]
     [(list? an-exp) (map interp an-exp)]
     [#t an-exp]))


@(define (render-multiline-args names types descrs)
   (define len (length names))
   (map (lambda (name type descr i)
          (define (add-comma lst)
            (if (< i len)
                (append lst (list ","))
                lst))
          (cond
            [(and name type descr)
             (list (dt-indent (apply tt (add-comma (list name " :: " type))))
                   (dd descr))]
            [(and name type)
             (list (dt-indent (apply tt (add-comma (list name " :: " type))))
                   (dd ""))]
            [(and name descr)
             (list (dt-indent (apply tt (add-comma (list name))))
                   (dd descr))]
            [else (list (dt-indent (tt name)) (dd ""))]))
        names types descrs (range 1 (add1 len))))

@(define (render-singleline-args names types)
  (define args
   (map (lambda (name type)
          (cond [(and name type (or (not (list? type)) (car type)))
                 (list (tt name " :: " type))]
                [else (list (tt name))]))
        names types))
  (add-between args ", "))

;; render documentation for a function
@(define (render-fun-helper spec name part-tags contract-in return-in args alt-docstrings #:style (style "boxed pyret-header") examples contents)
   (when (not (cons? spec))
    (error (format "Could not find spec for ~a" name)))
   (when (and (cons? args) (not (cons? (first args))))
    (error (format "Args are not well-formed for ~a" name)))
   (define (check-first elt)
    (when (not (cons? elt))
      (error (format "Ill-formed docs in ~a" name)))
    (first elt))
   (define is-method (symbol=? (check-first spec) 'method-spec))
   (let* ([contract (or contract-in (interp (get-defn-field 'contract spec)))]
          [return (or return-in (interp (get-defn-field 'return spec)))]
          [orig-argnames (if (list? args) (map check-first args) (get-defn-field 'args spec))]
          [input-types (map (lambda(i)
            (define ret (drop contract (+ 1 (* 2 i))))
            (when (empty? ret)
              (error (format "Ill-formed args for ~a" name)))
            (check-first ret)) (range 0 (length orig-argnames)))]
          [argnames (if is-method (drop orig-argnames 1) orig-argnames)]
          [input-types (if is-method (drop input-types 1) input-types)]
          [input-descr (if (list? args) (map second args) (map (lambda(i) #f) orig-argnames))]
          [doc (or alt-docstrings (get-defn-field 'doc spec))]
          [arity (if args (length args) (get-defn-field 'arity spec))]
          [arity (if is-method (- arity 1) arity)]
;          [_ (printf "Input: ~a ~a ~a\n" name input-descr args)]
          [input-descr (if is-method (drop input-descr 1) input-descr)]
          )
     ;; checklist
     ; - TODO: make sure found funspec or unknown-item
     ; confirm argnames provided
     (unless argnames
       (error 'function (format "Argument names not provided for name ~s" name)))
     ; if contract, check arity against generated
     (unless (or (not arity) (eq? arity (length argnames)))
       (error 'function (format "Provided argument names do not match expected arity ~a ~a" arity name)))
     ;; render the scribble
     ; defining processing-module because raw ref to curr-module-name in traverse-block
     ;  wasn't getting bound properly -- don't know why
     (let ([processing-module (curr-module-name)])
       (define name-tt (if is-method (tt "." name) (seclink (xref processing-module name) (tt name))))
       (define index-tags (cons (pyret name) (filter (lambda(e) (not (or (equal? e name) (equal? e "")))) (rest part-tags))))
       (define name-elt (toc-target-element code-style (list name-tt) (list 'part (apply tag-name (rest part-tags)))))
       (interleave-parbreaks/all
        (list ;;(drop-anchor name)
         (let ((tag (make-generated-tag)))
           (make-index-element #f
                               (list (make-target-element #f '() `(idx ,tag)))
                               `(idx ,tag)
                               (cons name (rest index-tags))
                               index-tags
                               #f))
          (traverse-block ; use this to build xrefs on an early pass through docs
           (lambda (get set!)
             (set! 'doc-xrefs (cons (list name processing-module)
                                    (get 'doc-xrefs '())))
;             (define name-elt (seclink (xref processing-module name) name-target))
;             (printf "argnames: ~a, ~a\n" argnames (length argnames))
             (define no-descrs (or (empty? input-descr) (ormap (lambda (v) (false? v)) input-descr)))
             (define header-part
               (cond
                [(and (< (length argnames) 3) no-descrs)
                 (apply para #:style (div-style style)
                   (append
                    (list (tt name-elt " :: " "("))
                    (render-singleline-args argnames input-types)
                    (if return
                      (list (tt ")" " -> " return))
                      (list (tt ")")))))]
                [else
                 (nested #:style (div-style style)
                 (apply para #:style (dl-style "multiline-args")
                   (append
                    (list (dt name-elt " :: " "("))
                    (render-multiline-args argnames input-types input-descr)
                    (if return
                      (list (dt (tt ")")) (dt (tt "-> " return)))
                      (list (dt (tt ")")))))))]))
             (nested #:style (div-style "function")
                     (cons
                       header-part
                       (interleave-parbreaks/all
                        (append
                          (if doc (list doc) (list))
                          (list (nested #:style (div-style "description") contents))
                          (list (if (andmap whitespace? examples)
                            (nested #:style (div-style "examples") "")
                            (nested #:style (div-style "examples")
                                    (para (bold "Examples:"))
                                    (apply pyret-block examples)))))))))))))))

@(define (collection-doc name #:contract contract #:private (private #f))
  (when (not private) (set-documented! (curr-module-name) name))
  (define name-part (make-header-elt-for (seclink (xref (curr-module-name) name) (tt name)) name))
  (define (arrow-args arr) (reverse (rest (reverse (rest arr)))))
  (define (arrow-ret arr) (last arr))
  (define (unzip2 lst)
    (cond
      [(empty? lst) (values empty empty)]
      [else (define-values (fsts snds) (unzip2 (rest lst)))
            (values (cons (first (first lst)) fsts) (cons (second (first lst)) snds))]))
  (cond
    [(and (list? contract) (equal? (first contract) 'a-arrow))
      (cond
        [(and (list? (arrow-ret contract)) (equal? (first (arrow-ret contract)) 'a-arrow))
          ;; curried constructor
          (define-values (curried-argnames curried-argtypes) (unzip2 (arrow-args contract)))
          (define curried-args (render-singleline-args curried-argnames (map interp curried-argtypes)))
          (define-values (argnames argtypes) (unzip2 (arrow-args (arrow-ret contract))))
          (define patterns (render-singleline-args argnames (map interp argtypes)))
          (define return (interp (arrow-ret (arrow-ret contract))))
          (para #:style (div-style "boxed pyret-header")
            (tt "[" name-part "(" curried-args ")" ": " patterns ", ..." "] -> " return))]
        [else
          (define-values (argnames argtypes) (unzip2 (arrow-args contract)))
          (define patterns (render-singleline-args argnames (map interp argtypes)))
          (define return (interp (arrow-ret contract)))
          (para #:style (div-style "boxed pyret-header")
            (tt "[" name-part ": " patterns ", ..." "] -> " return))])]
    [else
      (warning 'collection-doc "Didn't provide an a-arrow as a contract!")
      (para #:style (div-style "boxed pyret-header")
        (tt "[" name-part ": ?] -> " (interp contract)))]))

@(define (examples . body)
  (nested #:style (div-style "examples")
          (para (bold "Examples:"))
          (apply pyret-block body)))

@(define (repl-examples . body)
  (define (repl-ex code ans)
    (let [(code (if (string? code) (list code) code))]
      (nested #:style (div-style "repl-examples")
              (nested #:style (div-style "repl-example") (apply pyret-block code))
              (para ans))))
  (nested #:style (div-style "examples")
          (para (bold "Examples:"))
          (map (lambda(ex) (apply repl-ex ex)) body)))


@(define (function name
                   #:contract (contract #f)
                   #:return (return #f)
                   #:args (args #f)
                   #:alt-docstrings (alt-docstrings #f)
                   #:examples (examples '())
                   #:private (private #f)
                   . contents
                   )
   (let* ([ans
          (render-fun-helper
           (find-doc (curr-module-name) name) name
           (list 'part (curr-module-name) name)
           contract return args alt-docstrings examples contents)])
          ; error checking complete, record name as documented
     (when (not private) (set-documented! (curr-module-name) name))
     ans))

(define (form name text #:private (private #f) . contents)
  (when (not private) (set-documented! (curr-module-name) name))
   (let ([processing-module (curr-module-name)])
     (define part-tag (list 'part (tag-name (curr-module-name) name)))
     (define pyret-text (seclink (xref processing-module name) (pyret text)))
     (define pyret-elt (toc-target-element code-style (list pyret-text) part-tag))
     (interleave-parbreaks/all
      (list
        (traverse-block ; use this to build xrefs on an early pass through docs
         (lambda (get set!)
           (set! 'doc-xrefs (cons (list name processing-module)
                                  (get 'doc-xrefs '())))
           (define header-part
               (apply para #:style (div-style "boxed pyret-header")
                  (list pyret-elt)))
           (nested #:style (div-style "value")
                   (cons
                     header-part
                     (interleave-parbreaks/all
                      (append
                        (list (nested #:style (div-style "description") contents))))))))))))

(define (value name ann #:private (private #f) #:style (style "boxed pyret-header") . contents)
  (when (not private) (set-documented! (curr-module-name) name))
   (let ([processing-module (curr-module-name)])
     (define part-tag (list 'part (tag-name (curr-module-name) name)))
     (define name-tt (seclink (xref processing-module name) (tt name)))
     (define name-elt (toc-target-element code-style (list name-tt) part-tag))
     (define part-tags (list 'part (curr-module-name) name))
     (define index-tags (cons (pyret name) (filter (lambda(e) (not (or (equal? e name) (equal? e "")))) (rest part-tags))))
     (interleave-parbreaks/all
      (list
        (traverse-block ; use this to build xrefs on an early pass through docs
         (lambda (get set!)
           (set! 'doc-xrefs (cons (list name processing-module)
                                  (get 'doc-xrefs '())))
           (define header-part
               (apply para #:style (div-style style)
                 (list (tt name-elt " :: " ann))))
           (nested #:style (div-style "value")
                   (cons
                     header-part
                     (interleave-parbreaks/all
                      (append
                        (list
                             (let ((tag (make-generated-tag)))
                               (make-index-element #f
                                                   (list (make-target-element #f '() `(idx ,tag)))
                                                   `(idx ,tag)
                                                   (cons name (rest index-tags))
                                                   index-tags
                                                   #f))
                             (nested #:style (div-style "description") contents))))))))))))


;; starts empty, different modules will add bindings
(define ALL-GEN-DOCS (list))

;; finds module with given name within all files in docs/generated/arr/*
;; mname is string naming the module
(define (check-module mname)
  (let ([m (findf (lambda (mspec)
    (equal? (mod-name mspec) mname)) ALL-GEN-DOCS)])
    m))


(define (append-gen-docs s-exp)
  (define mod (read-mod s-exp))
  (define modname (second s-exp))
  (define existing-mod (check-module modname))
  (if
    existing-mod
    (let ()
      (define new-elts (drop s-exp 3))
      (define without-orig (remove (lambda(m) (equal? (second m) (second s-exp))) ALL-GEN-DOCS))
      (set! ALL-GEN-DOCS (cons (append existing-mod new-elts) without-orig)))
    (set! ALL-GEN-DOCS (cons s-exp ALL-GEN-DOCS)))
  (set! curr-doc-checks (init-doc-checker ALL-GEN-DOCS))
  '())

(define (py-prod name) (prod-link 'Pyret name))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Customized version of index-block ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (custom-index-block)
  (define alpha (string->list "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
  (define (rows . rows)
    (make-table (make-style 'index null)
                (map (lambda (row)
                       (list (make-paragraph plain row)))
                     rows)))
  (define contents
    (lambda (renderer sec ri)
      (define raw-index-entries (get-index-entries sec ri))
      (define index-groups (group-by (lambda(i) (list (first (first i)) (first (second i))))
                                     raw-index-entries
                                     (lambda(i1 i2) (and (not (or (equal? (first i1) 'part)
                                                             (equal? (first i2) 'part)))
                                                    (equal? i1 i2)))))
      (define manual-newlines? (send renderer index-manual-newlines?))
      (define alpha-starts (make-hasheq))
      (define alpha-row
        (let loop ([i raw-index-entries] [alpha alpha])
          (define (add-letter let l)
            (list* (make-element "nonavigation" (list (string let))) " " l))
          (cond [(null? alpha) null]
                [(null? i) (add-letter (car alpha) (loop i (cdr alpha)))]
                [else
                 (let* ([strs (cadr (car i))]
                        [letter (if (or (null? strs) (string=? "" (car strs)))
                                  #f
                                  (char-upcase (string-ref (car strs) 0)))])
                   (cond [(not letter) (loop (cdr i) alpha)]
                         [(char-ci>? letter (car alpha))
                          (add-letter (car alpha) (loop i (cdr alpha)))]
                         [(char-ci=? letter (car alpha))
                          (hash-set! alpha-starts (car i) letter)
                          (list* (make-element
                                  (make-style #f (list (make-target-url (format "#alpha:~a" letter))))
                                  (list (string (car alpha))))
                                 " "
                                 (loop (cdr i) (cdr alpha)))]
                         [else (loop (cdr i) alpha)]))])))
      (define wrapped-alpha-row (make-element "alpha-row" alpha-row))
      (define br (if manual-newlines? (make-element 'newline '("\n")) ""))

      ;; Here, we want to create a list of links. However, since for each datum,
      ;; there might be an attached anchor too, we will need to flatten the
      ;; list of results.

      ;; A Link is a node which has either one or two parts (not counting link break).
      ;; The first one is link-name, and the second one (which might not exist) is origin.

      ;; NOTE: make-element will not create a new node if the style if #f
      ;; so we need to specify it if we want the node to be created

      ;; get-link : Group -> Link
      (define (get-link group)
        (match group
          [(list item)
           (let* ([tag-path (caddr item)]
                  [name (first tag-path)]
                  [path (rest tag-path)]
                  [name-element (make-element "link-name" name)]
                  [link-content
                   (match path
                     ['() (list name-element)]
                     [_ (list name-element
                              (make-element "origin"
                                            `(" (from "
                                              ,(add-between path " » ") ")")))])])
             (make-link-element "indexlink"
                                (append link-content (list br))
                                (car item)))]
          [_
           (define group-name (first (third (first group))))
           (define (get-origin item)
             (let* ([tag-path (caddr item)]
                    [name (first tag-path)]
                    [path (rest tag-path)]
                    [link-content (add-between path " » ")])
               (list (hspace 4)
                     "from "
                     (make-link-element "indexlink"
                                        `(,link-content ,br)
                                        (car item)))))
           (make-element
            "indexlinks"
            (list (make-element "link-name" group-name)
                  br
                  (make-element "origin" (map get-origin group))))]))

      ;; get-link-and-anchor : Group -> ([Anchor, Link] | [Link])
      (define (get-link-and-anchor group)
        (define link (get-link group))
        (define first-item
          (match group
            [(list item) item]
            [(list item _ ...) item]))
        (cond
          [(hash-ref alpha-starts first-item #f)
           => (lambda (letter)
                (define anchor-style
                  (list (make-url-anchor (format "alpha:~a" (char-upcase letter)))))
                (define anchor (make-element (make-style "post-anchor" anchor-style) '()))
                (list anchor link))]
          [else (list link)]))

      (define body
        (list (make-element "content-body"
                            (apply append (map get-link-and-anchor index-groups)))))
      (if manual-newlines?
        (rows wrapped-alpha-row '(nbsp) body)
        (apply rows wrapped-alpha-row '(nbsp) (map list body)))))
  (make-delayed-block contents))
