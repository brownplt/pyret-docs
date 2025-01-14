#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")
@(require (only-in scribble/core delayed-block))

@(define (set-method name #:alt-docstrings (docs "") #:contract (contract #f) #:return (return #f))
  (method-doc "Set" #f name #:alt-docstrings docs #:contract contract #:return return))

@(define s-of-a '(a-app (a-id "Set" (xref "sets" "Set")) "a"))
@(define l-of-a '(a-app (a-id "List" (xref "lists" "List")) "a"))
@(define boolean '(a-id "Boolean" (xref "<global>" "Boolean")))

@(append-gen-docs
  `(module "sets"
    (path "src/js/base/runtime-anf.js")
    (fun-spec
      (name "set")
      (arity 1))
    (fun-spec
      (name "list-to-set")
      (arity 1))
    (fun-spec
      (name "list-to-list-set")
      (arity 1))
    (fun-spec
      (name "list-to-tree-set")
      (arity 1))
    (fun-spec (name "list-set"))
    (fun-spec (name "tree-set"))
    (data-spec
      (name "Set")
      (type-vars (a-id "a"))
      (variants ("set"))
      (shared
        ((method-spec
          (name "fold")
          (arity 3)
          (params [list: leaf("b")])
          (args ("self" "f" "base"))
          (return (a-id "b"))
          (contract
            (a-arrow
              ,s-of-a
              (a-arrow "b" "a" "b")
              "b"))
        )
        (method-spec
          (name "size")
          (arity 1)
          (params)
          (args ("self"))
        )
        (method-spec
          (name "pick")
          (arity 1)
          (params)
          (args ("self"))
        )
        (method-spec
          (name "member")
          (arity 2)
          (params)
          (args ("self" "elt"))
          (return ,boolean)
          (contract
            (a-arrow
              ,s-of-a
              "a"
              ,boolean))
        )
        (method-spec
          (name "add")
          (arity 2)
          (params)
          (args ("self" "elt"))
          (return ,s-of-a)
          (contract
            (a-arrow
              ,s-of-a
              "a"
              ,s-of-a))
        )
        (method-spec
          (name "remove")
          (arity 2)
          (params)
          (args ("self" "elt"))
          (return ,s-of-a)
          (contract
            (a-arrow
              ,s-of-a
              "a"
              ,s-of-a)))
        (method-spec
          (name "to-list")
          (arity 1)
          (params)
          (args ("self"))
          (return ,l-of-a)
          (contract
            (a-arrow
              ,s-of-a
              ,l-of-a)))
        (method-spec
          (name "union")
          (arity 2)
          (params)
          (args ("self" "other"))
          (return ,s-of-a)
          (contract
            (a-arrow
              ,s-of-a
              ,s-of-a
              ,s-of-a)))
        (method-spec
          (name "intersect")
          (arity 2)
          (params)
          (args ("self" "other"))
          (return ,s-of-a)
          (contract
            (a-arrow
              ,s-of-a
              ,s-of-a
              ,s-of-a)))
        (method-spec
          (name "difference")
          (arity 2)
          (params)
          (args ("self" "other"))
          (return ,s-of-a)
          (contract
            (a-arrow
              ,s-of-a
              ,s-of-a
              ,s-of-a)))
        (method-spec
          (name "symmetric-difference")
          (arity 2)
          (params)
          (args ("self" "other"))
          (return ,s-of-a)
          (contract
            (a-arrow
              ,s-of-a
              ,s-of-a
              ,s-of-a)))
        ))
      )
  ))

@docmodule["sets"]{

@section{The Set Type}

@type-spec["Set" (list "a")]{

There are two underlying representations that sets may have:
@itemlist[

@item{List-based sets
work on all values that can be compared with the @pyret-id["equal-always"
"equality"] built-in function (this means that, for example, a set of functions
won't work).  List-based sets perform up to @emph{n} comparisons on addition, removal,
and membership testing, where @emph{n} is the number of elements in the set. (In order
to give this guarantee, list-based sets don't store duplicates; they avoid this by
scanning the whole list on addition.)}

@item{Tree-based sets require that all
elements implement the @pyret{_lessthan} method in order to perform
comparisons, and guarantee that only up to log(@emph{n}) less-than comparisons will be
performed for a set with @emph{n} elements on addition, removal, and membership
testing.}

]

There are no variants for @pyret-id{Set}s, and programs cannot use
@pyret{cases} statements with @pyret-id{Set}s.  Instead, they can be created
with the constructors below, and manipulated with the methods and functions
below.


Some methods, like @pyret-method["Set" "union"], combine multiple sets.  The
set on the left-hand side is the representation of the result.  For example, in

@pyret-block{
  [list-set: 1, 2].union([tree-set: 3, 4])
}

the result will be a @pyret{list-set}.
}

@section{Using Sets in Programs}

Some of the names provided for sets tend to overlap with those
provided for lists. The latter are built-in. Therefore, using the @pyret{include}
form is likely to cause name-clashes. It is wiser to import sets using a prefix name and
use the names below through that prefix.

@examples{
import sets as S

check:
  S.list-to-list-set([list: 1, 2, 1, 2]) is [S.list-set: 2, 1]
end
}

@section{Set Constructors}

@collection-doc["list-set" #:contract `(a-arrow ("elt" "a") ,(S-of "a"))]

Constructs a set out of the @pyret{elt}s, representing them as a list. Raises an exception
if the elements don't support equality.

@examples{
import sets as S

check:
  [S.list-set: 1, 2, 3] is [S.list-set: 1, 2, 3]
  [S.list-set: 1, 2, 2] is [S.list-set: 1, 2]
  [S.list-set: [list: 1], [list: 1], [list: 2]] is
    [S.list-set: [list: 2], [list: 1]]
end
}

@singleton-doc["Set" "empty-list-set" (S-of "a")]

An empty set, represented as a list.

@collection-doc["tree-set" #:contract `(a-arrow ("elt" "a") ,(S-of "a"))]

Constructs a set out of the @pyret{elt}s, representing them as a tree. Raises an exception
if the elements don't support the @pyret{<} operator via @pyret{_lessthan}.

@examples{
import sets as S

check:
  [S.tree-set: 1, 2, 3] is [S.tree-set: 1, 2, 3]
  [S.tree-set: 1, 2, 2] is [S.tree-set: 1, 2]
  [S.tree-set: [list: 1], [list: 1], [list: 2]] raises "binop-error"
end
}

@singleton-doc["Set" "empty-tree-set" (S-of "a")]

An empty set, represented as a tree.

@collection-doc["set" #:contract `(a-arrow ("elt" "a") ,(S-of "a"))]

Another name for @pyret-id{list-set}.

@function["list-to-list-set"
  #:contract (a-arrow (L-of "a") (S-of "a"))
  #:args (list (list "lst" #f))
  #:return (S-of "a")
]

Constructs a list-set out of the elements in the list.

@examples{
import sets as S

check:
  s1 = S.list-to-list-set([list: 1, 2, 3, 3, 3])
  s1 is [S.list-set: 1, 2, 3]
end
}


@function["list-to-tree-set"
  #:contract (a-arrow (L-of "a") (S-of "a"))
  #:args (list (list "lst" #f))
  #:return (S-of "a")
]

Constructs a tree-set out of the elements in the list.

@examples{
import sets as S

check:
  s1 = S.list-to-tree-set([list: 1, 2, 3, 3, 3])
  s1 is [S.tree-set: 1, 2, 3]
end
}


@function["list-to-set"
  #:contract (a-arrow (L-of "a") (S-of "a"))
  #:args (list (list "lst" #f))
  #:return (S-of "a")
]

Another name for @pyret-id["list-to-list-set"].

@section{Set Methods}

@set-method["add"]

Constructs a new set containing the added element if it was not already present.

@examples{
import sets as S

check:
  s1 = [S.set: 1, 2, 3]
  s2 = s1.add(4)
  s3 = s1.add(1)
  s2 is-not s1
  s3 is s1
  s1.size() is 3
  s2.size() is 4
  s3.size() is 3
end
}

@set-method["remove"]

Constructs a new set removing the element if it was present. It is @emph{not} an error to
remove an element that is not in the set; it simply leaves the set unchanged.

@examples{
import sets as S

check:
  s1 = [S.set: 1, 2, 3]
  s2 = s1.remove(3)
  s3 = s1.remove(4)
  s2 is-not s1
  s3 is s1
  s1.size() is 3
  s2.size() is 2
  s3.size() is 3
end
}

@set-method["size" #:alt-docstrings "" #:contract (a-arrow (S-of "a") N) #:return N]

Computes the number of elements in the set.

@examples{
import sets as S

check:
  [S.set: 1, 2, 3].size() is 3
  [tree-set: 1, 2, 3].size() is 3
  [list-set: 1, 2, 3].size() is 3
end
}

@set-method["member"]

Checks if @pyret{elt} is contained within this set (checking membership with
@pyret-id["equal-always" "equality"]).

@examples{
import sets as S

check:
  s1 = [S.set: 1, 2, 3]
  s1.member(1) is true
  s1.member(4) is false
end
}

@set-method["pick" #:alt-docstrings "" #:contract (a-arrow (S-of "a") (P-of "a" (S-of "a"))) #:return (P-of "a" (S-of "a"))]

@emph{Picks} an arbitrary element out of the set, and returns a
@pyret-id["Pick" "pick"] data structure.  If the set is empty,
then @pyret{.pick} returns a
@pyret-id["pick-none" "pick"].
Otherwise it returns a @pyret-id["pick-some" "pick"],
whose @pyret{elt} field stores the picked value and
whose @pyret{rest} field stores the rest of the set.

@examples{
import sets as S
import pick as P

check:
  fun sum-of-set(s :: S.Set):
    cases(P.Pick) s.pick():
      | pick-none => 0
      | pick-some(elt, rest) => elt + sum-of-set(rest)
    end
  end

  sum-of-set([S.set: 1, 2, 3, 4]) is 10
  sum-of-set([S.tree-set: 1, 2, 3, 4]) is 10

  [S.set:].pick() is P.pick-none
  [S.set: 1].pick() is P.pick-some(1, S.empty-list-set)
end
}

It is very important to note that
the order of elements returned from @pyret-method["Set" "pick"] is
non-deterministic, so multiple calls to @pyret-method["Set" "pick"] may not
produce the same result for the same set! Thus, in the following program:

@examples{
import sets as S
import pick as P

check:
  [S.set: 1, 2].pick() is P.pick-some(1, [S.set: 2])
  [S.set: 1, 2].pick() is P.pick-some(2, [S.set: 1])
end
}

Sometimes both tests will pass, sometimes one will pass and the other
fail, and sometimes both tests will fail! We can, however, write the
following tests that will @emph{always} pass:

@examples{
import sets as S
import pick as P

check:
  fun one-of(e, l): l.member(e) end

  [S.set: 1, 2].pick().elt is%(one-of) [list: 1, 2]
  [S.set: 1, 2].pick().rest is%(one-of)
  [list: [S.set: 1], [S.set: 2]]
end
}

@set-method["union"]

Computes the union of two sets.

@examples{
import sets as S

check:
  [S.list-set: 1, 2, 3].union([S.tree-set: 2, 3, 4])
    is [S.list-set: 1, 2, 3, 4]

  S.empty-tree-set.union([S.list-set: 3, 4, 4])
    is [S.tree-set: 3, 4]
end
}

@set-method["intersect"]

Computes the intersection of two sets.

@examples{
import sets as S

check:
  [S.list-set: 1, 2, 3].intersect([S.tree-set: 2, 3, 4])
    is [S.list-set: 2, 3]

  S.empty-tree-set.intersect([S.list-set: 3, 4, 4])
    is [S.tree-set: ]
end
}

@set-method["difference"]

Computes the difference of two sets.

@examples{
import sets as S

check:
  [S.list-set: 1, 2, 3].difference([S.tree-set: 2, 3, 4])
    is [S.list-set: 1]

  S.empty-tree-set.difference([S.list-set: 3, 4, 4])
    is [S.tree-set: ]
end
}

@set-method["symmetric-difference"]

Computes the symmetric difference of two sets.

@examples{
import sets as S

check:
  [S.list-set: 1, 2, 3].symmetric-difference([S.tree-set: 2, 3, 4])
    is [S.list-set: 1, 4]

  S.empty-tree-set.symmetric-difference([S.list-set: 3, 4, 4])
    is [S.tree-set: 3, 4]
end
}

@set-method["to-list"]

Converts the set into a list. There is no guarantee about the order of elements in the list.

@examples{
import sets as S

check:
  [S.list-set: 3, 1, 4, 1, 5, 9, 2].to-list().length() is 6
  [S.tree-set: 8, 6, 7, 5, 3, 0, 9].to-list().length() is 7
end
}

@set-method["fold"]

Applies @pyret{f} to each element of the set along with the accumulator
(starting with @pyret{base}) to produce a new value.  Traverses elements in an
unspecified order.

@examples{
import sets as S

check:
  fun one-of(e, l): l.member(e) end

  s = [S.tree-set: "1", "2", "3"]
  result = s.fold(string-append, "")

  result is%(one-of) [list: "123", "132", "213", "231", "312", "321"]
end
}

}