#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(define a-of-a '(a-app (a-id "Array" (xref "arrays" "Array")) "a"))

@(define (a-method name #:args args #:return ret #:contract contract)
  (method-doc "Array" "array" name #:alt-docstrings "" #:args args #:return ret #:contract contract))
@(define (a-ref name)
  (pyret-method "Array" "array" name "arrays"))

@(append-gen-docs
  '(module "arrays"
    (path "src/js/base/runtime-anf.js")
    (fun-spec
      (name "array")
      (arity 1))
    (data-spec
      (name "Array")
      (type-vars (a-id "a"))
      (variants ("array"))
      (shared (
        (method-spec (name "get-now"))
        (method-spec (name "set-now"))
        (method-spec (name "length"))
        (method-spec (name "to-list-now"))
        )))
    (fun-spec
      (name "build-array")
      (arity 2)
      (params [list: leaf("a")])
      (args ("f" "len"))
      (return "Any")
      (contract
        (a-arrow
          (a-arrow (a-id "Number" (xref "<global>" "Number")) "a")
          (a-id "Number" (xref "<global>" "Number"))
          "Any")))
    (fun-spec
      (name "array-from-list")
      (arity 1)
      (params [list: ])
      (args ("l"))
      (return "Any")
      (contract (a-arrow "Any" "Any")))
    (fun-spec
      (name "array-of")
      (arity 2)
      (args ("value" "count"))
      (doc ""))
    (fun-spec
      (name "array-get-now")
      (arity 2)
      (args ("array" "index"))
      (doc ""))
    (fun-spec
      (name "array-set-now")
      (arity 3)
      (args ("array" "index" "new-value"))
      (doc ""))
    (fun-spec
      (name "array-length")
      (arity 1)
      (args ("array"))
      (doc ""))
    (fun-spec
      (name "array-to-list-now")
      (arity 1)
      (args ("array"))
      (doc ""))
))


@docmodule["arrays" #:noimport #t]{
   @type-spec["Array" (list)]{

@centered{

@bold{This library is archived.}

@emph{The @seclink{raw-arrays} library provides a significantly improved version of
this library. We recommend that you use that instead.}

}

An @pyret{Array} is a mutable, fixed-length collection indexed
by non-negative intgers.}

@section{Array Creation Functions}

@collection-doc["array" #:contract `(a-arrow ("elt" "a") ,(A-of "a"))]

Creates an @pyret-id{Array} with the given elements.  Note that
@pyret-id{Array}s are mutable, so comparisons using @pyret{==}
(the operator for @pyret-id["equal-always" "equality"]) will only
return @pyret{true} on @pyret-id{Array}s when they are also
@pyret-id["identical" "equality"], regardless of their contents.  To compare
the elements, use @pyret-id["equal-now" "equality"]/@pyret{=~},
and test with @pyret-id["is=~" "testing"].

@examples{
check:
  a = [array: 1, 2, 3]
  a is a
  a is== a
  [array: 1, 2, 3] is=~ [array: 1, 2, 3]
  [array: 1, 2, 3] is-not== [array: 1, 2, 3]
  [array: 1, 2, 3] is-not [array: 1, 2, 3]
end
}

@function["array-of"
  #:contract (a-arrow "a" N (A-of "a"))
  #:args (list (list "elt" #f) (list "count" #f))
  #:return (A-of "a")
]

Constructs an @pyret{Array} of length @tt{count}, where every element is the value
given as @pyret{elt}.

Note that @pyret{value} is not @emph{copied}, so,
the elements of @pyret{Array}s created with @pyret-id{array-of} will always be
@pyret-id["identical" "equality"].

@examples{
check:
  arr = array-of(true, 2)
  arr is=~ [array: true, true]
  arr is-not [array: true, true]
  array-get-now(arr, 0) is<=> array-get-now(arr, 1)
  
  array-set-now(arr, 1, false)
  arr is=~ [array: true, false]
  
  arr-of-arrs = array-of(arr, 3)
  arr-of-arrs is=~ [array: [array: true, false], [array: true, false],
    [array: true, false]]
  
  array-set-now(arr, 0, false)
  arr-of-arrs is=~ [array: [array: false, false], [array: false, false],
    [array: false, false]] 
end

}

To create an array of arrays where each array is new and independent, use
@pyret-id{build-array}.

@function["build-array"
  #:contract (a-arrow (a-arrow N "a") N (A-of "a"))
  #:args (list (list "f" #f) (list "count" #f))
  #:return (A-of "a")
]

Takes a function (@pyret{f}) that creates a new element when given a number,
and a number to count up to (@pyret{count}), and calls @pyret{f} on each number
from @pyret{0} to @pyret{count - 1}, creating an array out of the results.

@examples{
check:
  fun build(n :: Number) -> Array<String>:
    array-of("_", 3)
  end
  a = build-array(build, 3)
  
  a is=~ [array:
    [array: "_", "_", "_"],
    [array: "_", "_", "_"],
    [array: "_", "_", "_"]]

  a.get-now(0).set-now(0, "X")
  a.get-now(1).set-now(1, "O")

  a is=~ [array:
    [array: "X", "_", "_"],
    [array: "_", "O", "_"],
    [array: "_", "_", "_"]]
end
}

@function["array-from-list"
  #:contract (a-arrow (L-of "a") (A-of "a"))
  #:args (list (list "l" #f))
  #:return (A-of "a")]

Converts a list of items into an array of items.
@examples{
check:
  array-from-list([list: 1, 2, 3]) is=~ [array: 1, 2, 3]
end
}
@section{Array Methods}

@a-method["get-now"
  #:contract (a-arrow (A-of "a") N "a")
  #:args (list (list "self" #f) (list "index" #f))
  #:return "a"
]

Returns the value at the given @tt{index}.  If the index is too large, is
negative, or isn't a whole number, an error is raised.  This method has a
@pyret{-now} suffix because its answer can change from one call to the next if,
for example, @a-ref["set-now"] is used.

@examples{
check:
  a = [array: "a", "b", "c"]
  a.get-now(0) is "a"
  a.get-now(1) is "b"
end
}

@a-method["set-now"
  #:contract (a-arrow (A-of "a") N "a" No)
  #:args (list (list "self" #f) (list "index" #f) (list "value" #f))
  #:return No
]

Updates the value at the given @tt{index}, returning @pyret-id["Nothing"
"<global>"].  The update is stateful, so all references to the array see the
update.  This also justifies the @pyret{-now} suffix; in the example below
calling @pyret{a.get-now()} at two different points
in the program produces two different results.

@examples{
check:
  a = [array: "a", "b", "c"]
  a.get-now(0) is "a"

  b = a
  a.set-now(0, "d")
  a is=~ [array: "d", "b", "c"]
  b is=~ [array: "d", "b", "c"]
  
  c = b.set-now(0, 'z')
  c is nothing
end
}

@a-method["length"
  #:contract (a-arrow (A-of "a") N)
  #:args (list (list "self" #f))
  #:return N
]

Returns the length of the array.  The length of an array is set when it is
created and cannot be changed.

@examples{
check:
  a = [array: "a", "b"]
  a.length() is 2
  b = [array:]
  b.length() is 0
end
}

@a-method["to-list-now"
  #:contract (a-arrow (A-of "a") (L-of "a"))
  #:args (list (list "self" #f))
  #:return (L-of "a")
]

    Converts a @pyret-id{Array} to a @pyret-id["List" "lists"] containing
    the same elements in the same order. This method has a
@pyret{-now} suffix because its answer can change from one call to the next if,
for example, @a-ref["set-now"] is subsequently used.

    Note that it does @emph{not} recursively convert @pyret-id{Array}s;
    only the top-level is converted.

@examples{
check:
  a = [array: 1, 2, 3]
  a.to-list-now() is [list: 1, 2, 3]
        
  a2 = array-of([array:], 3)
  a2.to-list-now() is=~ [list: [array:], [array:], [array:]]
  a2.to-list-now() is-not=~ [list: [list:], [list:], [list:]]
end
}

@section{Array Functions}

@function["array-get-now"
  #:contract (a-arrow (A-of "a") N "a")
  #:args (list (list "array" #f) (list "index" #f))
  #:return "a"
]

Equivalent to @pyret{array}@a-ref["get-now"]@pyret{(index)}

@examples{
check:
  a = [array: 0, 1, 2]
  array-get-now(a, 1) is 1
end
}
          
@function["array-set-now"
  #:contract (a-arrow (A-of "a") N "a" (A-of "a"))
  #:args (list (list "array" #f) (list "index" #f) (list "value" #f))
  #:return No
]

Equivalent to @pyret{array}@a-ref["set-now"]@pyret{(index, value)}.

@examples{
         
check:
  a = array-of("a", 3)
  a is=~ [array: "a", "a", "a"]

  array-set-now(a, 1, "b")
  a is=~ [array: "a", "b", "a"]
end
}

@function["array-to-list-now"
  #:contract (a-arrow (A-of "a") (L-of "a"))
  #:args (list (list "array" #f))
  #:return (L-of "a")
]

Equivalent to @pyret{array}@a-ref["to-list-now"]@pyret{()}.

@examples{
check:
  a = array-of("a", 3)
  a is=~ [array: "a", "a", "a"]

  array-set-now(a, 1, "b")
  a is=~ [array: "a", "b", "a"]

  l = array-to-list-now(a)
  l is [list: "a", "b", "a"]
end
}
@function["array-length"
  #:contract (a-arrow (A-of "a") N)
  #:args (list (list "array" #f))
  #:return N
]

Equivalent to @pyret{array}@a-ref["length"]@pyret{()}

@examples{
check:
  a = array-of("a", 3)
  a is=~ [array: "a", "a", "a"]
  array-length(a) is 3
end
}
}
