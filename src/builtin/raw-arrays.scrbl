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
      (name "raw-array-fold")
      (arity 4)
      (args ("f" "init" "array" "start-index"))
      (doc ""))
    (unknown-item
      (name "raw-array")
      ;; { maker of raw-arrays ... }
      )
))


@docmodule["raw-arrays" #:noimport #t #:friendly-title "RawArray"]{
   @type-spec["RawArray" (list "a")]{

   A @pyret{RawArray} is a mutable, fixed-length collection indexed
   by non-negative intgers.  They are a very thin wrapper around native
   JavaScript arrays, and are manipulated entirely via functions.  They are the
   implementation mechanism for Pyret @seclink{arrays}, which provide a nicer
   API for interacting with them.

   @pyret{RawArray}s are widely used internally in Pyret
   language development.
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

}
