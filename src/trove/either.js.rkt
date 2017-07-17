#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(define left-args (list `("v" ("type" "normal") ("contract" ,(a-id "a")))))
@(define right-args (list `("v" ("type" "normal") ("contract" ,(a-id "b")))))

@(append-gen-docs
  '(module
  "either"
  (path "src/arr/base/either.arr")
  (data-spec
    (name "Either")
    (type-vars (a16 b17))
    (variants ("left" "right"))
    (shared ()))
  
  (constr-spec
    (name "left")
    (members (("v" (type normal) (contract "a"))))
    (with-members ()))
  (fun-spec
    (name "is-left")
    (arity 1)
    (params [list: ])
    (args ("val"))
    (return (a-id "Boolean" (xref "<global>" "Boolean")))
    (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
    (doc "Checks whether the provided argument is in fact a left"))
  (constr-spec
    (name "right")
    (members (("v" (type normal) (contract "b"))))
    (with-members ()))
  (fun-spec
    (name "is-right")
    (arity 1)
    (params [list: ])
    (args ("val"))
    (return (a-id "Boolean" (xref "<global>" "Boolean")))
    (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
    (doc "Checks whether the provided argument is in fact a right"))))

@docmodule["either"]{
  @; Ignored type testers
  @section[#:tag "either_DataTypes"]{Data types}
  @data-spec2["Either" (list "a" "b") (list
    @constructor-spec["Either" "left" left-args]
    @constructor-spec["Either" "right" right-args]
  )]

  @nested[#:style 'inset]{
  @constructor-doc["Either" "left" left-args (E-of "a" "b")]
  @constructor-doc["Either" "right" right-args (E-of "a" "b")]

  @function["is-left" #:alt-docstrings ""]
  @function["is-right" #:alt-docstrings ""]
  }
  }

@pyret{Either} implements a functional programming idiom that is often used
when a function may return either a meaningful value or an error message.
By convention, the @pyret{left} variant is used to return an error, usually
as a string, and the @pyret{right} variant returns a valid value.

The following example is based on a function that searches for a student
with a specific numeric id in a list.  @tt{find-person-from-id} returns
@pyret{Either} a valid @tt{Person} as @pyret{right} or one of two
error messages as @pyret{String}s in @pyret{left}.

@examples{
import either as E

data Person:
  | student(id :: Number, name :: String)
end

people = [list: 
  student(001, "Charlie Brown"),
  student(002, "Sally Brown"),
  student(003, "Lucy van Pelt"),
  student(003, "Linus van Pelt")]

fun find-person-from-id(p :: List<Person>, i :: Number) -> E.Either:
  results = p.filter(lam(a): a.id == i end)
  result-count = results.length()
  ask:
    | result-count == 0 then: E.left("Not found error.")
    | result-count == 1 then: E.right(results.get(0))
    | otherwise: E.left("Duplicate ID error.")
  end
where:
  find-person-from-id(people, 007) is E.left("Not found error.")
  find-person-from-id(people, 001) is E.right(student(001, "Charlie Brown"))
  find-person-from-id(people, 003) is E.left("Duplicate ID error.")
end
}

Typically, the @pyret{Either} variants are processed by a @pyret{cases}
expression, for example:

@examples{
fun search(id :: Number):
  doc: "Hypothetical function calls resulting from either result."
  result = find-person-from-id(people, id)
  cases(E.Either) result:
    | left(s) => display-error-dialog(s)
    | right(p) => display-person(p)
  end
end
}

