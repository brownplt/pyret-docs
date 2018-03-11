#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt" (only-in scribble/manual math))

@(define PPD (a-id "PPrintDoc" (xref "pprint" "PPrintDoc")))
@(define (make-arg name type)
   `(,name ("type" "normal") ("contract" ,type)))

@(define (ppd-method name)
  (method-doc "PPrintDoc" #f name #:alt-docstrings ""))


@(append-gen-docs
`(module
  "pprint"
  (path "src/arr/trove/pprint.arr")
  (data-spec
    (name "PPrintDoc")
    (type-vars ())
    (variants)
    (shared
      ((method-spec
        (name "_plus")
        (arity 2)
        (params ())
        (args ("self" "other"))
        (return ,PPD)
        (contract
          (a-arrow ,PPD ,PPD ,PPD)))
      (method-spec
        (name "_output")
        (arity 1)
        (params ())
        (args ("self"))
        (return "Any")
        (contract
          (a-arrow ,PPD "Any")))
      (method-spec
        (name "pretty")
        (arity 2)
        (params ())
        (args ("self" "width"))
        (return ,(L-of S))
        (contract
          (a-arrow ,PPD ,N ,(L-of S)))))))
  (unknown-item
    (name "mt-doc")
    ;; ~mt-doc18(0, false)
    )
  (fun-spec
    (name "is-mt-doc")
    (arity 1)
    (params [list: ])
    (args ("val"))
    (return (a-id "Boolean" (xref "<global>" "Boolean")))
    (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
    (doc "Checks whether the provided argument is in fact a mt-doc"))
  (fun-spec
    (name "str")
    (arity 1)
    (params [list: ])
    (args ("s"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "number")
    (arity 1)
    (params [list: ])
    (args ("n"))
    (return "Any")
    (contract (a-arrow (a-id "Number" (xref "<global>" "Number")) "Any")))
  (unknown-item
    (name "hardline")
    ;; ~hardline22(0, true)
    )
  (fun-spec
    (name "blank")
    (arity 1)
    (params [list: ])
    (args ("n"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "sbreak")
    (arity 1)
    (params [list: ])
    (args ("n"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "concat")
    (arity 2)
    (params [list: ])
    (args ("fst" "snd"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any")))
  (fun-spec
    (name "nest")
    (arity 2)
    (params [list: ])
    (args ("n" "d"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any")))
  (fun-spec
    (name "if-flat")
    (arity 2)
    (params [list: ])
    (args ("flat" "vert"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any")))
  (fun-spec
    (name "group")
    (arity 1)
    (params [list: ])
    (args ("d"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "flow")
    (arity 1)
    (params [list: ])
    (args ("items"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "flow-map")
    (arity 3)
    (params [list: ])
    (args ("sep" "f" "items"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any" "Any")))
  (fun-spec
    (name "vert")
    (arity 1)
    (params [list: ])
    (args ("items"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "parens")
    (arity 1)
    (params [list: ])
    (args ("d"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "braces")
    (arity 1)
    (params [list: ])
    (args ("d"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "brackets")
    (arity 1)
    (params [list: ])
    (args ("d"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "dquote")
    (arity 1)
    (params [list: ])
    (args ("s"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "squote")
    (arity 1)
    (params [list: ])
    (args ("s"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "align")
    (arity 1)
    (params [list: ])
    (args ("d"))
    (return "Any")
    (contract (a-arrow "Any" "Any")))
  (fun-spec
    (name "align-spaces")
    (arity 3)
    (params [list: ])
    (args ("d"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any" "Any")))
  (fun-spec
    (name "hang")
    (arity 2)
    (params [list: ])
    (args ("i" "d"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any")))
  (fun-spec
    (name "prefix")
    (arity 4)
    (params [list: ])
    (args ("n" "b" "x" "y"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any" "Any" "Any")))
  (fun-spec
    (name "infix")
    (arity 5)
    (params [list: ])
    (args ("n" "b" "op" "x" "y"))
    (return "Any")
    (contract
      (a-arrow
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        "Any")))
  (fun-spec
    (name "infix-break")
    (arity 5)
    (params [list: ])
    (args ("n" "b" "op" "x" "y"))
    (return "Any")
    (contract
      (a-arrow
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        "Any")))
  (fun-spec
    (name "separate")
    (arity 2)
    (params [list: ])
    (args ("sep" "docs"))
    (return "Any")
    (contract
      (a-arrow
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-dot "lists" "List")
        "Any")))
  (fun-spec
    (name "surround")
    (arity 5)
    (params [list: ])
    (args ("n" "b" "open" "contents" "close"))
    (return "Any")
    (contract
      (a-arrow
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        "Any")))
  (fun-spec
    (name "soft-surround")
    (arity 5)
    (params [list: ])
    (args ("n" "b" "open" "contents" "close"))
    (return "Any")
    (contract
      (a-arrow
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        "Any")))
  (fun-spec
    (name "surround-separate")
    (arity 7)
    (params [list: ])
    (args ("n" "b" "void" "open" "sep" "close" "docs"))
    (return "Any")
    (contract
      (a-arrow
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "Number" (xref "<global>" "Number"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-id "PPrintDoc" (xref "pprint" "PPrintDoc"))
        (a-dot "lists" "List")
        "Any")))
  (fun-spec
    (name "label-align-surround")
    (arity 5)
    (params [list: ])
    (args ("label" "open" "sep" "contents" "close"))
    (return "Any")
    (contract (a-arrow "Any" "Any" "Any" "Any" "Any" "Any")))
  (unknown-item
    (name "lparen")
    ;; str187("(")
    )
  (unknown-item
    (name "rparen")
    ;; str187(")")
    )
  (unknown-item
    (name "lbrace")
    ;; str187("{")
    )
  (unknown-item
    (name "rbrace")
    ;; str187("}")
    )
  (unknown-item
    (name "lbrack")
    ;; str187("[")
    )
  (unknown-item
    (name "rbrack")
    ;; str187("]")
    )
  (unknown-item
    (name "langle")
    ;; str187("<")
    )
  (unknown-item
    (name "rangle")
    ;; str187(">")
    )
  (unknown-item
    (name "comma")
    ;; str187(",")
    )
  (unknown-item
    (name "commabreak")
    ;; comma199 + ~sbreak200(1)
    )))
  


@docmodule["pprint"]{
  @; Ignored type testers
  @ignore[(list "is-mt-doc" "align-spaces")]
  @; Unknown: PLEASE DOCUMENT
  @ignore[
    (list
      "mt-doc"
      "hardline"
      "lparen"
      "rparen"
      "lbrace"
      "rbrace"
      "lbrack"
      "rbrack"
      "langle"
      "rangle"
      "comma"
      "commabreak")
  ]
  @section{The PPrintDoc Datatype}
  This datatype is @emph{not} exported directly to users; there are
  @seclink[#:tag-prefixes '("pprint_Functions") "Functions"]{easier-to-use
  helper functions} that are exported instead.
  @data-spec2["PPrintDoc" '() (list
    @constructor-spec["PPrintDoc" "mt-doc" `(,(make-arg "flat-width" N)
                                             ,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "str" `(,(make-arg "s" S)
                                          ,(make-arg "flat-width" N)
                                          ,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "hardline" `(,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "blank" `(,(make-arg "n" N)
                                            ,(make-arg "flat-width" N)
                                            ,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "concat" `(,(make-arg "fst" PPD)
                                             ,(make-arg "snd" PPD)
                                             ,(make-arg "flat-width" N)
                                             ,(make-arg "has-hardline" B))]
                                          
    @constructor-spec["PPrintDoc" "nest" `(,(make-arg "indent" N)
                                           ,(make-arg "d" PPD)
                                           ,(make-arg "flat-width" N)
                                           ,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "if-flat" `(,(make-arg "flat" PPD)
                                              ,(make-arg "vert" PPD)
                                              ,(make-arg "flat-width" N)
                                              ,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "align" `(,(make-arg "d" PPD)
                                            ,(make-arg "flat-width" N)
                                            ,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "align-spaces" `(,(make-arg "n" N)
                                                   ,(make-arg "flat-width" N)
                                                   ,(make-arg "has-hardline" B))]
    @constructor-spec["PPrintDoc" "group" `(,(make-arg "D" PPD)
                                            ,(make-arg "flat-width" N)
                                            ,(make-arg "has-hardline" B))]
  )]

  @nested[#:style 'inset]{
    Each of the raw constructors for @pyret-id{PPrintDoc} contains two
         fields that memoize how wide the document is when printed
         flat, and whether the document contains a hard linebreak.
    @constructor-doc["PPrintDoc" "mt-doc" `(,(make-arg "flat-width" N)
                                            ,(make-arg "has-hardline" B))
                     PPD #:private #t]{
    Represents an empty document.
    }
    @constructor-doc["PPrintDoc" "str" `(,(make-arg "s" S)
                                         ,(make-arg "flat-width" N)
                                         ,(make-arg "has-hardline" B)) PPD #:private #t]{
    Represents a simple string, that cannot be broken into smaller
    pieces.  Any whitespace in this string is treated as a normal,
    unbreakable character.
    }
    @constructor-doc["PPrintDoc" "hardline" `(,(make-arg "has-hardline" B)) PPD #:private #t]{
    Forces a line break: no group containing this document can print
    flat.
    }
    @constructor-doc["PPrintDoc" "blank" `(,(make-arg "n" N)
                                           ,(make-arg "flat-width" N)
                                           ,(make-arg "has-hardline" B)) PPD #:private #t]{
    Represents @math{n} spaces.  (This is
    simply a memory optimization over storing a @pyret{str} of the
    actual whitespace string.)
    }
    @constructor-doc["PPrintDoc" "concat" `(,(make-arg "fst" PPD)
                                            ,(make-arg "snd" PPD)
                                            ,(make-arg "flat-width" N)
                                            ,(make-arg "has-hardline" B))
                     PPD #:private #t]{
    Represents printing two documents, one after another.  PPrintDoc both
    documents will be printed in flat mode, or neither will.
    }
    @constructor-doc["PPrintDoc" "nest" `(,(make-arg "indent" N)
                                          ,(make-arg "d" PPD)
                                          ,(make-arg "flat-width" N)
                                          ,(make-arg "has-hardline" B)) PPD #:private #t]{
    Adds @math{n} spaces to any line breaks that result from printing the
    given document in vertical mode.  This forms an indented paragraph.
    }
    @constructor-doc["PPrintDoc" "if-flat" `(,(make-arg "flat" PPD)
                                             ,(make-arg "vert" PPD)
                                             ,(make-arg "flat-width" N)
                                             ,(make-arg "has-hardline" B)) PPD #:private #t]{
    Allows choosing between two documents, depending on whether the document
    is being printed flat or not.  This can be used to implement soft line
    breaks, which turn into whitespace when flat.
    }
    @constructor-doc["PPrintDoc" "align" `(,(make-arg "d" PPD)
                                           ,(make-arg "flat-width" N)
                                           ,(make-arg "has-hardline" B)) PPD #:private #t]{
    This aligns its nested content to the current column.  (Unlike
    @pyret-id{nest}, which adds or removes indentation relative to the current
    indentation, this aligns to the current position regardless of current
    indentation.) 
    }
    @constructor-doc["PPrintDoc" "align-spaces" `(,(make-arg "n" N)
                                                  ,(make-arg "flat-width" N)
                                                  ,(make-arg "has-hardline" B)) PPD #:private #t]{
    In flat mode, this vanishes, but in vertical mode it adds a linebreak and a
    given number of spaces to the next line.
    }
    @constructor-doc["PPrintDoc" "group" `(,(make-arg "D" PPD)
                                           ,(make-arg "flat-width" N)
                                           ,(make-arg "has-hardline" B)) PPD #:private #t]{
    This applies ``scoping'' to the current nesting level or flatness mode.  If
    a group can be typeset  in flat mode, it will, regardless of the
    surrounding mode.
    }
  }
  
@section{PPrintDoc Methods}

These methods are available on all @pyret-id{PPrintDoc}s.

@ppd-method["_plus"]
Combines two @pyret-id{PPrintDoc}s into a single document.
@ppd-method["_output"]
Internal method for displaying the structure of this @pyret-id{PPrintDoc}.
@ppd-method["pretty"]
Renders this @pyret-id{PPrintDoc} at the desired line width.  Returns a list of
the individual lines of output.
  
  @section[#:tag-prefix "pprint_Functions"]{Functions}
  @function["str"]{Constructs a document containing the given string.  Any
  whitespace in this string is considered unbreakable.}
  @function["number"]{Constructs a document containing the number @math{n} printed as a
  string.  This is merely a convenient shorthand for
  @pyret-id{str}@pyret{(}@pyret-id["tostring" "<global>"]@pyret{(n))}.}
  @function["blank"]{Produces the requested number of non-breaking spaces.}
  @function["sbreak"]{When typeset in flat mode, this produces the requested
  number of non-breaking spaces.  When typeset in vertical mode, produces a
  single linebreak.}
  @function["concat"]{Combines two documents into one, consecutively.}
  @function["nest"]{Adds @math{n} to the current indentation level while
  typesetting the given document.}
  @function["if-flat"]{Allows choosing between two documents, depending on
  whether this combined document is typeset in flat mode or not.}
  @function["group"]{Wraps the given document in a group, so that it can be
  typeset in flat mode (if possible) even if the surrounding document is in
  vertical mode.  This helps ensure that linebreaks happen at the ``outer''
  layers of the document, and nested groups stay intact whenever possible.}
  @function["flow"]{Combines a given list of documents with soft line breaks.
  When given a list of words, for example, this produces a paragraph that
  automatially line-wraps to fit the available space.}
  @function["vert"]{Combines a given list of documents with hard line breaks.
  Note that unless the individual items are @pyret-id{group}ed, this will cause
  them all to be typeset vertically as well.}
  @function["flow-map"]{A shorthand to @pyret-id["map" "lists"] a given list of values into a list
  of documents, then combine them with some separator via @pyret-id{separate}.}
  @function["parens"]{Surrounds the given document in parentheses, and
  surrounds them all in a @pyret-id{group}.}
  @function["braces"]{Surrounds the given document in curly braces, and
  surrounds them all in a @pyret-id{group}.}
  @function["brackets"]{Surrounds the given document in square brackets, and
  surrounds them all in a @pyret-id{group}.}
  @function["dquote"]{Surrounds the given document in double-quotes, and
  surrounds them all in a @pyret-id{group}.}
  @function["squote"]{Surrounds the given document in single-quotes, and
  surrounds them all in a @pyret-id{group}.}
  @function["align"]{Aligns the given document to the current column, wherever
  it might be.}
  @function["hang"]{Typesets the given document with a hanging indent of the
  given length.  The first line is typeset at the current position, and the
  remaining lines are all indented.}
  @function["prefix"]{Takes two documents and typesets them together as a
  pyret-id{group}.  If they can fit on one line, this is equivalent to
  concatenating them.  Otherwise, this increases the @pyret-id{nest}ing level
  of the second document by @math{n}.}
  @function["infix"]{Typesets infix operators as a @pyret-id{group}, preferring to break lines after
  the operator.  Surrounds the operator with @math{b} blank spaces on either
  side, and indents any new lines by @math{n} spaces.}
  @function["infix-break"]{Typesets infix operators as a @pyret-id{group}, preferring to break lines before
  the operator.  Surrounds the operator with @math{b} blank spaces on either
  side, and indents any new lines by @math{n} spaces.}
  @function["separate"]{Interleaves each document of the provided list with the
  given separator document.}
  @function["surround"]{Given a document with many potential line breaks, and
  an opening and a closing document to surround it with, this function produces
  a document that either typesets everything on one line with @math{b} spaces
  between the contents and the enclosing documents, or typesets the opening,
  closing and contents on separate lines and indents the contents by @math{n}.
  Useful for typesetting things like data definitions, where each variant goes
  on its own line, as does the @pyret{data} and @pyret{end} keywords.}
  @function["soft-surround"]{Like @pyret-id{surround}, but tries to keep the
  closing document on the same line as the last line of the contents.  Useful
  for typesetting things like s-expressions, where the closing parentheses look
  better on the last line of the content.}
  @function["surround-separate"]{A combination of @pyret-id{surround} and
  @pyret-id{separate}.  Useful for typesetting delimited, comma-separated lists
  of items, or similar other other output.}
  @function["label-align-surround"]{Similar to @pyret-id{soft-surround}, but
  with different alignment.}
}
