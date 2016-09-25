#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")
@(require (only-in scribble/core delayed-block))

@(define (link T) (a-id T (xref "statistics" T)))
@(define (t-field name ty) (a-field (tt name) ty))

@(define (t-record . rest)
   (apply a-record (map tt (filter (lambda (x) (not (string=? x "\n"))) rest))))

@(append-gen-docs
  `(module "math"
    (path "src/arr/trove/math.arr")

    (fun-spec (name "sum") (arity 1))
    (fun-spec (name "max") (arity 1))
    (fun-spec (name "min") (arity 1))
    (fun-spec (name "arg-min") (arity 1))
    (fun-spec (name "arg-max") (arity 1))
   ))

@docmodule["math"]{
  The Pyret Math library.  It consists of functions for arithmetic
  calculations, optimization, and more to come!

  Every function in this library is available on the @tt{math} module
  object.  For example, if you used @pyret{import math as M}, you would
  write @pyret{S.arg-max} to access @pyret{arg-max} below.  If you used
  @pyret{include}, then you can refer to identifiers without writing @pyret{M.}
  as a prefix.  
  
  @;#########################################################################
  @section{Arithmetic Functions}
  @function["sum"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the arithmetic sum of the Numbers in @pyret{l}.  If @pyret{l}
  contains at least one RoughNum, then the output will be a RoughNum.

  @examples{
  sum([list: 0, 2, 4])
  sum([list: -1, 1, ~2])
  }
  }

  @;#########################################################################
  @section{Minimization & Maximization}
  
  @function["max"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the maximal element of the set of Numbers in @pyret{l}.
  
  @examples{
  max([list: 2.1, 2, 4.5, ~1.5, -1, 1])
  }
  }
  
  @function["min"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the minimal element of the set of Numbers in @pyret{l}.

  @examples{
  min([list: -1, 0, ~1, 2, 5])
  }
  }

  @function["arg-max"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the index of the maximal element within @pyret{l}.
  
  @examples{
  arg-max([list: -1, 0, ~1, 2, 5])
  }
  }
  @function["arg-min"
    #:contract (a-arrow (L-of N) N)
    #:args '(("l" #f))
    #:return N
  ]{
  Calculates the index of the minimal element within @pyret{l}.
  
  @examples{
  arg-max([list: -1, 0, ~1, 2, 5])
  }
  }
}
