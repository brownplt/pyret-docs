#lang scribble/base

@(require scribble/core
          scribble/decode
          (only-in scribble/manual link)
          scriblib/footnote
          "../abbrevs.rkt"
          "../../scribble-api.rkt"
          scribble/html-properties)

@(define boolean '(a-id "Boolean" (xref "<global>" "Boolean")))
@(define eq '(a-id "EqualityResult" (xref "equality" "EqualityResult")))
@(define eqfun `(a-arrow ,A ,A ,B))
@(define numeqfun `(a-arrow ,N ,N ,B))
@(define eq3fun `(a-arrow ,A ,A ,eq))
@(define T (a-id "EqualityResult" (xref "equality" "EqualityResult")))
@(define (make-arg name type)
   `(,name ("type" "normal") ("contract" ,type)))

@(append-gen-docs
  `(module "equality"
    (path "src/js/base/runtime-anf.js")
    (data-spec
      (name "EqualityResult")
      (type-vars ())
      (variants ("Equal" "NotEqual" "Unknown"))
      (shared))
    (singleton-spec
      (name "Equal")
      (with-members))
    (constr-spec
      (name "NotEqual")
      (members (,(make-arg "reason" S) ,(make-arg "value1" "Any") ,(make-arg "value2" "Any"))))
    (constr-spec
      (name "Unknown")
      (members (,(make-arg "reason" S) ,(make-arg "value1" "Any") ,(make-arg "value2" "Any"))))
    (fun-spec
      (name "is-Equal")
      (arity 1)
      (params [list: ])
      (args ("val"))
      (return (a-id "Boolean" (xref "<global>" "Boolean")))
      (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
      (doc "Checks whether the provided argument is in fact a Equal"))
    (fun-spec
      (name "is-NotEqual")
      (arity 1)
      (params [list: ])
      (args ("val"))
      (return (a-id "Boolean" (xref "<global>" "Boolean")))
      (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
      (doc "Checks whether the provided argument is in fact a NotEqual"))
    (fun-spec
      (name "is-Unknown")
      (arity 1)
      (params [list: ])
      (args ("val"))
      (return (a-id "Boolean" (xref "<global>" "Boolean")))
      (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
      (doc "Checks whether the provided argument is in fact a Unknown"))
    (fun-spec
      (name "<")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "_lessthan")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "<=")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "_lessequal")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name ">")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "_greaterthan")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name ">=")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "_greaterequal")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "=~")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "equal-now")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "==")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "<>")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "equal-always")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "<=>")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "identical")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "within-abs")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
      (doc ""))
    (fun-spec
      (name "within-abs-now")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
      (doc ""))
    (fun-spec
      (name "within")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
      (doc ""))
    (fun-spec
      (name "within-now")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
      (doc ""))
    (fun-spec
      (name "within-rel")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
      (doc ""))
    (fun-spec
      (name "within-rel-now")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
      (doc ""))
    (fun-spec
      (name "within3")
      (arity 1)
      (args ("tol"))
      (return ,eq3fun)
      (doc ""))
    (fun-spec
      (name "within-abs3")
      (arity 1)
      (args ("tol"))
      (return ,eq3fun)
      (doc ""))
    (fun-spec
      (name "within-abs-now3")
      (arity 1)
      (args ("tol"))
      (return ,eq3fun)
      (doc ""))
    (fun-spec
      (name "within-rel3")
      (arity 1)
      (args ("tol"))
      (return ,eq3fun)
      (doc ""))
    (fun-spec
      (name "within-rel-now3")
      (arity 1)
      (args ("tol"))
      (return ,eq3fun)
      (doc ""))
    (fun-spec
      (name "equal-now3")
      (arity 2)
      (args ("val1" "val2"))
      (return ,eq)
      (doc ""))
    (fun-spec
      (name "equal-always3")
      (arity 2)
      (args ("val1" "val2"))
      (return ,eq)
      (doc ""))
    (fun-spec
      (name "identical3")
      (arity 2)
      (args ("val1" "val2"))
      (return ,eq)
      (doc ""))
    (fun-spec
      (name "roughly-equal")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc ""))
    (fun-spec
      (name "roughly-equal-now")
      (arity 2)
      (args ("val1" "val2"))
      (return ,boolean)
      (doc "")))
  )

@(define code pyret)

@(define equal-now-op @code{=~})
@(define equal-always-op @code{==})
@(define identical-op @code{<=>})

@docmodule["equality"]{

@section[#:tag "types-of-equality"]{Types of Equality}

Pyret has three notions of equality.  Two values can be @emph{equal now},
@emph{equal always}, and/or @emph{identical}.  The following table summarizes
the functions and operators that test for these relationships, and how they
compare to some other languages' operators:

@tabular[
  #:style (style #f (list (attributes '((style . "border-collapse: collapse;")))))
  #:column-properties (list (list (attributes '((style . "border: 1px solid black; padding: 5px;")))))
  (list
    (list
      @list{@bold{Name}}
      @list{@bold{Operator}}
      @list{@bold{Partial Predicate}}
      @list{@bold{Total Predicate}}
      @list{@bold{Similar To}}
    )
    (list
      @list{@emph{Equal Always}}
      @list{@code{==}}
      @list{@code{equal-always}}
      @list{@code{equal-always3}}
      @list{@code{=} (Ocaml)}
    )
    (list
      @list{@emph{Equal Now}}
      @list{@code{=~}}
      @list{@code{equal-now}}
      @list{@code{equal-now3}}
      @list{@code{equal?} (Racket); @code{==} (Python, Ruby)}
    )
    (list
      @list{@emph{Identical}}
      @list{@code{<=>}}
      @list{@code{identical}}
      @list{@code{identical3}}
      @list{
        @code{eq?} (Scheme);
        @code{==} (Ocaml);
        @code{===} (JavaScript);
        @code{is} (Python);
        @code{==} (Java)
      }
    )
    )
]

In most programs, you should use @secref["eq-fun-equal-always"] to compare
values that you want to check for same-ness.  If you are working with mutable
data, you may want to consider the special behavior of
@secref["eq-fun-equal-now"]. For
some optimizations, defensive code, and capability patterns, you may have a
reason to use @secref["eq-fun-identical"].

@section[#:tag "eq-fun-equal-always"]{Equal Always}

@function["equal-always" #:contract (a-arrow A A B)]
@function["==" #:contract (a-arrow A A B)]

Checks if two values will be equal for all time. When it returns
@pyret{true}, it means the two values can always be used in place of
one another. This is explained in detail below and its relationship to
other equality functions is given in @secref["eq-func-relationship"].

The function @pyret-id{equal-always} and infix operator @equal-always-op have
the same behavior.
While the infix operator may sometimes be more readable, the function
name conveys meaning that may not be clear from the infix operator's
symbolic form. In addition, the infix operator is not a function and
hence cannot be passed as a parameter, etc.

@pyret-id{equal-always} checks for primitive and structural equality
like @pyret-id{equal-now}, with the exception that it stops at mutable
data and only checks that the mutable values are @pyret-id{identical}.
Checking that mutable values are @pyret-id{identical} is what ensures
that if two values were @pyret-id{equal-always} at any point, they
will still be @pyret-id{equal-always} later.

@function["<>" #:contract (a-arrow A A B)]

The negation of @pyret{==}: returns @pyret{true} if the values are not
@pyret{equal-always} and @pyret{false} otherwise.

@subsection[#:tag "s:always-equal-mutable"]{Equal Always and Mutable Data}

Here are some examples of @pyret-id{equal-always} stopping at mutable data, but
checking immutable data, contrasted with @pyret-id{equal-now}.

@pyret-block{
data MyBox:
  | my-box(ref x)
end

check:
  b1 = my-box(1)
  b2 = my-box(1)

  b1 is-not%(equal-always) b2
  b1 is%(equal-now) b2
  b2!{x : 2}

  b1 is-not%(equal-always) b2
  b1 is-not%(equal-now) b2

  b3 = my-box(2)

  # remember that b2 currently refers to 2
  l1 = [list: b1, b2]
  l2 = [list: b1, b2]
  l3 = [list: b1, b3]

  l1 is%(equal-now) l2
  l1 is%(equal-always) l2
  l1 is-not%(identical) l2

  l1 is%(equal-now) l3
  l1 is-not%(equal-always) l3
  l1 is-not%(identical) l3

  b2!{x: 5}

  l1 is%(equal-now) l2
  l1 is%(equal-always) l2
  l1 is-not%(identical) l2

  l1 is-not%(equal-now) l3
  l1 is-not%(equal-always) l3
  l1 is-not%(identical) l3
end
}

@;{
@subsection[#:tag "s:always-equal-frozen"]{Equal Always and Frozen Mutable Data}

  Mutable references can be @emph{frozen}[REF] (as with @code{graph:}), which
  renders them immutable.  @code{equal-always} @emph{will} traverse frozen
  mutable fields, and will check for same-shaped cycles.  So, for example, it
  will succeed for cyclic graphs created with @code{graph:} that have the same
  shape:

@pyret-block{
  data MList:
    | mlink(ref first, ref rest)
    | mempty
  end
  mlist = {
    make: lam(arr):
      # fold mlink over arr
    end
  }

  graph:
    BOS = [mlist: WOR, PROV]
    PROV = [mlist: BOS]
    WOR = [mlist: BOS]
  end

  graph:
    SF = [mlist: OAK, MV]
    MV = [mlist: SF]
    OAK = [mlist: SF]
  end

  SF is%(equal-now) BOS
  PROV is%(equal-now) WOR
  PROV is%(equal-now) OAK
  OAK is%(equal-now) PROV
}
}

@section[#:tag "eq-fun-equal-now"]{Equal Now}

@function["equal-now" #:contract (a-arrow A A B)]
@function["=~" #:contract (a-arrow A A B)]

Checks if the two values are equal @emph{now}. They may not be equal
later, so they can't be used in place of one another at all
times. This is explained in detail below and its relationship to
other equality functions is given in @secref["eq-func-relationship"].

The function @pyret-id{equal-now} and infix operator @equal-now-op have
the same behavior.
While the infix operator may sometimes be more readable, the function
name conveys meaning that may not be clear from the infix operator's
symbolic form. In addition, the infix operator is not a function and
hence cannot be passed as a parameter, etc.

@subsection[#:tag "s:equal-now-primitives"]{Equal Now and Primitives}

@code{equal-now} checks primitive equality on numbers, strings, and
booleans:

@examples{
check:
  5 is%(equal-now) 5
  5 is-not%(equal-now) 6
  "abc" is%(equal-now) "abc"
  "a" is-not%(equal-now) "b"
  "a" is-not%(equal-now) 5
end
}

@subsection[#:tag "s:equal-now-structural"]{Equal Now and Structured Data}

For instances of @code{data} (including, for example, instances of
@pyret-id["List" "lists"]), and objects, @pyret-id{equal-now} traverses their
members and checks for pairwise equality.  So, for example, lists will
recursively check that their contents are the same, including the case where
their contents are objects:

@examples{
check:
  l1 = [list: 1, 2, 3]
  l2 = [list: 1, 2, 3]

  l1 is%(equal-now) l2
  link(1, l1) is-not%(equal-now) l2

  l3 = [list: {x: 5}]
  l4 = [list: {x: 5}]
  l5 = [list: {x: 6}]
  l3 is%(equal-now) l4
  l3 is-not%(equal-now) l5
end
}

@subsection[#:tag "s:equal-now-mutable"]{Equal Now and References}

Equal Now checks the contents of mutable data it reaches.  This gives it its
name: since it only checks the @emph{current} values, and those fields might
change, it is not true that if @code{e1 =~ e2}, then later @code{e1 =~ e2} will
hold again.  For example:

@examples{
data MyBox:
  | my-box(ref x)
end

check:
  b1 = my-box(1)
  b2 = my-box(1)

  b1 is%(equal-now) b2
  b1!{x : 2}

  b1 is-not%(equal-now) b2
end
}

Equal Now will recognize when references form a cycle, and cycles of the same
shape are recognized as equal (even though the references might change their
contents later):

@examples{
data InfiniteList:
  | i-link(first, ref rest)
  | i-empty
end

check:
  l1 = i-link(1, i-empty)
  l2 = i-link(1, i-empty)
  l3 = i-link(1, i-link(2, i-empty))
  l1!{rest : l1}
  l2!{rest : l2}
  l3!rest!{rest : l3}

  l1 is%(equal-now) l2
  l1 is-not%(equal-now) l3
end
}

@section[#:tag "eq-fun-identical"]{Identical}

@function["identical" #:contract (a-arrow A A B)]
@function["<=>" #:contract (a-arrow A A B)]

Checks if two seemingly different values are in fact exactly the same
value. When it returns @pyret{true}, it means the two values can
always be used in place of one another (because they are in fact the
same value). This is explained in detail below and its relationship to
other equality functions is given in @secref["eq-func-relationship"].

The function @pyret-id{identical} and infix operator @identical-op have
the same behavior.
While the infix operator may sometimes be more readable, the function
name conveys meaning that may not be clear from the infix operator's
symbolic form. In addition, the infix operator is not a function and
hence cannot be passed as a parameter, etc.

@subsection[#:tag "s:identical-primitives"]{Identical and Primitives}

Identical has the same behavior on primitives as Equal Now
(@secref["s:equal-now-primitives"]).

@subsection[#:tag "s:identical-structural"]{Identical and Structural Equality}

Identical does not visit members of objects or data instances.  Instead, it
checks if the values are actually the same exact value (the operator is meant
to indicate that the values are interchangable).  So objects with the same
fields are not identical to anything but themselves:

@examples{
check:
  o = { x: 5 }
  o2 = { x: 5 }
  o is-not%(identical) o2
  o is%(identical) o
  o2 is%(identical) o2
end
}

@subsection[#:tag "s:identical-mutable"]{Identical and Mutable Data}

Identical does not inspect the contents of mutable data, either.  It can be
used to tell if two references are @emph{aliases} for the same underlying
state, or if they are in fact different (even though they may be equal right
now).

@examples{
data InfiniteList:
  | i-link(first, ref rest)
  | i-empty
end

check:
  l1 = i-link(1, i-empty)
  l2 = i-link(1, i-empty)
  l1!{rest : l1}
  l2!{rest : l2}

  l1 is%(identical) l1
  l1!rest is%(identical) l1
  l1 is-not%(identical) l2
  l1!rest is-not%(identical) l2

  l2 is%(identical) l2
  l2!rest is%(identical) l2
  l2 is-not%(identical) l1
  l2!rest is-not%(identical) l1
end
}

@;{
  Identical differs from the other equality operators on mutable data in that
  on frozen immutable data, it does not inspect the contents of the reference.
  Instead, it checks that the two references are in fact the same reference.
  So, for example, the behavior of the @code{graph:} example from above
  differs:

@pyret-block{
  data MList:
    | mlink(ref first, ref rest)
    | mempty
  end
  mlist = {
    make: lam(arr):
      # fold mlink over arr
    end
  }

  graph:
    BOS = [mlist: WOR, PROV]
    PROV = [mlist: BOS]
    WOR = [mlist: BOS]
  end

  graph:
    SF = [mlist: OAK, MV]
    MV = [mlist: SF]
    OAK = [mlist: SF]
  end

  SF isnot%(identical) BOS
  PROV isnot%(identical) WOR
  PROV isnot%(identical) OAK
  OAK isnot%(identical) PROV

  BOS!rest is%(identical) PROV
  BOS is%(identical) BOS
}
}

@section[#:tag "eq-func-relationship"]{Properties of Equality Functions}

The discussion above hints at a relationship between the three functions.  In
particular, if two values are Identical, they ought to be Equal Always, and if
they are Equal Always, they ought to be Equal Now.  The following table
summarizes this relationship, which in fact does hold:

@tabular[
  #:style (style #f (list (attributes '((style . "border-collapse: collapse;")))))
  #:column-properties (list (list (attributes '((style . "border: 1px solid black; padding: 5px;")))))
  (list
    (list
      @list{If ↓, then →}
      @list{@code{v1 <=> v2} could be...}
      @list{@code{v1 == v2} could be...}
      @list{@code{v1 =~ v2} could be...}
    )
    (list
      @list{@code{v1 <=> v2 is true}}
      "-"
      @;@list{@code{true} only}
      @list{@code{true} only}
      @list{@code{true} only}
    )
    (list
      @list{@code{v1 == v2 is true}}
      @list{@code{true} or @code{false}}
      "-"
      @;@list{@code{true} only}
      @list{@code{true} only}
    )
    (list
      @list{@code{v1 =~ v2 is true}}
      @list{@code{true} or @code{false}}
      @list{@code{true} or @code{false}}
      "-"
      @;@list{@code{true} only}
    )
    )
]

This table doesn't have all the @pyret{false} cases in it, because we need to
complete the story for a few values that haven't been discussed before we can
give the whole picture.

@section[#:tag "s:bounded-equalities"]{Bounded Equalities}

When comparing numbers, it's often useful to be able to compare within a
range.  For example, if we write an algorithm that computes an answer to
within a given tolerance, we may want to check if the answer is within that
tolerance.

@pyret-block{
check:
  sqrt-5 = num-sqrt(5)
  (sqrt-5 < 2.23) is true
  (sqrt-5 > 2.22) is true
end
}

Pyret has a family of built-in functions for cases like this, and the default
is @pyret-id{within}.  To explain it precisely, it is clearer to first explain the
other two functions, @pyret-id{within-rel} and @pyret-id{within-abs}:

@function["within-rel" #:contract (a-arrow N A)]

It takes an argument representing the @emph{relative error}, and returns a
function that can be used to check equality up to that relative error.  For
example, we can check if an answer is within 10% of a desired result:

@pyret-block{
check:
  within-10-percent = within(0.1)
  within-10-percent(9.5, 10.5) is true
end
}

Relative difference is defined by multiplying the @emph{smaller} of the two
numbers by @pyret{tol}, and checking that the result is less than the
difference between them.  That is, in the expression above, @pyret-id{within}
checks:

@pyret-block{
num-abs(9.5 - 10.5) <= (0.1 * num-min(9.5, 10.5))
}

@note{Converting to exact numbers first avoids overflows on computing the
mean.}
Put yet another way, aside from some slight differences in bounds checking for
errors, we could implement the numeric comparison of @pyret-id{within} as:

@pyret-block{
fun my-within(tol):
  lam(left, right):
    num-abs(num-exact(left) - num-exact(right))
      <= num-exact(tol) * num-min(num-abs(left), num-abs(right))
  end
end
}

The @pyret{tol} argument must be between @pyret{0} and @pyret{1}.

Finally, @pyret-id{within-rel} accepts @emph{any} two values, not just numbers.
On non-numeric arguments, @pyret-id{within} traverses the structures just as
in @pyret-id{equal-always}, but deferring to the bounds-checking equality when
a pair of numbers is encountered.  All other values are compared with
@pyret-id{equal-always}.

@examples{
check:
  l7 = [list: 1]
  l8 = [list: ~1.2]
  l7 is%(within-rel(0.5))  l8
  l7 is-not%(within-rel(0.1)) l8
  l7 is%(within-rel(~0.5))  l8
  l7 is-not%(within-rel(~0.1)) l8
end
}

@function["within-abs" #:contract (a-arrow N A)]

Like @pyret-id{within-rel}, but compares with @emph{absolute} tolerance rather
than relative.  The definition is equivalent to:

@pyret-block{
fun my-within-abs(tol):
  lam(left, right):
    num-abs(num-exact(left) - num-exact(right)) <= tol
  end
end
}

(Note that the right-hand side of the inequality here is @emph{not} multiplied
by the magnitude of the values being compared: the tolerance is therefore
@emph{absolute}, rather than relative to the magnitudes of the values.)

@examples{
check:
  la = [list: 10]
  lb = [list: ~12]
  la is%(within-abs(2))  lb
  la is-not%(within-abs(1))  lb
  la is%(within-abs(~5.5))  lb
  la is-not%(within-abs(~1.9999)) lb
end
}

@function["within" #:contract (a-arrow N A)]
@function["roughly-equal" #:contract (a-arrow A A B)]

The definitions above work smoothly, but provide unintuitive behavior when both
values are tiny.  In particular, there are @emph{no values at all} that are
relatively close to zero except zero itself, since the magnitude used to scale
the relative tolerance...is zero.  For many purposes, especially with testing
(see below) and especially when first developing code, it is common to want to
specify a rough tolerance and not especially care whether that tolerance is
relative or absolute.  Accordingly, @pyret-id{within} is a function defined to
``smoothe'' the behavior of @pyret-id{within-rel} and @pyret-id{within-abs},
such that the tolerance is treated as @emph{relative} when the numbers are
large in magnitude, and as @emph{absolute} as they approach zero:

@examples{
check:
  # For large numbers, within behaves like within-rel
  1000 is%(within(0.1)) 1010
  1000 is-not%(within-abs(0.1)) 1010
  1000 is%(within-rel(0.1)) 1010
  # For small numbers, wtihin behaves like within-abs
  0 is%(within(0.1)) 0.0000001
  0 is-not%(within-rel(0.1)) 0.000001
  0 is%(within-abs(0.1)) 0.000001
end
}

For even simpler ergonomics, @pyret-id{roughly-equal} is defined to be
@pyret{within(0.000001)}, that is, an error tolerance of one-millionth, or six
digits of accuracy.  This tolerance works well in many cases, and the more
explicit forms are always available, when more precise control over tolerances
is required.

It's common to use @pyret-id{within} along with @pyret-id["is%" "testing"] to
define the binary predicate inline with the test:

@examples{
check:
  num-sqrt(10) is%(within(0.1)) 3.2
  num-sqrt(10) is-not%(within(0.1)) 5
end
}

As a convenient shorthand, @pyret{is-roughly} is defined as a shorthand for
@pyret-id["is%" "testing"](@pyret-id{roughly-equal}):

@examples{
check:
  num-acos(-1) is-roughly ~3.14159
  num-acos(-1) is%(roughly-equal) ~3.14159
  num-acos(-1) is%(within(0.000001)) ~3.14159
end
}

@function["within-now" #:contract (a-arrow N A)]
@function["within-rel-now" #:contract (a-arrow N A)]
@function["within-abs-now" #:contract (a-arrow N A)]
@function["roughly-equal-now" #:contract (a-arrow A A B)]

Like @pyret-id{within}, @pyret-id{within-rel}, @pyret-id{within-abs} and @pyret-id{roughly-equal}, but
they traverse mutable structures as in @pyret{equal-now}.

@examples{
check:
  aa = [array: 10]
  ab = [array: ~12]
  aa is%(within-rel-now(~0.2))  ab
  aa is-not%(within-rel(~0.2)) ab
  aa is%(within-abs-now(2))  ab
  aa is-not%(within-abs(2))  ab
end
}


@section[#:tag "s:undefined-equalities"]{Undefined Equalities}

For some values, Pyret refuses to report @pyret{true} or @pyret{false} for any
equality predicate, and raises an error instead.  For example:

@pyret-block{
check:
  (~3 == ~3) raises "equality-failure"

  (1 == ~1) raises "equality-failure"

  (lam(x): x end == lam(y): y end) raises "equality-failure"
end
}

This section discusses why this is the case.

@subsection[#:tag "s:roughnum-equality"]{Roughnums and Equality}

@note{@link["http://htdp.org/2003-09-26/Book/curriculum-Z-H-41.html#node_chap_33"]{How
to Design Programs} describes this design space well.} Numbers'
representations in programs reflect a number of tradeoffs, but the upshot is
that numbers have finite, approximate representations for performance reasons.
Numbers like @pyret{e}, @pyret{π}, and @pyret{√2} are only represented up to
some approximation of their true (irrational) value.  When such a result is
used in a computation, it represents a @emph{rough approximation} of the true
value.

Pyret calls these numbers @pyret-id["Roughnum" "numbers"]s, and they have
special rules related to equality.  In particular, they @emph{cannot} be
directly compared for equality, even if it seems like they ought to be equal:

@pyret-block{
check:
  (~3 == ~3) raises "equality-failure"
end
}

In addition, @pyret-id["Roughnum" "numbers"]s cannot be compared for equality
with @pyret-id["Exactnum" "numbers"]s, either.

@pyret-block{
check:
  (~0.1 == 0.1) raises "equality-failure"
end
}

@note{This example is not Pyret-specific, but matches the behavior of
@link["https://en.wikipedia.org/wiki/IEEE_floating_point"]{IEEE
floating point}.}
Returning either @pyret{true} or @pyret{false} in this case would be
misleading, as because of unavoidable inaccuracies,
both of the following expressions evaluate to @pyret{~0.1}:

@pyret-block{
(~1 - ~0.9) + 0.00000000000000003
~0.2 - ~0.1
}

So in the following check block, if we chose either @pyret{true} or @pyret{false} for
the result of @pyret{~0.1 == 0.1}, one of the tests would have a misleading failure:

@pyret-block{
check:
  ((~1 - ~0.9) + 0.00000000000000003) is 0.1
  (~0.2 - ~0.1) is 0.1
end
}

For example, if Pyret answered @pyret{true} for the rough equivalent,
@pyret{~0.1 == ~0.1}, then this test would pass:

@pyret-block{
check:
  ((~1 - ~0.9) + 0.00000000000000003) is (~0.2 - ~0.1)
end
}

To avoid giving misleading answers in cases like these, Pyret triggers an
error on any number-to-number comparison that involves a @pyret-id["Roughnum"
"numbers"], which looks like:

@verbatim{
These two values cannot be compared for direct equality:

~0.1
~0.1

Approximations of numbers (Roughnums) cannot be compared for equality. The
program may need to use within().
}

If you see this error, it's a hint that the program should be using an
equality from the @pyret-id["within"] family of functions to do a relative
comparison, rather than a direct equality comparison.  So in this case, we
could check that the answer is equal up to an relative error of @pyret{0.001}:

@pyret-block{
check:
  ((~1 - ~0.9) + 0.00000000000000003) is%(within(0.001)) (~0.2 - ~0.1)
end
}

It can be useful to check that two @pyret-id["Roughnum" "numbers"]s are
actually indistinguishable, even though they may be approximating different
values.  This can be expressed by checking that the numbers are within a
tolerance of @pyret{~0}:

@pyret-block{
check:
  ((~1 - ~0.9) + 0.00000000000000003) is%(within(~0)) (~0.2 - ~0.1)
end
}

Note that the same won't work for a tolerance of @pyret{0}, the exact zero,
which will give an error if used to compare two @pyret-id["Roughnum"
"numbers"]s.

@subsection[#:tag "s:function-equality"]{Functions and Equality}

When comparing two functions or two methods, all the equality operators raise
an exception.  Why?  Well, the traditional way to compare functions for
equality (short of solving the halting problem), is to use reference equality
(or @pyret-id{identical}) on the functions' representations, the same way as
mutable data works.  For a hint of why this can be a misleading definition of
equality, consider this data definition:

@pyret-block{
data Stream<a>:
  | stream(first :: a, rest :: (-> Stream<a>))
end
check:
  fun mk-ones(): stream(1, mk-ones) end
  ones = mk-ones()
  ones is ones # Should this succeed?
  ones is mk-ones() # What about this?
  ones.rest() is mk-ones() # Or this...?
end
}

All of these values (@code{ones}, @code{mk-ones()}, etc.) have the same
behavior, so we could argue that @code{is} (which uses @code{==} behind the
scenes) ought to succeed on these.  And indeed, if we used reference equality,
it would succeed.  But consider this small tweak to the program:

@pyret-block{
check:
  fun mk-ones():
    stream(1, lam(): mk-ones() end)  # <-- changed this line
  end
  ones = mk-ones()
  ones is ones # Should this succeed?
  ones is mk-ones() # What about this?
  ones.rest() is mk-ones() # Or this...?
end
}

If we used reference equality on these functions, all of these tests would
now fail, and @code{ones} @emph{has the exact same behavior}.  Here's the
situation:

@note{In fact, a @link["http://en.wikipedia.org/wiki/Rice's_theorem"]{famous
result in theoretical computer science} is that it is impossible to figure out
out if two functions do the same thing in general, even if it is possible in
certain special cases (like reference equality).}

When reference equality returns @code{true}, we know that the two functions
must have the same behavior.  But when it returns @code{false}, we know
nothing.  The functions may behave exactly the same, or they might be
completely different, and the equality predicate can't tell us either way.

Pyret takes the following stance: You probably should rethink your program if
it relies on comparing functions for equality, since Pyret cannot give reliable
answers (no language can).  So, all the examples above (with one notable
exception) actually raise errors:

@pyret-block{
  check:
    fun mk-ones():
      stream(1, lam(): mk-ones() end)  # <-- changed this line
    end
    ones = mk-ones()
    ones == ones is true
    ones == mk-ones() raises "Attempted to compare functions"
    ones.rest() == mk-ones() raises "Attempted to compare functions"
  end
}

The first test is true because two @pyret-id{identical} values are considered
@pyret-id{equal-always}.  This is an interesting point in this design space
that Pyret may explore more in the future -- it isn't clear if the benefits of
this relationship between @pyret-id{identical} and @pyret-id{equal-always} are
worth the slight brittleness in the above example.

@para{
@bold{Note 1}: Functions can be compared with non-function values and return
@code{false}.  That is, the equality operators only throw the error if actual
function values need to be compared to one another, not if a function value is
compared to another type of value:
}

@pyret-block{
  check:
    f = lam(): "no-op" end
    g = lam(): "also no-op" end

    f == f raises "Attempted to compare functions"
    f == g raises "Attempted to compare functions"
    g == f raises "Attempted to compare functions"

    5 is-not%(equal-always) f

    { x: 5 } is-not%(equal-always) { x: f }
  end
}

@para{
  @bold{Note 2}: This rule about functions interacts with structural equality.
  When comparing two values, it seems at first unclear whether the result
  should be @code{false} or an error for this test:
  }

@pyret-block{
  check:
    { x: 5, f: lam(): "no-op" end } is%(equal-always)
      { x: 6, f: lam(): "no-op" end }
  end
}

This comparison will return @code{false}.  The rule is that if the equality
algorithm can find values that differ without comparing functions, it will
report the difference and return @code{false}.  However, if all of the
non-function comparisons are @code{true}, and some functions were compared,
then an error is raised.  A few more examples:

@pyret-block{

  check:
    o = { x: 5, y: { z: 6 }, lam(): "no-op" end }
    o2 = { x: 5, y: { z: 7 }, lam(): "no-op" end }

    (o == o) raises "Attempted to compare functions"
    o is-not%(equal-always) o2  # Test succeeds, because z fields differ
  end

}

@section[#:tag "s:total-equality-predicates"]{Total Equality Functions (Avoiding Incomparability Errors)}

Most Pyret programs should be written using @code{equal-always},
@code{equal-now}, and @code{identical}, which guarantee that an error will be
raised if functions are compared.  Some programs, however, need to be able to
compare arbitrary values, and it's convenient to have the ability to compare
values without raising an exception.  Since the equality of functions is
unknown, we define the result of a total equality check with a new datatype:

  @data-spec2["EqualityResult" (list) (list
  @singleton-spec2["EqualityResult" "Equal"]
  @constructor-spec["EqualityResult" "NotEqual" `(,(make-arg "reason" S)
                                                  ,(make-arg "value1" "Any")
                                                  ,(make-arg "value2" "Any"))]
  @constructor-spec["EqualityResult" "Unknown" `(,(make-arg "reason" S)
                                                 ,(make-arg "value1" "Any")
                                                 ,(make-arg "value2" "Any"))]
  )]

  @nested[#:style 'inset]{
  @singleton-doc["EqualityResult" "Equal" T]
  @constructor-doc["EqualityResult" "NotEqual" `(,(make-arg "reason" S)
                                                 ,(make-arg "value1" "Any")    
                                                 ,(make-arg "value2" "Any")) T]
  @constructor-doc["EqualityResult" "Unknown" `(,(make-arg "reason" S)
                                                ,(make-arg "value1" "Any")
                                                ,(make-arg "value2" "Any")) T]

  @function["is-Equal" #:alt-docstrings ""]
  @function["is-NotEqual" #:alt-docstrings ""]
  @function["is-Unknown" #:alt-docstrings ""]
  }

We define three parallel functions to the equality predicates that return
@pyret-id{EqualityResult} values.  They return @pyret-id{Equal} and
@pyret-id{NotEqual} whenever the corresponding function would, and
@pyret-id{Unknown} whenever the corresponding function would throw an error:

  @function["equal-always3" #:contract (a-arrow A A T)]
  @function["equal-now3" #:contract (a-arrow A A T)]
  @function["identical3" #:contract (a-arrow A A T)]

@examples{
check:
  f = lam(): 5 end
  equal-always3(f, f) is Unknown
  equal-always3(f, 5) satisfies is-NotEqual
  equal-now3(f, f) is Unknown
  equal-now3("a", f) satisfies is-NotEqual
  identical3(f, f) is Unknown
  identical3("a", f) satisfies is-NotEqual
end
}

We can now modify our table from above to be more complete:

@tabular[
  #:style (style #f (list (attributes '((style . "border-collapse: collapse;")))))
  #:column-properties (list (list (attributes '((style . "border: 1px solid black; padding: 5px;")))))
  (list
    (list
      @list{If ↓, then →}
      @list{@code{identical(v1, v2)} could be...}
      @list{@code{equal-always(v1, v2)} could be...}
      @list{@code{equal-now(v1, v2)} could be...}
    )
    (list
      @list{@code{identical(v1, v2) is Equal}}
      "-"
      @;@list{@code{Equal} only}
      @list{@code{Equal} only}
      @list{@code{Equal} only}
    )
    (list
      @list{@code{equal-always(v1, v2) is Equal}}
      @list{@code{Equal} or @code{NotEqual}}
      "-"
      @;@list{@code{Equal} only}
      @list{@code{Equal} only}
    )
    (list
      @list{@code{equal-now(v1, v2) is Equal}}
      @list{@code{Equal} or @code{NotEqual}}
      @list{@code{Equal} or @code{NotEqual}}
      "-"
      @;@list{@code{Equal} only}
    )
    (list "" "" "" "")
    (list
      @list{@code{identical(v1, v2) is NotEqual}}
      "-"
      @;@list{@code{NotEqual} only}
      @list{@code{Equal} or @code{NotEqual} or @code{Unknown}}
      @list{@code{Equal} or @code{NotEqual} or @code{Unknown}}
    )
    (list
      @list{@code{equal-always(v1, v2) is NotEqual}}
      @list{@code{NotEqual} only}
      "-"
      @;@list{@code{NotEqual} only}
      @list{@code{Equal} or @code{NotEqual} or @code{Unknown}}
    )
    (list
      @list{@code{equal-now(v1, v2) is NotEqual}}
      @list{@code{NotEqual} only}
      @list{@code{NotEqual} only}
      "-"
      @;@list{@code{NotEqual} only}
    )
    (list "" "" "" "")
    (list
      @list{@code{identical(v1, v2) is Unknown}}
      "-"
      @;@list{@code{Unknown} only}
      @list{@code{Unknown} only}
      @list{@code{Unknown} only}
    )
    (list
      @list{@code{equal-always(v1, v2) is Unknown}}
      @list{@code{Unknown} or @code{NotEqual}}
      "-"
      @;@list{@code{Unknown} only}
      @list{@code{Unknown} only}
    )
    (list
      @list{@code{equal-now(v1, v2) is Unknown}}
      @list{@code{Unknown} or @code{NotEqual}}
      @list{@code{Unknown} or @code{NotEqual}}
      "-"
      @;@list{@code{Unknown} only}
    )
    )
]

There are corresponding total functions defined for @pyret-id{within} as well:

@function["within3" #:contract (a-arrow N A)]
@function["within-rel3" #:contract (a-arrow N A)]
@function["within-rel-now3" #:contract (a-arrow N A)]
@function["within-abs3" #:contract (a-arrow N A)]
@function["within-abs-now3" #:contract (a-arrow N A)]

@section[#:tag "s:datatype-defined-equality"]{Datatype-defined Equality}

The functions @pyret-id{equal-now} and @pyret-id{equal-always} are defined to
work over values created with @pyret{data} by comparing fields in the same
position.  However, sometimes user-defined values need a more sophisticated
notion of equality than this simple definition provides.

For consider implementing an unordered @emph{set} of values in Pyret.  We might
choose to implement it as a function that creates an object closing over the
implementation of the set itself:

@pyret-block{
fun make-empty-set<a>():
  {
    add(self, element :: a): ... end,
    member(self, element :: a) -> Boolean: ... end,
    equal-to-other-set(self, other) -> Boolean: ... end
  }
end
}

We could fill in the bodies of the methods to have this implementation let
clients create sets and add elements to them, but it won't work well with
testing:

@pyret-block{
check:
  s = make-empty-set().add(5)
  s2 = make-empty-set().add(5)

  s.member(5) is true
  s2.member(5) is true

  s.equal-to-other-set(s2) is true

  s == s2 raises "Attempted to compare functions"
end
}

The final test raises an exception because it traverses the structure of the
object, and the only visible values are the three methods, which cannot be
compared.  We might just say that users of custom datatypes have to use custom
predicates for testing, for example they could write:

@pyret-block{
check:
  # as before ...
  fun equal-sets(set1, set2): set1.equal-to-other-set(set2) end
  s is%(equal-sets) s2
end
}

This works for sets on their own, but the built-in testing and equality
operators will not work with nested user-defined data structures.  For example,
since lists are a dataype that checks built-in equality on their members, a
list of sets as defined above will not use the equal-to-other-set method when
comparing elements, and give an @pyret{"Attempted to compare functions"} error:

@pyret-block{
check:
  # as before ...
  ([list: s] == [list: s2]) raises "Attempted to compare functions"
end
}

To help make this use case more pleasant, Pyret picks a method name to call, if
it is present, on user-defined objects when checking equality.  The method name
is @pyret{_equals}, and it has the following signature:

@(render-fun-helper '(method-spec)
  "_equals"
  (list 'part (tag-name (curr-module-name) "_equals"))
  (a-arrow "a" "a" (a-arrow A A EQ) EQ)
  EQ
  (list (list "self" "") (list "other" "") (list "equal-rec" ""))
  '()
  '()
  '())

Where @pyret{a} is the type of the object itself (so for sets, @pyret{other}
would be annotated with @pyret{Set<a>}).

The @pyret{_equals} method is called in the equality algorithm when:

@itemlist[
  @item{The two values are either both data values or both objects, AND}
  @item{If they are data values, the two values are of the same data type and
        variant, AND}
  @item{If they are objects not created by data, they have the same set of
  @seclink["brands"]}
]

So, for example, an object with an @pyret{_equals} method that always returns
@pyret-id{Equal} is not considered equal to values that aren't also objects:

@pyret-block{
import Equal from equality
check:
  eq-all = { _equals(self, other, eq): Equal end }
  eq-all is-not== f
  eq-all is-not== m
  eq-all is-not== 0
  eq-all is-not== "a"
  eq-all is== {}
end
}

The last argument to @pyret{_equals} is the recursive equality callback to use
for checking equality of any members.  When checking for equality of members
(say in our set implementation above), we would use this callback rather than
one of @pyret-id{equal-always3} or @pyret-id{equal-now3}.  The reasons for this
are threefold:

@itemlist[
  @item{In order to check for equality of cyclic values, Pyret needs to do
  internal bookkeeping of visited references.  This information is stored
  within the callback, and calling e.g. @pyret-id{equal-now3} directly would not
  take previously visted references into account.}

  @item{To avoid requiring datatypes to implement two equality methods, the
  callback also knows whether this equality call was started by
  @pyret-id{equal-now} or by @pyret-id{equal-always}.  Any recursive calls
  should use the original semantics for comparing references, so using the
  callback ensures that equality checks on elements have the right semantics
  (even in deeply nested data structures).}

  @item{The recursive equality predicate closes over and remembers the
  @emph{tolerance} for @pyret-id["within"]-family functions, and whether or
  not the tolerance is absolute or relative.}
]


@section[#:tag "inequalities"]{Inequalities}

The inequality operators and functions in Pyret follow different rules than
those for equality.  In particular:

@itemlist[
  @item{There are no 3-valued forms for the inequality functions, because...}
  @item{All the inequalities (even non-strict inequality like @pyret-id{<=})
  are defined on @pyret-id["Roughnum" "numbers"]s.}
]

Comparing approximate numbers with inequalities is technically a bit fraught.
If @pyret{x < y} and @pyret{x} and @pyret{y} are both approximations, it may be
that the approximation error causes the comparison to return @pyret{true}
rather than @pyret{false}.  The same argument holds for the other inequality
operators.  However, the inequality operators can be a part of correct use of
approximations, for example by using a test like @pyret{x < (y + tolerance)},
(where @pyret{tolerance} could be usefully specified as either positive or
negative), in applications that closely track approximation error.  Since in
common cases inequality comparison of approximation is quite useful, and it is
quite onerous to program with an analog of @pyret-id{within} for inequalities
as well, Pyret chooses to allow the inequality operators to work on
approximations.

The inequality operators all work on either:

@itemlist[
@item{Pairs of numbers (whether exact or approximate)}
@item{Pairs of strings}
@item{Left-hand-side objects with an appropriately-named method (for example,
for the @pyret-id{<} operator, the object must have a @pyret{_lessthan}
method.)}
]

Numbers are compared in their standard mathematical order.  Strings are
compared lexicographically (examples below).  For objects with overloaded
methods, the method should return a @B and that return value is used as the
result.

@function["<=" #:contract (a-arrow A A B)]
@function["_lessequal" #:contract (a-arrow A A B)]
@function["<" #:contract (a-arrow A A B)]
@function["_lessthan" #:contract (a-arrow A A B)]
@function[">=" #:contract (a-arrow A A B)]
@function["_greaterequal" #:contract (a-arrow A A B)]
@function[">" #:contract (a-arrow A A B)]
@function["_greaterthan" #:contract (a-arrow A A B)]

@pyret-block{
check "strings":
  "a" < "b" is true
  "b" > "a" is true
  
  "a" < "a" is false
  "a" > "a" is false
  
  "a" <= "a" is true
  "a" >= "a" is true
  
  "A" < "a" is true
  "a" > "A" is true
  
  "a" < "A" is false
  "A" > "a" is false
  
  "a" < "aa" is true
  "a" > "aa" is false
  
  "a" < "baa" is true
  "a" > "baa" is false
  "abb" < "b" is true
  "abb" > "b" is false
  
  "ab" < "aa" is false
  "ab" > "aa" is true
  
  "aa" < "ab" is true
  "aa" > "ab" is false
end
}

@pyret-block{
check "numbers":
  ~5 < 5 is false
  ~5 > 5 is false
  
  ~5 <= 5 is true
  ~5 >= 5 is true
  
  ~5 < ~5 is false
  ~4.9 < ~5 is true
  
  
  ~5 <= ~5 is true
  ~5 >= ~5 is true
  
end
}

}

