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
    (fun-spec (name "modes") (arity 1))
    (fun-spec (name "has-mode") (arity 1))
    (fun-spec (name "mode-smallest") (arity 1))
    (fun-spec (name "mode-largest") (arity 1))

    (fun-spec (name "lin-reg-2V") (arity 2))

    (data-spec
      (name "StatModel")
      (variants ("simple-linear-model"))
      (constr-spec 
        (name "simple-linear-model")
        (members 
          (("alpha" (type normal) (contract "Number"))
          ("beta" (type normal) (contract "Number")))))
      (shared
        ((method-spec
          (name "predictor")
          (arity 1)
          (params ())
          (args ("self"))
          (return (a-arrow (a-id "Number" (xref "<global>" "Number"))
                           (a-id "Number" (xref "<global>" "Number"))))
          (contract
            (a-arrow
              (a-id "is-StatModel" (xref "statistics" "is-StatModel"))
              (a-arrow (a-id "Number" (xref "<global>" "Number"))
                       (a-id "Number" (xref "<global>" "Number"))))))
         (method-spec
          (name "apply")
          (arity 2)
          (params ())
          (args ("self" "l"))
          (return (a-app (a-id "List" (xref "lists" "List")) (a-id "Number" (xref "<global>" "Number"))))
          (contract
            (a-arrow
              (a-id "is-StatModel" (xref "statistics" "is-StatModel"))
              (a-app (a-id "List" (xref "lists" "List")) (a-id "Number" (xref "<global>" "Number")))
              (a-app (a-id "List" (xref "lists" "List")) (a-id "Number" (xref "<global>" "Number")))))
         )
         (method-spec
          (name "r-squared")
          (arity 1)
          (params ())
          (args ("self"))
          (return (a-id "Number" (xref "<global>" "Number")))
          (contract
            (a-arrow
              (a-id "is-StatModel" (xref "statistics" "is-StatModel"))
              (a-id "Number" (xref "<global>" "Number"))))
         )
        )
      )
    )
   )
 )

@(define (statmodel-method name)
  (method-doc "StatModel" "simple-linear-model" name #:alt-docstrings ""))

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
    check:
      mean([list: ]) raises "Empty List"
      mean([list: 1]) is 1
      mean([list: 2, 2, 4.5, 1.5, 1, 1]) is 2
    end
  }
  }
  
  @function["median"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the median of the numbers in @pyret{l}.  If the list is of even
  length, returns the average of the two middle-most values.
  
  @examples{
    check:
      median([list: ]) raises "Empty List"
      median([list: 2]) is 2
      median([list: -1, 0, 1, 2, 5]) is 1
    end
  }
  }

  @function["modes"
    #:contract (a-arrow (L-of N) (L-of N))
    #:args '(("l" #f))
    #:return (L-of N)
    ]{
    Calculates the modes of the numbers in @pyret{l}.  If no number appears
  more than once, returns the empty list.  The modes will be returned in sorted order.

  @examples{
  check:
    modes([list: ]) is [list: ]
    modes([list: 1, 2, 3, 4]) is [list: 1]
    modes([list: 1, 2, 1, 2, 2, 1]) is [list: 1, 2]
  end
  }
  }

  @function["has-mode"
    #:contract (a-arrow (L-of N) B)
    #:args '(("l" #f))
    #:return B
    ]{
    Determines if a list of numbers has any modes, i.e., any repeated values.

  @examples{
  check:
    has-mode([list: ]) is false
    has-mode([list: 1, 2, 3, 4]) is false
    has-mode([list: 1, 2, 2, 1, 2, 2]) is true
    has-mode([list: 1, 2, 3, 2]) is true
  end
  }
  }

  @function["mode-smallest"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
    ]{
    Returns the smallest mode of a list of numbers, if any is present.

  @examples{
  check:
    mode-smallest([list: ]) raises "empty" 
    mode-smallest([list: 1]) raises "no duplicate values"
    mode-smallest([list: 1, 2, 3, 4, 5]) raises "no duplicate values"
    mode-smallest([list: 1, 1, 2]) is 1
    mode-smallest([list: 1, 2, 1, 2]) is 1
  end
  }
  }

  @function["mode-largest"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
    ]{
    Returns the largest mode of a list of numbers, if any is present.

  @examples{
  check:
    mode-smallest([list: ]) raises "empty" 
    mode-smallest([list: 1]) raises "no duplicate values"
    mode-smallest([list: 1, 2, 3, 4, 5]) raises "no duplicate values"
    mode-smallest([list: 1, 1, 2]) is 1
    mode-smallest([list: 1, 2, 1, 2]) is 2
  end
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
    check:  
      stdev([list: ]) raises "Empty List"
      stdev([list: 2]) is 0
      stdev([list: 2, 4, 4, 4, 5, 5, 7, 9]) is 2
    end 
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
  @section{StatModel Methods}
  
  Below are all of the methods that can be used by variants of the StatModel
  data type.  Some methods are specific to certain variants;  these methods
  will specify which variant uses which.

  @statmodel-method["predictor"]
  Returns the linear predictor function for a simple-linear-model variant.

  @statmodel-method["apply"]
  Applies the linear predictor for a simple-linear-model to a list of numerical
  data.

  @statmodel-method["r-squared"]
  Gives the coefficient of correlation for a simple-linear-model.

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
    check:
      lin-reg-2V([list: 0, 1, 2, 3], [list: 3, 2, 1, 0]) is StatModel(3, -1, 1)
    end
  }
  }
}
