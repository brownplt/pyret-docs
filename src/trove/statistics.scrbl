#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")
@(require (only-in scribble/core delayed-block))

@(define (link T) (a-id T (xref "statistics" T)))
@(define Color (a-id "Color" (xref "image-structs" "Color")))
@(define (t-field name ty) (a-field (tt name) ty))

@(define (t-record . rest)
   (apply a-record (map tt (filter (lambda (x) (not (string=? x "\n"))) rest))))

@(append-gen-docs
  `(module "statistics"
    (path "src/arr/trove/statistics.arr")

    (fun-spec (name "mean") (arity 1))
    (fun-spec (name "median") (arity 1))
    (fun-spec (name "stdev") (arity 1))
    (fun-spec (name "distinct") (arity 1))

    (fun-spec (name "lin-reg-2V") (arity 2))

    (data-spec
      (name "StatModel")
      (variants ("simple-linear-model")))
  ))

@docmodule["statistics"]{
  The Pyret Statistics library.  It consists of functions that calculate 
  relevant statistical values of data sets, and functions for statistical
  modeling of numerical data.

  Every function in this library is available on the @tt{statistics} module
  object.  For example, if you used @pyret{import statistics as S}, you would
  write @pyret{S.median} to access @pyret{median} below.  If you used
  @pyret{include}, then you can refer to identifiers without writing @pyret{S.}
  as a prefix.  

  @;#########################################################################
  @section{Basic Statistical Values}
  
  @function["mean"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the arithmetic mean of the numbers in @pyret{l}.
  
  @examples{
  mean([list: 2, 2, 4.5, 1.5, 1, 1])
  }
  }
  
  @function["median"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the median of the numbers in @pyret{l}.
  
  @examples{
  median([list: -1, 0, 1, 2, 5])
  }
  }

  @function["stdev"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Gives the standard deviation of the data set represented by
  numbers in @pyret{l}.
  
  @examples{
  stdev([list: -1, 0, 1, 2, 5])
  }
  }

  @;#########################################################################
  @section{The StatModel Type}

  Each variant of the StatModel type represents a different kind of
  statistical model.  These variants have their own methods that allow prediction
  of data, and access to meta-data about the model.

  Below is the documentation for the variants of the StatModel type, and the
  members and methods of each.  Note that the methods for a particular variant
  will be prefixed with a dot.

  @data-spec2["StatModel" (list) (list
  @constructor-spec["StatModel" "simple-linear-model" `(("alpha" ("type" "normal") ("contract", N))
                                                        ("beta"  ("type" "normal") ("contract", N)))])]
  @nested[#:style `inset]{

  @constructor-doc["StatModel" "simple-linear-model" `(("alpha" ("type" "normal") ("contract", N)) 
                                                        ("beta"  ("type" "normal") ("contract", N))) (link "StatModel")]{
  
    Models the relationship between a single explanatory variable, and a dependent
    variable using a linear predictor function.

    @member-spec["alpha" #:type "normal" #:contract N]{
      The y-intercept of the linear predictor function.
    }

    @member-spec["beta" #:type "normal" #:contract N]{
      The slope of the linear predictor function.
    }
  }
  }

  @;############################################################################
  @section{Regression and Modeling}

  Each of these functions is used to perform a regression by creating
  a certain variant of StatModel.

  @function["lin-reg-2V"
    #:contract (a-arrow (L-of N) (L-of N) (link "StatModel"))
    #:args '(("X" #f)("Y" #f))
    #:return (link "StatModel")
  ]{
  Calculates a linear regression to model simple independent -> dependent
  variable relationship.  Uses Ordinary Least Squares.
    
  @examples{
    lin-reg-2V([list: 0, 1, 2, 3], [list: 3, 2, 1, 0])
  }
  }
}

