#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(append-gen-docs
'(module
  "<global>"
  (path "src/js/base/runtime-anf.js")
  (data-spec
    (name "Any")
    (variants)
    (shared))
  (data-spec
    (name "Number")
    (variants)
    (shared))
  (data-spec
    (name "Boolean")
    (variants)
    (shared))
  (data-spec
    (name "String")
    (variants)
    (shared))
  (data-spec
    (name "Nothing")
    (variants)
    (shared))
  (data-spec
    (name "Function")
    (variants)
    (shared))
  (data-spec
    (name "RawArray")
    (variants)
    (shared))
  (data-spec
    (name "Method")
    (variants)
    (shared))
  (data-spec
    (name "Table")
    (variants)
    (shared))
  (data-spec
    (name "Object")
    (variants)
    (shared))
  (fun-spec
    (name "raise")
    (arity 1)
    (args ("val"))
    (return (a-id "Nothing" (xref "<global>" "Nothing")))
    (doc "Raises the value as an exception."))
  (fun-spec
    (name "print")
    (arity 1)
    (args ("val"))
    (doc "Displays the value"))
  (fun-spec
    (name "torepr")
    (arity 1)
    (args ("val"))
    (return (a-id "String" (xref "<global>" "String")))
    (doc "Creates a string representation of the value."))
  (fun-spec
    (name "to-repr")
    (arity 1)
    (args ("val"))
    (return (a-id "String" (xref "<global>" "String")))
    (doc "Creates a string representation of the value."))
  (fun-spec
    (name "tostring")
    (arity 1)
    (args ("val"))
    (return (a-id "String" (xref "<global>" "String")))
    (doc "Creates a string representation of the value"))
  (fun-spec
    (name "to-string")
    (arity 1)
    (args ("val"))
    (return (a-id "String" (xref "<global>" "String")))
    (doc "Creates a string representation of the value."))
  (fun-spec
    (name "is-boolean")
    (arity 1)
    (args ("val"))
    (doc "Returns true if the provided argument is a boolean, false if not."))
  (fun-spec
    (name "is-number")
    (arity 1)
    (args ("val"))
    (doc "Returns true if the provided argument is a number, false if not."))
  (fun-spec
    (name "is-string")
    (arity 1)
    (args ("val"))
    (doc "Returns true if the provided argument is a string, false if not."))
  (fun-spec
    (name "is-nothing")
    (arity 1)
    (args ("val"))
    (doc "Returns true if the provided argument is nothing, false if not."))
  (fun-spec
    (name "is-function")
    (arity 1)
    (args ("val"))
    (doc "Returns true if the provided argument is a function, false if not."))
  (fun-spec
    (name "is-object")
    (arity 1)
    (args ("val"))
    (doc "Returns true if the provided argument is an object, false if not."))
  (fun-spec
    (name "is-raw-array")
    (arity 1)
    (args ("val"))
    (doc "Returns true if the provided argument is a raw array, false if not."))

))

@docmodule["<global>" #:noimport #t #:friendly-title "Global Utilities"]{

@section[#:tag "global-builtins"]{Built-in Utility Functions}

@function["print" #:contract (a-arrow "a" "a") #:return "a" #:alt-docstrings ""]

Displays the provided value after first calling @pyret-id["to-repr"] on it,
then returns the value.

@function["torepr" #:contract (a-arrow A S) #:alt-docstrings ""]
@function["to-repr" #:contract (a-arrow A S) #:alt-docstrings ""]

Creates a string representation of the value that resembles an expression that
could be used to construct it.

The @pyret{to-repr} of a string yields a string containing the Pyret syntax
needed to write the original value as string literal: most characters are unchanged,
but quotes, newlines, tabs, and backslashes are all escaped, and the whole
value surrounded by quotes.

Functions are simply represented as @tt{"<function>"}.

@examples{
check:
  to-repr([list: 3, 5, 9]) is "[list: 3, 5, 9]"
  torepr("Hello, world.") is "\"Hello, world.\""
  to-repr("Hi.") == "Hi." is false
  to-repr((lam(i): i + 1 end)) is "<function>"
end
}

@function["tostring" #:contract (a-arrow A S) #:alt-docstrings ""]
@function["to-string" #:contract (a-arrow A S) #:alt-docstrings ""]

Creates a string representation of the value for display that is
value-dependent in some cases, such as error messages.  For built-in types
the output is identical to @pyret-id["torepr"], except for @pyret{String}s.

@examples{
check:
  # tostring does not wrap strings in quotes
  tostring("Hello, world.") is "Hello, world."
  to-string("Hi.") == "Hi." is true
end
}

@function["raise" #:contract (a-arrow A No) #:alt-docstrings ""]

Raises the value as an error.  This usually stops the program and reports the
raised value, but errors can be caught and checked in tests by
@pyret-id["raises" "testing"] and by @seclink["testing-blocks"]{@pyret{check:}
blocks}.

@(image "src/trove/raise.png")


@section{Built-in Types}

@type-spec["Any" (list)]{

A type specification that permits all values.  This is mainly useful 
in built-in language forms, like in @secref["equality"] or 
@pyret-id{torepr}, which truly do handle any value.  

Pyret programs that use @pyret{Any} on their own can usually be 
restructured to use a specific type declaration to be more clear about 
what data they are working with.

Specifying @pyret{Any} will prevent Pyret from attempting to infer types, as
it will if no type specification is provided.}

@type-spec["Boolean" (list)]{

The type of @seclink["booleans"].}

@type-spec["Number" (list)]{

The type of @seclink["numbers"].}

@type-spec["String" (list)]{

The type of @seclink["strings"].}

@type-spec["RawArray" (list)]{

The type of @seclink["raw-arrays"].}

@type-spec["Nothing" (list)]{

The type of the special value @pyret{nothing}, used in contexts where the
program evaluates but has no meaningful answer by design (see, for example
@pyret-id["each" "lists"]).  Note that @pyret{nothing} is still a value.

@examples{
check:
  [list: nothing, nothing, nothing].length() is 3
end
}
}

@type-spec["Function" (list)]{

The type of all @seclink["functions-tour" "function values"].}

@type-spec["Method" (list)]{

The type of all method values.}

@type-spec["Object" (list)]{

The type of all values constructed from @pyret{data} @seclink["s:data-decl" "constructors and
singletons"], and by @seclink["s:obj-expr" "object literals"].}

@type-spec["Table" (list)]{

The type of @seclink["tables"].}

@section{Type Predicates}

A number of functions are available to tell which kind of builtin value a
particular value is.

@function["is-boolean" #:contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean")))]

Returns @pyret{true} if the provided argument is a @pyret{Boolean},
 @pyret{false} if not.

@examples{
check:
  is-boolean(true) is true
  is-boolean(false) is true
  is-boolean(0) is false
end
}

@function["is-number" #:contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean")))]

Returns @pyret{true} if the provided argument is a @pyret{Number},
 @pyret{false} if not.

  Numbers are @itemlist[
     @item{Integers, e.g. @tt{345} or @tt{-321}}
     @item{Rationals, e.g. @tt{355/113} or @tt{-321/6789}}
     @item{Inexact numbers, e.g. @tt{123.4567} or @tt{-0.987}}
     @item{Complex numbers, e.g. @tt{1+2i}, where the real and imaginary components may be integers, rationals or inexact numbers}
  ]

@examples{
check:
  is-number(-42) is true
  is-number(~6.022e+23) is true
  is-number(num-sqrt(2)) is true
  is-number("4") is false
end
}
  
@function["is-string" #:contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean")))]

Returns @pyret{true} if the provided argument is a @pyret{String},
 @pyret{false} if not.

  @para{ Strings can be written @tt{@literal{"}text@literal{"}} or @tt{@literal{'}text@literal{'}},
  and may not span multiple lines.  Allowed escapes are @tt{\n} (newline),
  @tt{\r} (carriage return), @tt{\t} (tab), @tt{\[0-8]{1,3}} for octal escapes,
  @tt{\x[0-9a-fA-F]{1,2}} for single-byte hexadecimal escapes, or @tt{\u[0-9a-fA-F]{1,4}}
  for double-byte Unicode escapes.  Additionally, @tt{@literal{\"}} escapes a double-quote within a
  double-quoted string, and @tt{@literal{\'}} escapes a single quote within a single-quoted string.}

  @para{Multi-line string literals may be written @tt{@literal{```} text @literal{```}}.  The same escape sequences
  are valid as for single-line strings.  Leading and trailing whitespace of the string are
  trimmed.}

@examples{
check:
  is-string("Hello, world!") is true
  is-string(```Multi
            line
            string```) is true
end
}
  
@function["is-raw-array" #:contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean")))]

Returns @pyret{true} if the provided argument is a @pyret{RawArray},
 @pyret{false} if not.

@examples{
check:
  is-raw-array([raw-array: 3, "Jones", false]) is true
end
}

@function["is-nothing" #:contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean")))]

Returns @pyret{true} if the provided argument is a @pyret{Nothing},
 @pyret{false} if not.

@examples{
check:
  is-nothing(nothing) is true
  is-nothing(0) is false
  is-nothing(empty) is false
  is-nothing("") is false
end
}

@function["is-function" #:contract (a-arrow "Any" (a-id "Function" (xref "<global>" "Boolean")))]

Returns @pyret{true} if the provided argument is a @pyret{Function},
 @pyret{false} if not.

@examples{
fun inc(x): x + 1 end
check:
  is-function(inc) is true
  is-function((lam(i): i + 1 end)) is true
  is-function({(y :: Number) -> Number: y + 1}) is true
  is-function(method(self): self + 1 end) is false
end
}

@function["is-object" #:contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean")))]

Returns @pyret{true} if the provided argument is a @pyret{Object},
 @pyret{false} if not.

@examples{
data Point: pt(x, y) end
check:
  is-object(pt(3, 4)) is true
  is-object({x : 12, y : 7}) is true
  is-object({(y :: Number) -> Number: y + 1}) is false
end
}





}
