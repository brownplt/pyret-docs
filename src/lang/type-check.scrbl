#lang scribble/base

@(require "../../scribble-api.rkt")

@docmodule["type-check" #:noimport #t #:friendly-title "Type Checking"]{

Pyret has an optional static type checker. On
@url["https://code.pyret.org"] it can be accessed as a drop down option
under the Run button, and from the command line it can be run by adding
the flag @tt{-type-check}.

The type checker is built around the
@seclink["s:annotations"]{annotation} system, providing a static
check that all annotations are correct and that all uses of annotated
functions have the proper types passed to them.

@section[#:tag "required-annotations"]{Required Annotations}

When using the type checker annotations are required in two locations.
Everywhere else they are optional (barring certain caveats). The first of
the required locations is the arguments of top level functions.

The function @pyret{foo} type checks as an annotation is provided on the
argument @pyret{x}. The return annotation is not necessary so the function
@pyret{bar} also type checks. However, the function @pyret{baz} will fail
to type check with an error requiring an annotation on the argument
@pyret{x}.

@pyret-block{
# Type checks
fun foo(x :: Number) -> Number:
  x
end

# Type checks
fun bar(x :: Number):
  x
end

# Fails
fun baz(x):
  x
end
}

The other place that annotations are required is on
@seclink["s:data-decl"]{data declarations}. Each field must be annotated
with its type.

@pyret-block{
# Type checks
data BTree:
  | node(value :: Number, left :: BTree, right :: BTree)
  | leaf(value :: Number)
end
}
  
@;@section[#:tag "test-inference"]{Using Tests for Types}

@section[#:tag "working-with-data-types"]{Working with Data Types}

There are a couple important notes when working with polymorphic data
types such as @pyret{Option} (defined below).

@pyret-block{
data Option<A>:
  | none
  | some(value :: A)
end
}

Whenever a value is being annotated with a polymorphic type, the type
instantiation must be written. So @pyret{x :: Option<Number> = some(1)}
is okay, but @pyret{x :: Option = some(1)} is not. The caveat to this is
when writing @pyret{cases} statements. On these the instantiating type is
not needed and you can simply write @pyret{cases(Option) x:}.

@;@subsection[#:tag "refinement-types"]{Refinement Types}

@section[#:tag "record-types"]{Record Types}

Record types such as @pyret{{x :: Number, y :: String}} have two meanings.
The first one is that they are the type of records (@pyret{{x: 1, y: "a"}}
has the type shown above). In addition, any data type where all
variants have the fields @pyret{x :: Number} and @pyret{y :: String} would
satisfy that type. For example, if we have the code shown below, the type
checker will accept the program.

@pyret-block{
data Side:
  | left(x :: Number)
  | right(x :: Number)
end

fun f(thing :: {x :: Number}) -> Number:
  thing.x
end

side-thing :: Side = left(1)
x :: Number = f(side-thing) # Type checks
}

}
