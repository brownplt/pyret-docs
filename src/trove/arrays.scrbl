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
        (method-spec (name "filter"))
        (method-spec (name "map"))
        (method-spec (name "fold"))
        (method-spec (name "concat"))
        (method-spec (name "duplicate"))
        (method-spec (name "sort-nums"))
        (method-spec (name "sort-by"))
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
    (fun-spec
      (name "array-filter")
      (arity 2)
      (args ("f" "array"))
      (doc ""))
    (fun-spec
      (name "array-map")
      (arity 2)
      (args ("f" "array"))
      (doc ""))
    (fun-spec
      (name "array-fold")
      (arity 4)
      (args ("f" "init" "array" "start-index"))
      (doc ""))
    (fun-spec
      (name "array-concat")
      (arity 2)
      (args ("array1" "array2"))
      (doc ""))
    (fun-spec
      (name "array-duplicate")
      (arity 1)
      (args ("array"))
      (doc ""))
    (fun-spec
      (name "array-sort-nums")
      (arity 2)
      (args ("array" "asc"))
      (doc ""))
    (fun-spec
      (name "array-sort-by")
      (arity 3)
      (args ("array" "key" "asc"))
      (doc ""))
))


@docmodule["arrays" #:noimport #t]{

@section{The Array Type}

@type-spec["Array" (list)]{

A @pyret{array} is a mutable, fixed-length collection indexed
by non-negative intgers. Accessing and mutating a @pyret{array} takes
constant time in the size of the array.

By default, Pyret users should use this library. If, however, you need
a higher-performant but potentially less ergonomic array library, look at
@seclink{raw-arrays} instead, which is primarily reserved for internal
use and for building other libraries. However, do not use that library
unless you really cannot get what you need out of this one.

Because arrays are @emph{mutable}, equality is not straightforward.
Learn more at @seclink["equality"].

}

@section{Using Arrays in Programs}

Some of the names provided for arrays inevitably overlap with those
provided for other data. Therefore, using the @pyret{include}
form is likely to cause name-clashes. It is wiser to import arrays using a prefix name and
use the names below through that prefix.

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = A.array-of("a", 3)
  a is=~ [A.array: "a", "a", "a"]
  A.array-length(a) is 3
end
}

@section{Constructing Arrays}

@collection-doc["array" #:contract `(a-arrow ("value" "a") ,(A-of "a"))]

Constructs an @pyret-id{Array} with the given elements.  Note that
@pyret-id{Array}s are mutable, so comparisons using @pyret{==}
(the operator for @pyret-id["equal-always" "equality"]) will only
return @pyret{true} on @pyret-id{Array}s when they are also
@pyret-id["identical" "equality"], regardless of their contents.  To compare
the elements use @pyret-id["equal-now" "equality"]/@pyret{=~},
and test using @pyret-id["is=~" "testing"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: 1, 2, 3]
  a is a
  a is== a
  [A.array: 1, 2, 3] is=~ [A.array: 1, 2, 3]
  [A.array: 1, 2, 3] is-not== [A.array: 1, 2, 3]
  [A.array: 1, 2, 3] is-not [A.array: 1, 2, 3]
end
}

@function["array-of"
  #:contract (a-arrow "a" N (A-of "a"))
  #:args (list (list "value" #f) (list "count" #f))
  #:return (A-of "a")
]

Constructs an @pyret{Array} of length @tt{count}, where every element is the value
given as @pyret{value}.

Note that @pyret{value} is not @emph{copied}, so,
the elements of @pyret{Array}s created with @pyret-id{array-of} will always be
@pyret-id["identical" "equality"].

To create an array of arrays where each sub-array is independent of the other, use
@pyret-id{build-array}.

Similar to @pyret-id["raw-array-of" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  arr = A.array-of(true, 2)
  arr is=~ [A.array: true, true]
  arr is-not [A.array: true, true]
  A.array-get-now(arr, 0) is<=> A.array-get-now(arr, 1)
  
  A.array-set-now(arr, 1, false)
  arr is=~ [A.array: true, false]
  
  arr-of-arrs = A.array-of(arr, 3)
  arr-of-arrs is=~ 
  [A.array: 
    [A.array: true, false], [A.array: true, false], [A.array: true, false]]
  
  A.array-set-now(arr, 0, false)
  arr-of-arrs is=~ 
  [A.array: 
    [A.array: false, false], [A.array: false, false], [A.array: false, false]] 
end
}

@function["build-array"
  #:contract (a-arrow (a-arrow N "a") N (A-of "a"))
  #:args (list (list "f" #f) (list "size" #f))
  #:return (A-of "a")
]

Constructs an array of length @pyret{size}, and fills it with the result of
calling the function @pyret{f} with each index from @pyret{0} to @pyret{size - 1}.

Similar to @pyret-id["raw-array-build" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  fun sq(x): x * x end
  A.build-array(sq, 4) is=~ [A.array: sq(0), sq(1), sq(2), sq(3)]
end

check:
  fun build(n :: Number) -> Array<String>:
    A.array-of("_", 3)
  end
  a = A.build-array(build, 3)
  
  a is=~ [A.array:
    [A.array: "_", "_", "_"],
    [A.array: "_", "_", "_"],
    [A.array: "_", "_", "_"]]

  a.get-now(0).set-now(0, "X")
  a.get-now(1).set-now(1, "O")

  a is=~ [A.array:
    [A.array: "X", "_", "_"],
    [A.array: "_", "O", "_"],
    [A.array: "_", "_", "_"]]
end
}

@function["array-from-list"
  #:contract (a-arrow (L-of "a") (A-of "a"))
  #:args (list (list "l" #f))
  #:return (A-of "a")]

Converts a @pyret-id["List" "lists"] to an @pyret-id{Array} containing the same elements in the same order.

Similar to @pyret-id["raw-array-from-list" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A
import lists as L

check:
  A.array-from-list([L.list: 1, 2, 3]) is=~ [A.array: 1, 2, 3]
end
}

@section{Array Methods}

@a-method["get-now"
  #:contract (a-arrow (A-of "a") N "a")
  #:args (list (list "self" #f) (list "index" #f))
  #:return "a"
]

Returns the value at the given @tt{index}.  

This method has a
@pyret{-now} suffix because its answer can change from one call to the next if,
for example, @a-ref["set-now"] is used.

Using an index too large, negative, or not a whole number raises an error.

Similar to @pyret-id["get" "lists"] and @pyret-id["raw-array-get" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "a", "b", "c"]
  a.get-now(0) is "a"
  a.get-now(1) is "b"

  a.get-now(4) raises "index"
  a.get-now(-1) raises "index"
  a.get-now(1.2) raises "index"
end
}

@a-method["set-now"
  #:contract (a-arrow (A-of "a") N "a" No)
  #:args (list (list "self" #f) (list "index" #f) (list "value" #f))
  #:return No
]

Updates the value at the given @tt{index}, returning @pyret-id["Nothing"
"<global>"].

The update is stateful, so all references to the array see the
update.  Hence the @pyret{-now} suffix; in the example below,
calling @pyret{a.get-now()} at two different points
in the program produces two different results.

Using an index too large, negative, or not a whole number raises an error.

Similar to @pyret-id["raw-array-set" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "a", "b", "c"]
  a.get-now(0) is "a"
  
  a.set-now(0, "d")
  a.get-now(0) is "d"

  b = a
  a.set-now(0, "f")
  a is=~ [A.array: "f", "b", "c"]
  b is=~ [A.array: "f", "b", "c"]

  c = b.set-now(0, 'z')
  c is nothing
  
  b.set-now(4, "hi") raises "index"
end
}

@a-method["length"
  #:contract (a-arrow (A-of "a") N)
  #:args (list (list "self" #f))
  #:return N
]

Returns the length of the array.  The length of an array is set when it is
created and cannot be changed.

Similar to @pyret-id["length" "lists"] and @pyret-id["raw-array-length" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "a", "b"]
  a.length() is 2
  b = [A.array: ]
  b.length() is 0
end
}

@a-method["filter"
    #:contract (a-arrow (A-of "a") (a-arrow "a" B) (A-of "a"))
    #:args (list (list "self" #f) (list "f" #f))
    #:return (A-of "a")]
    
  Applies function @pyret{f} to each element of @pyret{self} from left to right,
  constructing a new @pyret{Array} out of the elements for which @pyret{f}
  returned @pyret{true}.

Similar to @pyret-id["filter" "lists"] and @pyret-id["raw-array-filter" "raw-arrays"].

  @examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "apple", "banana", "plum"]
  p-words = a.filter({(s): string-contains(s, "p")})
  p-words is=~ [A.array: "apple", "plum"]
end
  }
  
@a-method["map"
    #:contract (a-arrow (A-of "a") (a-arrow "a" "b") (A-of "b"))
    #:args (list (list "self" #f) (list "f" #f))
    #:return (A-of "b")]
    
Applies function @pyret{f} to each element of the arrays from left to right, and
constructs a new @pyret{Array} out of the return values in the corresponding order.
The original array remains unchanged.

@tt{a} represents the type of the elements in the original @pyret{Array}, @tt{b} is
the type of the elements in the new @pyret{Array}.

Similar to @pyret-id["map" "lists"] and @pyret-id["raw-array-map" "raw-arrays"].

  @examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "apple", "banana", "plum"]
  lengths = a.map(string-length)
  lengths is=~ [A.array: 5, 6, 4]
  a is=~ [A.array: "apple", "banana", "plum"]
end
  }

@a-method["fold"
    #:contract (a-arrow (A-of "a") (a-arrow "b" "a" N "b") "b" N "b")
    #:args (list (list "self" #f) (list "f" #f) (list "init" #f) (list "start-index" #f))
    #:return "b"]
    
Combines the elements in the array with a function that accumulates
each element with an intermediate result. Has an
argument order that works with @pyret{for}. The numeric argument to the
accumulator is the index of the current element.

Similar to @pyret-id["fold" "lists"] and @pyret-id["raw-array-fold" "raw-arrays"].

  @examples[#:show-try-it #t]{
import arrays as A

fun sum-even-minus-odd(a :: Array<Number>):
  fun is-even(n): (n / 2) == num-floor(n / 2) end
  
  fun sum-ith(sum-so-far :: Number, new-n :: Number, idx :: Number):
    if is-even(idx):
      sum-so-far + new-n
    else:
      sum-so-far - new-n
    end
  end
  
  a.fold(sum-ith, 0, 0)
end

check:
  sum-even-minus-odd([A.array: ]) is 0
  sum-even-minus-odd([A.array: 1]) is 1
  sum-even-minus-odd([A.array: 1, 2])
    is -1 because (1 - 2)
  sum-even-minus-odd([A.array: 1, 2, 3])
    is 2 because (1 + 3) - 2
  sum-even-minus-odd([A.array: 1, 2, 3, 4])
    is -2 because ((1 + 3) - (2 + 4))
end
  }

@a-method["concat"
    #:contract (a-arrow (A-of "a") (A-of "a") (A-of "a"))
    #:args (list (list "self" #f) (list "other" #f))
    #:return (A-of "a")]

  Creates a new array with all the elements of the current array
  followed by all the elements of @pyret{other}.

Similar to @pyret-id["append" "lists"] and @pyret-id["raw-array-concat" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "To", "be", "or"]
  a.concat([A.array: "not", "to", "be"])
    is=~ [A.array: "To", "be", "or", "not", "to", "be"]

  a is=~ [A.array: "To", "be", "or"]

  a is-not=~ [A.array: "To", "be", "or", "not", "to", "be"]
end

}

@a-method["duplicate"
    #:contract (a-arrow (A-of "a"))
    #:args (list (list "self" #f))
    #:return (A-of "a")]

  Returns a copy of the given array, such that corresponding elements in the
  result are @seclink["Identical"] to those in the source array.

Similar to @pyret-id["raw-array-duplicate" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

data Person: p(ref name :: String, ref age :: Number) end

check:
  ps1 = [A.array: p("Alice", 30), p("Bob", 40)]

  ps2 = ps1.duplicate()
  
  ps2.get-now(0) is ps1.get-now(0)

  ps2.get-now(1)!{age: 57}
  ps1.get-now(1)!age is 57
end

}

@a-method["sort-nums"
    #:contract (a-arrow (A-of "a") B)
    #:args (list (list "self" #f) (list "asc" #f))
    #:return (A-of "a")]

  Sorts the given array @emph{in-place} in ascending or descending order
  according to the @pyret{asc} parameter. Returns a reference to the
  original array, which will have its contents mutably updated.

Similar to @pyret-id["raw-array-sort-nums" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: 3, 1, 4, 1, 5, 9, 2]

  asc = a.sort-nums(true)
  asc is<=> a
  a is=~ [A.array: 1, 1, 2, 3, 4, 5, 9]

  a.sort-nums(false)
  a is=~ [A.array: 9, 5, 4, 3, 2, 1, 1]
end
}

@a-method["sort-by"
    #:contract (a-arrow (A-of "a") (a-arrow "a" N) B)
    #:args (list (list "self" #f) (list "key" #f) (list "asc" #f))
    #:return (A-of "a")]

  Creates a new array containing the sorted contents of the given array. The sort
  order is determined by calling the @pyret{key} function on each element to
  get a number, and sorting the elements by their key value (in increasing key
  order if @pyret{asc} is @pyret{true}, decreasing if @pyret{false}). Ties are
  broken by the order in which the element is present in the initial array.

Similar to @pyret-id["raw-array-sort-by" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "let", "us", "go", "then", "you", "and", "i"]

  asc = a.sort-by(string-length, true)
  asc is=~ [A.array: "i", "us", "go", "let", "you", "and", "then"]
  asc is-not=~ a

  desc = a.sort-by(string-length, false)
  desc is=~ [A.array: "then", "let", "you", "and", "us", "go", "i"]

  a is=~ [A.array: "let", "us", "go", "then", "you", "and", "i"]
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

Similar to @pyret-id["raw-array-to-list" "raw-arrays"].

@examples[#:show-try-it #t]{
import arrays as A
import lists as L

check:
  a = [A.array: 1, 2, 3]
  a.to-list-now() is [L.list: 1, 2, 3]
        
  a2 = array-of([A.array: ], 3)
  a2.to-list-now() is=~ [L.list: [A.array: ], [A.array: ], [A.array: ]]
  a2.to-list-now() is-not=~ [L.list: [L.list: ], [L.list: ], [L.list: ]]

  a.set-now(0, 5)
  a.to-list-now() is [L.list: 5, 2, 3]
end
}



@section{Array Functions}

@function["array-get-now"
  #:contract (a-arrow (A-of "a") N "a")
  #:args (list (list "array" #f) (list "index" #f))
  #:return "a"
]

Equivalent to @pyret{array}@a-ref["get-now"]@pyret{(index)}.

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: 0, 1, 2]
  A.array-get-now(a, 1) is 1
end
}
          
@function["array-set-now"
  #:contract (a-arrow (A-of "a") N "a" (A-of "a"))
  #:args (list (list "array" #f) (list "index" #f) (list "value" #f))
  #:return No
]

Equivalent to @pyret{array}@a-ref["set-now"]@pyret{(index, value)}.

@examples[#:show-try-it #t]{
import arrays as A
         
check:
  a = A.array-of("a", 3)
  a is=~ [A.array: "a", "a", "a"]

  A.array-set-now(a, 1, "b")
  a is=~ [A.array: "a", "b", "a"]
end
}

@function["array-length"
  #:contract (a-arrow (A-of "a") N)
  #:args (list (list "array" #f))
  #:return N
]

Equivalent to @pyret{array}@a-ref["length"]@pyret{()}.

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = A.array-of("a", 3)
  a is=~ [A.array: "a", "a", "a"]
  A.array-length(a) is 3
end
}

@function["array-filter"
  #:contract (a-arrow (a-arrow "a" B) (A-of "a"))
  #:args (list (list "f" #f) (list "array" #f))
  #:return (A-of "a")
]

Equivalent to @pyret{array}@a-ref["filter"]@pyret{(f)}, with an argument order
designed for @pyret{for}.


@function["array-map"
  #:contract (a-arrow (a-arrow "a" "b") (A-of "a"))
  #:args (list (list "f" #f) (list "array" #f))
  #:return (A-of "b")
]

Equivalent to @pyret{array}@a-ref["map"]@pyret{(f)}, with an argument order
designed for @pyret{for}.

@function["array-fold"
  #:contract (a-arrow (a-arrow "b" "a" N) "b" (A-of "a") N)
  #:args (list (list "f" #f) (list "init" #f) (list "array" #f) (list "start-index" #f))
  #:return "b"
]

Equivalent to @pyret{array}@a-ref["fold"]@pyret{(f, init, start-index)}, with an argument order
designed for @pyret{for}.

@function["array-concat"
  #:contract (a-arrow (A-of "a") (A-of "a"))
  #:args (list (list "array1" #f) (list "array2" #f))
  #:return (A-of "a")
]

Equivalent to @pyret{array1}@a-ref["concat"]@pyret{(array2)}.

@function["array-duplicate"
  #:contract (a-arrow (A-of "a"))
  #:args (list (list "array" #f))
  #:return (A-of "a")
]

Equivalent to @pyret{array}@a-ref["duplicate"]@pyret{()}.

@function["array-sort-nums"
  #:contract (a-arrow (A-of "a") B)
  #:args (list (list "array" #f) (list "asc" #f))
  #:return (A-of "a")
]

Equivalent to @pyret{array}@a-ref["sort-nums"]@pyret{(asc)}.

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: 3, 1, 4, 1, 5, 9, 2]

  asc = A.array-sort-nums(a, true)
  asc is<=> a
  a is=~ [A.array: 1, 1, 2, 3, 4, 5, 9]

  A.array-sort-nums(a, false)
  a is=~ [A.array: 9, 5, 4, 3, 2, 1, 1]
end
}

@function["array-sort-by"
  #:contract (a-arrow (A-of "a") (a-arrow "a" N) B)
  #:args (list (list "array" #f) (list "key" #f) (list "asc" #f))
  #:return (A-of "a")
]

Equivalent to @pyret{array}@a-ref["sort-by"]@pyret{(key, asc)}.

@examples[#:show-try-it #t]{
import arrays as A

check:
  a = [A.array: "let", "us", "go", "then", "you", "and", "i"]

  asc = A.array-sort-by(a, string-length, true)
  asc is=~ [A.array: "i", "us", "go", "let", "you", "and", "then"]
  asc is-not=~ a

  desc = A.array-sort-by(a, string-length, false)
  desc is=~ [A.array: "then", "let", "you", "and", "us", "go", "i"]

  a is=~ [A.array: "let", "us", "go", "then", "you", "and", "i"]
end
}

@function["array-to-list-now"
  #:contract (a-arrow (A-of "a") (L-of "a"))
  #:args (list (list "array" #f))
  #:return (L-of "a")
]

Equivalent to @pyret{array}@a-ref["to-list-now"]@pyret{()}.

@examples[#:show-try-it #t]{
import arrays as A
import lists as L

check:
  a = A.array-of("a", 3)
  a is=~ [A.array: "a", "a", "a"]

  A.array-set-now(a, 1, "b")
  a is=~ [A.array: "a", "b", "a"]

  l = A.array-to-list-now(a)
  l is [L.list: "a", "b", "a"]
end
}

}
