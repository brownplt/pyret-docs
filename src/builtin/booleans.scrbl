#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(append-gen-docs
  '(module "booleans"
    (path "src/js/base/runtime-anf.js")
    (form-spec (name "and"))
    (form-spec (name "or"))
    (data-spec
      (name "Boolean")
      (variants)
      (shared))
    (fun-spec
      (name "not")
      (arity 1)
      (args ("b"))
      (return (a-id "Boolean" (xref "<global>" "Boolean")))
      (doc "Negates the boolean value"))))

@docmodule["booleans" #:noimport #t #:friendly-title "Booleans"]{
  @type-spec["Boolean" (list)]{

  The type of the values @pyret{true} and @pyret{false}.}

  @section{Boolean Functions}

  @function["not" #:contract (a-arrow B B) #:return B #:alt-docstrings ""]

  Returns @pyret{true} when given @pyret{false} and vice versa.

@examples{
check:
  not(true) is false
  not(2 < 1) is true
end
}
  @section{Boolean Operators}

@form["and" "<left> and <right>"]{
  @margin-note{
  The @pyret{and} operator has “short-circuiting” behavior: if @pyret{left}
  evaluates to @pyret{false}, then @pyret{right} is not evaluated at all and the
  result is @pyret{false}.
  }
  Expects @pyret{left} and @pyret{right} to be @pyret{Boolean}s.
  If both are
  @pyret{true}, the result is @pyret{true}, if either is @pyret{false}, the
  result is @pyret{false}.
}

@form["or" "<left> or <right>"]{
  @margin-note{
  The @pyret{or} operator has “short-circuiting” behavior: if @pyret{left}
  evaluates to @pyret{true}, then @pyret{right} is not evaluated at all and the
  result is @pyret{true}.
  }
  Expects @pyret{left} and @pyret{right} to be @pyret{Boolean}s.
  If either is
  @pyret{true}, the result is @pyret{true}, if both are @pyret{false}, the
  result is @pyret{false}.
}

  
}

