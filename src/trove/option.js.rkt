#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(define s-some-args (list `("value" ("type" "normal") ("contract" ,(a-id "a")))))

@(append-gen-docs
'(module
  "option"
  (path "src/arr/base/option.arr")
  (data-spec
    (name "Option")
    (type-vars (a16))
    (variants ("none" "some"))
    (shared ()))
  
  (singleton-spec
    (name "none")
    (with-members
      ((method-spec
        (name "or-else")
        (arity 2)
        (params ())
        (args ("self" "v"))
        (return "a")
        (contract
          (a-arrow (a-id "is-Option" (xref "option" "is-Option")) "a" "a"))
        (doc "Return the default provided value"))
      (method-spec
        (name "and-then")
        (arity 2)
        (params ("b"))
        (args ("self" "$underscore"))
        (return (a-app (a-id "Option" (xref "option" "Option")) "b"))
        (contract
          (a-arrow
            (a-id "is-Option" (xref "option" "is-Option"))
            (a-arrow "a" "b")
            (a-app (a-id "Option" (xref "option" "Option")) "b")))
        (doc "Return none")))))
  (fun-spec
    (name "is-none")
    (arity 1)
    (params [list: ])
    (args ("val"))
    (return (a-id "Boolean" (xref "<global>" "Boolean")))
    (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
    (doc "Checks whether the provided argument is in fact a none"))
  (constr-spec
    (name "some")
    (members (("value" (type normal) (contract "Any"))))
    (with-members
      ((method-spec
        (name "or-else")
        (arity 2)
        (params ())
        (args ("self" "v"))
        (return "a")
        (contract
          (a-arrow (a-id "is-Option" (xref "option" "is-Option")) "a" "a"))
        (doc "Return self.value, rather than the default"))
      (method-spec
        (name "and-then")
        (arity 2)
        (params ("b"))
        (args ("self" "f"))
        (return (a-app (a-id "Option" (xref "option" "Option")) "b"))
        (contract
          (a-arrow
            (a-id "is-Option" (xref "option" "is-Option"))
            (a-arrow "a" "b")
            (a-app (a-id "Option" (xref "option" "Option")) "b")))
        (doc "Returns the function applied to self.value")))))
  (fun-spec
    (name "is-some")
    (arity 1)
    (params [list: ])
    (args ("val"))
    (return (a-id "Boolean" (xref "<global>" "Boolean")))
    (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
    (doc "Checks whether the provided argument is in fact a some"))))

@docmodule["option"]{
  @; Ignored type testers
  @section{The Option Datatype}

  @data-spec2["Option" (list "a") (list
    @singleton-spec2["Option" "none"]
    @constructor-spec["Option" "some" s-some-args]
  )]

  @nested[#:style 'inset]{
  @singleton-doc["Option" "none" (O-of "a")]
  @constructor-doc["Option" "some" s-some-args (O-of "a")]

  @function["is-none" #:alt-docstrings ""]
  @function["is-some" #:alt-docstrings ""]
  }

@pyret{Option} implements a functional programming idiom that is often used
when a function may or may not return a valid or meaningful value.  If there
is no return value, then @pyret{none} is returned.  If there is a meaningful
return value, the value is wrapped in the @pyret{some} variant.

Some Pyret library functions return @pyret{Option} values, such as
@pyret{string-to-number}.  In this case, if the string is not a
valid numeric value, @pyret{none} is returned; otherwise, the
numeric value is wrapped in @pyret{some}.  A @pyret{cases} expression
can be used to evaluate both @pyret{Option} response variants.


@examples{ 
fun set-angle(s :: String) -> Number:
  doc: "If s is not a numeric string, default to 0."
  cases(Option) string-to-number(s):
    |some(a) => a
    |none => 0
  end
where:
  set-angle("90") is 90
  set-angle("") is 0
  set-angle("x") is 0
end
}

In an contrasting example, the @pyret{string-index-of} function does
@italic{not} provide an @pyret{Option} return value, but instead returns a
@pyret{Number} which is either a valid index @pyret{Number} or
@tt{-1} if the string is not found.

@examples{
fun find-smiley(s :: String) -> String:
  i = string-index-of(s, "😊")
  ask:
    | i == -1 then: "No smiley!"
    | otherwise: string-append("Smiley at ", num-to-string(i))
  end
where:
  find-smiley("abcd") is "No smiley!"
  find-smiley("a😊cd") is "Smiley at 1"
end
}

If you wanted to create a version of @tt{find-smiley} that returned an
@pyret{Option} value, it might look like this:

@examples{
fun option-smiley(s :: String) -> Option:
  i = string-index-of(s, "😊")
  ask:
    | i == -1 then: none
    | otherwise: some(i)
  end
where:
  option-smiley("abcd") is none
  option-smiley("a😊cd") is some(1)
end
}

@section{Option Methods}
  @method-doc["Option" "some" "and-then" #:alt-docstrings ""]

  For @pyret-id{none}, returns @pyret-id{none}.  For @pyret-id{some}, applies
  @pyret{f} to the @pyret{value} field and returns a new @pyret-id{some} with the
  updated value.

@examples{
check:
  add1 = lam(n): n + 1 end
  n = none
  n.and-then(add1) is none
  s = some(5)
  s.and-then(add1) is some(6)
end
}

  @method-doc["Option" "some" "or-else" #:alt-docstrings ""]

  For @pyret-id{none}, returns @pyret{v}.  For @pyret-id{some}, returns the
  @pyret{value} field.  Useful for providing default values.

@examples{
check:
  n = none
  n.or-else(42) is 42
  
  s = some(5)
  s.or-else(10) is 5
end
}

Our example above of @tt{set-angle}, which defaults to @tt{0}, could be
replaced with:

@examples{
check: 
  string-to-number("90").or-else(0) is 90
  string-to-number("x").or-else(0) is 0
end
}
  }
