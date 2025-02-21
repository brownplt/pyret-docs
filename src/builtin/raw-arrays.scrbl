#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(define ra-of-a '(a-app (a-id "RawArray" (xref "raw-arrays" "RawArray")) "a"))

@(append-gen-docs
  `(module "raw-arrays"
    (path "src/js/base/runtime-anf.js")
    (data-spec
      (name "RawArray")
      (variants)
      (shared))
    (fun-spec
      (name "raw-array-of")
      (arity 2)
      (args ("value" "count"))
      (return ,ra-of-a)
      (doc ""))
    (fun-spec
      (name "raw-array-get")
      (arity 2)
      (args ("array" "index"))
      (return "a")
      (doc ""))
    (fun-spec
      (name "raw-array-set")
      (arity 3)
      (args ("array" "index" "new-value"))
      (return ,ra-of-a)
      (doc ""))
    (fun-spec
      (name "raw-array-length")
      (arity 1)
      (args ("array"))
      (doc ""))
    (fun-spec
      (name "raw-array-to-list")
      (arity 1)
      (args ("array"))
      (doc ""))
    (fun-spec
      (name "raw-array-from-list")
      (arity 1)
      (args ("lst"))
      (doc ""))
    (fun-spec
      (name "raw-array-build")
      (arity 2)
      (args ("f" "size"))
      (doc ""))
    (fun-spec
      (name "raw-array-build-opt")
      (arity 2)
      (args ("f" "size"))
      (doc ""))
    (fun-spec
      (name "raw-array-map")
      (arity 2)
      (args ("f" "array"))
      (doc ""))
    (fun-spec
      (name "raw-array-sort-nums")
      (arity 2)
      (args ("array" "ascending"))
      (doc ""))
    (fun-spec
      (name "raw-array-sort-by")
      (arity 3)
      (args ("array" "key" "ascending"))
      (doc ""))
    (fun-spec
      (name "raw-array-fold")
      (arity 4)
      (args ("f" "init" "array" "start-index"))
      (doc ""))
    (fun-spec
      (name "raw-array-duplicate")
      (arity 1)
      (args ("array"))
      (return ,ra-of-a)
      (contract (a-arrow ,ra-of-a ,ra-of-a)))
      
    (unknown-item
      (name "raw-array")
      ;; { maker of raw-arrays ... }
      )
))


@docmodule["raw-arrays" #:noimport #t #:friendly-title "RawArray"]{
   @type-spec["RawArray" (list "a")]{

   A @pyret{RawArray} is a mutable, fixed-length collection indexed
   by non-negative intgers. Accessing and mutating a @pyret{RawArray} takes
   constant time in the size of the array.
 }

     @section{RawArray Functions}

@collection-doc["raw-array" #:contract `(a-arrow ("elt" "a") ,(RA-of "a"))]

Constructs a @pyret{RawArray} array of length @tt{count}, whose elements are
the values specified in the construction expression.

Note that
@pyret-id{RawArray}s are mutable, so comparisons using @pyret{==}
(the operator for @pyret-id["equal-always" "equality"]) will only
return @pyret{true} on @pyret-id{RawArray}s when they are also
@pyret-id["identical" "equality"], regardless of their contents.  To compare
the elements, use @pyret-id["equal-now" "equality"]/@pyret{=~},
and test with @pyret-id["is=~" "testing"].

@examples{
check:
  [raw-array: 1, 2, 3] is-not== [raw-array: 1, 2, 3]
  [raw-array: 1, 2, 3] is-not [raw-array: 1, 2, 3]
  [raw-array: 1, 2, 3] is=~ [raw-array: 1, 2, 3]

  a = [raw-array: 1, 2, 3]
  a is a
  a is== a
end
}

  @function["raw-array-of" #:contract (a-arrow "a" N (RA-of "a"))]

Constructs an @pyret{RawArray} of length @tt{count}, where every element is the value
given as @pyret{elt}.

Note that @pyret{value} is not @emph{copied}, so,
the elements of @pyret{RawArray}s created with @pyret-id{raw-array-of} will always be
@pyret-id["identical" "equality"] (with the usual caveats if the @pyret{value}
was a function or method).

@examples{
check:
  arr = raw-array-of(true, 2)
  arr is=~ [raw-array: true, true]
  arr is-not [raw-array: true, true]
  raw-array-get(arr, 0) is<=> raw-array-get(arr, 1)
  
  raw-array-set(arr, 1, false)
  arr is=~ [raw-array: true, false]
  
  arr-of-arrs = raw-array-of(arr, 3)
  arr-of-arrs is=~ [raw-array: [raw-array: true, false], 
    [raw-array: true, false], [raw-array: true, false]]
  
  raw-array-set(arr, 0, false)
  arr-of-arrs is=~ [raw-array: [raw-array: false, false], 
    [raw-array: false, false], [raw-array: false, false]] 
end

}

  @function["raw-array-get" #:contract (a-arrow (RA-of "a") N "a") #:return "a"]

Returns the value at the given @tt{index}.  If the index is too large, is
negative, or isn't a whole number, an error is raised.
  
@examples{
check:
  a = [raw-array: "a", "b", "c"]
  raw-array-get(a, 0) is "a"
  raw-array-get(a, 1) is "b"
  raw-array-get(a, 2) is "c"
end
}
  
  @function["raw-array-set" #:contract (a-arrow (RA-of "a") N "a" (RA-of "a")) #:return (RA-of "a")]

Updates the value at the given @tt{index}, returning the new value.  The update is stateful,
so all references to the @pyret{RawArray} see the update.  

@examples{
check:
  a = [raw-array: "a", "b", "c"]
  raw-array-get(a, 0) is "a"
  
  b = a
  raw-array-set(a, 0, "d")
  a is=~ [raw-array: "d", "b", "c"]
  b is=~ [raw-array: "d", "b", "c"]
  
  c = raw-array-set(a, 0, "z")
  c is=~ [raw-array: "z", "b", "c"]
end
}

          
  @function["raw-array-length" #:contract (a-arrow (RA-of "a") N) #:return N]

@examples{
check:
  a = [raw-array: "a", "b"]
  raw-array-length(a) is 2
  b = [raw-array:]
  raw-array-length(b) is 0
end
}
  @function["raw-array-to-list" #:contract (a-arrow (RA-of "a") (L-of "a")) #:return (L-of "a")]

    Converts a @pyret-id{RawArray} to a @pyret-id["List" "lists"] containing
    the same elements in the same order.

    Note that it does @emph{not} recursively convert @pyret-id{RawArray}s;
    only the top-level is converted.

    @examples{
check:
  a = [raw-array: 1, 2, 3]
  raw-array-to-list(a) is [list: 1, 2, 3]
        
  a2 = raw-array-of([raw-array:], 3)
  raw-array-to-list(a2) is=~ [list: [raw-array:], [raw-array:], [raw-array:]]
  raw-array-to-list(a2) is-not=~ [list: [list:], [list:], [list:]]
end
    }

  @function["raw-array-from-list" #:contract (a-arrow (L-of "a") (RA-of "a")) #:return (RA-of "a")]

    Converts a @pyret-id["List" "lists"] to a @pyret-id{RawArray} containing
    the same elements in the same order.

@examples{
check:
  raw-array-from-list(empty) is=~ [raw-array: ]
  raw-array-from-list(empty) is-not [raw-array: ]
  
  raw-array-from-list([list: 1, 2, 3]) is=~ [raw-array: 1, 2, 3]
  raw-array-from-list([list: 1, 2, 3]) is-not [raw-array: 1, 2, 3]
end
}


  @function["raw-array-build" #:contract (a-arrow (a-arrow N "a") N (RA-of "a")) #:return (RA-of "a")]

    Constructs an array of length @pyret{size}, and fills it with the result of
    calling the function @pyret{f} with each index from @pyret{0} to @pyret{size - 1}.

  @examples{
check:
  fun sq(x): x * x end
  raw-array-build(sq, 4) is=~ [raw-array: sq(0), sq(1), sq(2), sq(3)]
end
  }


  @function["raw-array-build-opt" #:contract (a-arrow (a-arrow N (O-of A)) N) #:return (RA-of A)]
  
    Constructs an array based on the results of
    calling the function @pyret{f} with each index from @pyret{0} to @pyret{size
    - 1}. For each index, if the result of @pyret{f} is @pyret{some(value)},
    then @pyret{value} is included in the resulting array (it is not included
    for @pyret{none}). The size of the resulting array is equal to the number of
    @pyret{some} results.
    
    @examples{
check:
  fun even(n):
    if num-modulo(n, 2) == 0: some(n)
    else: none
    end
  end
  raw-array-build-opt(even, 10) is=~ [raw-array: 0, 2, 4, 6, 8]
end    
   } 
  
  @function["raw-array-map" #:contract (a-arrow (a-arrow "a" "b") (RA-of "a")) #:return (RA-of "b")]

  Creates a new array by applying @pyret{f} to each element of the array.
  Similar to @pyret-id["map" "lists"]. Has an argument order that works with
  @pyret{for}.

  @examples{
check:
  a = [raw-array: "apple", "banana", "plum"]
  lengths = for raw-array-map(s from a):
    string-length(s)
  end
  lengths is=~ [raw-array: 5, 6, 4]
end
  }
  
  Note that the test uses @pyret-id["is=~" "testing"], because raw arrays are
  mutable and so the two values in the shown test are not
  @pyret-id["equal-always" "equality"], they are @pyret-id["equal-now"
  "equality"].
  
  @function["raw-array-filter" #:contract (a-arrow (a-arrow "a" B) (RA-of "a")) #:return (RA-of "a")]

  Applies function @pyret{f} to each element of @pyret{array} from left to right,
  constructing a new @pyret{RawArray} out of the elements for which @pyret{f}
  returned @pyret{true}.
  Similar to @pyret-id["map" "filter"]. Has an argument order that works with
  @pyret{for}.

  @examples{
check:
  a = [raw-array: "apple", "banana", "plum"]
  p-words = for raw-array-filter(s from a):
    string-contains(s, "p")
  end
  p-words is=~ [raw-array: "apple", "plum"]
end
  }
  
  @function["raw-array-sort-nums" #:contract (a-arrow (RA-of N) B) #:return (RA-of N)]

  Sorts the given array @emph{in-place} in ascending or descending order
  according to the @pyret{ascending} parameter. Returns the reference to the
  original array, which will have its contents mutably updated.

  @examples{
check:
  a = [raw-array: 9, 2, 3, 1]
  asc = raw-array-sort-nums(a, true)
  a is=~ [raw-array: 1, 2, 3, 9]
  asc is<=> a
  
  desc = raw-array-sort-nums(a, false)
  a is=~ [raw-array: 9, 3, 2, 1]
  desc is<=> a
end
}

  @function["raw-array-sort-by" #:contract (a-arrow (RA-of "a") (a-arrow A N) B) #:return (RA-of "a")]

  Creates a new array containing the sorted contents of given array. The sort
  order is determined by calling the @pyret{key} function on each element to
  get a number, and sorting the elements by their key value (in increasing key
  order if @pyret{ascending} is @pyret{true}, decreasing if @pyret{false}).
  
  according to the @pyret{ascending} parameter. Returns the reference to the
  original array, which will have its contents mutably updated.

  @examples{
check:
  a = [raw-array: "banana", "plum", "apple"]
  asc = raw-array-sort-by(a, string-length, true)
  
  asc is=~ [raw-array: "plum", "apple", "banana"]
  asc is-not<=> a
end
}
  

  @function["raw-array-fold" #:contract (a-arrow (a-arrow "b" "a" N "b") "b" (RA-of "a") N "b") #:return "b"]

  Combines the elements in the array with a function that accumulates each
  element with an intermediate result.  Similar to @pyret-id["fold_n" "lists"].
  Has an argument order that works with @pyret{for}.  The numeric argument to
  the accumulator is the index of the current element.

  @examples{
check:
  a = [raw-array: "a", "b", "c"]
  str = for raw-array-fold(str from "", elt from a, i from 0):
    if i < (raw-array-length(a) - 1):
      str + elt + ": " + tostring(i) + ", "
    else:
      str + elt + ": " + tostring(i)
    end
  end
  str is "a: 0, b: 1, c: 2"
end
  }

  @function["raw-array-duplicate"]

  Returns a copy of the given array, such that corresponding elements in the
  result are identical to those in the source array.
  
  @examples{
check:
  a = [raw-array: 1, 2, 3]
  b = raw-array-duplicate(a)
  a is=~ b
  b is=~ a

  a is<=> a
  a is-not<=> b
  b is-not<=> a
  b is<=> b

  raw-array-set(a, 1, 1)

  raw-array-get(a, 1) is 1
  raw-array-get(b, 1) is 2

  c = [raw-array: {1; 2}, {3; 4}]
  d = raw-array-duplicate(c)

  c is-not<=> d
  raw-array-get(c, 0) is<=> raw-array-get(d, 0)
  raw-array-get(c, 1) is<=> raw-array-get(d, 1)
end
  }

}
