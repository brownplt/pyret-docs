#lang at-exp racket/base

(require scribble/base scribble/core scribble/decode scribble/basic scribble/html-properties
         racket/list "ragged.rkt" racket/string)

(provide bnf prod-link prod-ref)

(define (prod-tag grammar prod-name) (list 'bnf-prod (list grammar prod-name)))
(define (prod-ref name) (list "‹" name "›"))
(define (prod-link grammar name)
  (elemref (prod-tag grammar name) (prod-ref name)))


(define (render grammar parsed)
  (define-values (constants prods) (partition constant? parsed))
  (define names (map (λ(c) (list (lhs-id-val (constant-lhs c)) (pattern-lit-val (constant-val c)))) constants))
  (define (meta s)
    (elem s #:style (make-style #f (list (attributes '((class . "bnf-meta")))))))
  (define (lit s)
    (elem s #:style (make-style #f (list (attributes '((class . "bnf-lit")))))))
  (define (eps)
    (elem "ε" #:style (make-style #f (list (attributes '((class . "bnf-eps")))))))
  (define (unknown-lit s)
    (elem s #:style (make-style #f (list (attributes '((class . "bnf-lit bnf-unknown")))))))
  (define rule-name (make-parameter #f))
  (define (render-help p #:start [start #f])
    (cond
      [(pattern-seq? p)
       (add-between (map render-help (pattern-seq-vals p)) " ")]
      [(pattern-maybe? p)
       (list (meta "[") (render-help (pattern-maybe-val p)) (meta "]"))]
      [(pattern-repeat? p)
       (list (meta "(") (render-help (pattern-repeat-val p)) (meta ")")
             (if (= 0 (pattern-repeat-min p)) (meta "*") (meta "+")))]
      [(pattern-choice? p)
       (define choices (pattern-choice-vals p))
       (define pat-breaks
         (filter (λ(i) i)
                 (for/list
                  ([c1 choices] [c2 (rest choices)])
                  (if (> (pos-line (pattern-start c2)) (pos-line (pattern-start c1))) c2 #f))))
       (define breaks
         (if (> (pos-line (pattern-start (first choices))) (pos-line (pattern-start p)))
             (cons (first choices) pat-breaks)
             pat-breaks))
       (define indent (string-append "\n" (make-string (+ 2 (* 2 (string-length (rule-name)))) #\space)))
       (define translated
         (map (λ(c)
                (list (if (member c breaks) indent "")
                      (meta " | ")
                      (render-help c))) choices))
       (if (and start (> (pos-line (pattern-start (first choices))) (pos-line start)))
           (cons indent (flatten translated))
           (drop (flatten translated) 2))]
      [(pattern-token? p)
       (define tok (assoc (pattern-token-val p) names))
       (cond
         [tok (lit (second tok))]
         [else (unknown-lit (pattern-token-val p))])]
      [(pattern-lit? p)
       (lit (pattern-lit-val p))]
      [(pattern-id? p)
       (prod-link grammar (pattern-id-val p))]
      [(pattern-epsilon? p)
       (eps)]
      [else
       (printf "Unknown prod: ~a" p)]))

  (nested #:style (make-style 'code-inset (list (attributes '((style . "white-space: pre;")))))
          (add-between
           (for/list [(p prods)]
             (parameterize ([rule-name (lhs-id-val (rule-lhs p))])
               (list (elemtag (prod-tag grammar (rule-name))
                              (elem (prod-ref (rule-name))
                                    #:style (make-style #f (list (attributes '((class . "bnf-rule")))))))
                     (meta ":")
                     " "
                     (render-help (rule-pattern p) #:start (rule-start p)))))
           "\n")
          )
  )

(define (bnf grammar . stx)
   (define text (string-join stx ""))
   (define text-port (open-input-string text))
   (port-count-lines! text-port)
   (define parsed (grammar-parser (tokenize text-port)))
   (render grammar parsed)
   )
