#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt" scribble/html-properties)

@(define eq '(a-id "EqualityResult" (xref "equality" "EqualityResult")))
@(define eqfun `(a-arrow ,A ,A ,B))
@(define eq3fun `(a-arrow ,A ,A ,eq))

@(append-gen-docs
  `(module "numbers"
    (path "src/js/base/runtime-anf.js")
    (data-spec
      (name "Number")
      (variants)
      (shared))
    (data-spec
      (name "Exactnum")
      (variants)
      (shared))
    (data-spec
      (name "Roughnum")
      (variants)
      (shared))
    (data-spec
      (name "NumInteger")
      (variants)
      (shared))
    (data-spec
      (name "NumRational")
      (variants)
      (shared))
    (data-spec
      (name "NumPositive")
      (variants)
      (shared))
    (data-spec
      (name "NumNegative")
      (variants)
      (shared))
    (data-spec
      (name "NumNonPositive")
      (variants)
      (shared))
    (data-spec
      (name "NumNonNegative")
      (variants)
      (shared))
    (fun-spec
      (name "num-equal")
      (arity 2)
      (args ("n1" "n2"))
      (doc ""))
    (fun-spec
      (name "num-max")
      (arity 2)
      (args ("n1" "n2"))
      (doc ""))
    (fun-spec
      (name "num-min")
      (arity 2)
      (args ("n1" "n2"))
      (doc ""))
    (fun-spec
      (name "num-abs")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-sin")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-cos")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-tan")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-asin")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-acos")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-atan")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-atan2")
      (arity 2)
      (args ("dy" "dx"))
      (doc ""))
    (fun-spec
      (name "num-modulo")
      (arity 2)
      (args ("n" "divisor"))
      (doc ""))
    (fun-spec
      (name "num-truncate")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-sqrt")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-sqr")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-ceiling")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-floor")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-round")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-round-even")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-log")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-exp")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-expt")
      (arity 2)
      (args ("base" "exponent"))
      (doc ""))
    (fun-spec
      (name "num-to-rational")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-to-roughnum")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-is-integer")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-is-rational")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-is-roughnum")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-is-positive")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-is-negative")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-is-non-positive")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-is-non-negative")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-to-string")
      (arity 1)
      (args ("n"))
      (doc ""))
    (fun-spec
      (name "num-to-string-digits")
      (arity 2)
      (args ("n" "digits"))
      (doc ""))
    (fun-spec
      (name "num-within-abs")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
      (doc ""))
    (fun-spec
      (name "num-within-rel")
      (arity 1)
      (args ("tol"))
      (return ,eqfun)
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
    (name "num-random")
    (arity 1)
    (args ("max"))
    (doc ""))
  (fun-spec
    (name "num-random-seed")
    (arity 1)
    (args ("seed"))
    (doc ""))
  (fun-spec
    (name "num-is-fixnum")
    (arity 1)
    (args ("n"))
    (doc ""))
  (fun-spec
    (name "num-exact")
    (arity 1)
    (args ("n"))
    (doc ""))
    ))

@docmodule["numbers" #:noimport #t #:friendly-title "Numbers"]{

Pyret numbers are of two kinds: exact numbers, or @pyret{Exactnum}s, 
and rough numbers or @pyret{Roughnum}s. Both are 
real; finite; and written in base ten.

@margin-note{Note that imagaginary numbers were implemented in earlier versions of Pyret,
but are not currently supported.}

@pyret{Exactnum}s are arbitrarily precise rational numbers, including
integers and rational fractions.  For integers whose magnitude is less
than @pyret{(num-expt(2, 53) - 1)}, Pyret internally uses JavaScript
@tt{fixnum}s, in order to optimize basic arithmetic.

@pyret{Roughnum}s are numbers that are necessarily or
deliberately imprecise. These correspond to the same set of
values covered by JavaScript
@tt{fixnum}s (a.k.a. doubles), and thus cover a large but limited range
(magnitude less than @pyret{1.7976931348623157e308}).

Operations on @pyret{Exactnum}s typically return
@pyret{Exactnum}s. However, if the operation can yield irrationals, and it
is not possible to determine that a particular result is
definitely rational, that result is returned as a @pyret{Roughnum}. Thus,
trigonometric functions on @pyret{Exactnum}s typically yield @pyret{Roughnum}
answers, except for well-known edge cases such as the sine or
cosine of zero. Fractional powers of rationals are usually @pyret{Roughnum},
except for small roots where it can be ascertained that an exact
root is possible.

Operations that are non-casting and with at least one argument that is @pyret{Roughnum}
automatically coerce the result to be a @pyret{Roughnum}. This is known
as @pyret{Roughnum} contagion.

@pyret{Exactnum}s allow the usual comparison predicates. @pyret{Roughnum}s do
too, with the significant exception that trying to compare
@pyret{Roughnum}s for equality throws an error.  To write an
equality function that handles @pyret{Roughnum}s, use @pyret-id{within}, as
documented in @seclink["s:bounded-equalities"].

An operation whose numerical result is not determinate or finite
throws an error, with the message signaling either an
overflow or some more specific problem.

@section{Number Annotations}

Several specific type annotations are provided for numbers to allow more precise
value requirements to be specified.

@examples{
fun round-distance(d :: NumNonNegative) -> Exactnum:
  num-round(d)
end
}

@type-spec["Number" (list)]{
The type of number values.}
@type-spec["Exactnum" (list)]{
The type of exact number values.}
@type-spec["Roughnum" (list)]{
The type of necessarily or deliberately imprecise values.}
@type-spec["NumInteger" (list)]{
The type of @pyret{Exactnum} integer values.}
@type-spec["NumRational" (list)]{
The type of exact rational number values. Same as @pyret{Exactnum}.}
@type-spec["NumPositive" (list)]{
The type of number values that are greater than zero.}
@type-spec["NumNegative" (list)]{
The type of number values that are less than zero.}
@type-spec["NumNonPositive" (list)]{
The type of number values that are less than or equal to zero.}
@type-spec["NumNonNegative" (list)]{
The type of number values that are equal to or greater than zero.}

@section{Number Literals}

@pyret{Exactnum}s can be integers,  fractions represented
with a solidus, or decimals, with an optional exponent. In the following,
the numerals on the same line all denote the same Pyret number.

@examples{
42 +42
-42
22/7
-22/7
2.718281828 +2.718281828
-2.718281828
1/2 0.5
6.022e23 +6.022e23 6.022e+23 +6.022e+23
-6.022e23 -6.022e+23
-6.022e-23
}

@pyret{Exactnum}s are of arbitrary precision.

@pyret{Roughnum}s are represented with a leading tilde.  You can think of
the tilde as representing a person waving his or her hands vaguely.

They are integers, fractions or decimals, with an optional exponent.

@examples{
~42 ~+42
~-42
~2.718281828 ~+2.718281828
~-2.718281828
~6.022e23 ~+6.022e23 ~6.022e+23 ~+6.022e+23
~-6.022e23 ~-6.022e+23
~-6.022e-23
}

@pyret{Roughnum}s cannot be made arbitrarily precise. The absolute value
ranges between 0 and 1.7976931348623157e+308 (JavaScript’s Number.MAX_VALUE) with a
granularity of 5e-324 (JavaScript’s Number.MIN_VALUE).

@section{Number Functions}

@function["num-equal" #:contract (a-arrow N N B) #:return B]{
If both arguments are @pyret{Exactnum}s, returns a @pyret{Boolean}.
If either argument is @pyret{Roughnum}, raises an error.

@examples{
check:
  num-equal(2, 2) is true
  num-equal(2, 3) is false
  num-equal(1/2, 0.5) is true
  num-equal(1 / 2, 0.5) is true
  num-equal(1/3, 0.33) is false
  num-equal(1/3, ~0.33)
    raises "roughnums cannot be compared for equality"
end
}

  }
  @function["num-max" #:contract (a-arrow N N N) #:return N]{
Returns the greater of the two arguments.

@examples{
check:
  num-max(1, 2) is 2
  num-max(2, ~3) is-roughly ~3
  num-max(4, ~4) is 4
  num-max(~4, 4) is-roughly ~4
  num-max(-1.1, 0) is 0
end
}

  }
  @function["num-min" #:contract (a-arrow N N N) #:return N]{
Returns the lesser of the two arguments.

@examples{
check:
  num-min(1, 2) is 1
  num-min(2, ~3) is 2
  num-min(4, ~4) is 4
  num-min(~4, 4) is-roughly ~4
  num-min(-1.1, 0) is -1.1
end
}

  }
  @function["num-abs" #:contract (a-arrow N N) #:return N]{
Returns the absolute value of the argument. The result is an
  @pyret{Exactnum} only if the argument is.

@examples{
check:
  num-abs(2) is 2
  num-abs(-2.1) is 2.1
  num-abs(~2) is-roughly ~2
  num-abs(~-2.1) is-roughly ~2.1
end
}

  }
  @function["num-sin" #:contract (a-arrow N N) #:return N]{

Returns the sine of the argument, usually as a @pyret{Roughnum}.
  If the argument is @pyret{Exactnum} 0, the result is @pyret{Exactnum} 0 too.

@examples{
check:
  num-sin(0) is 0
  num-sin(1) is%(within-abs(0.01)) 0.84
end
}
  }
  @function["num-cos" #:contract (a-arrow N N) #:return N]{

Returns the cosine of the argument, usually  as a @pyret{Roughnum}. If
the argument is @pyret{Exactnum} 0, the result is @pyret{Exactnum} 1.

@examples{
check:
  num-cos(0) is 1
  num-cos(1) is%(within-abs(0.01)) 0.54
end
}
  }
  @function["num-tan" #:contract (a-arrow N N) #:return N]{
Returns the tangent of the argument, usually as a @pyret{Roughnum}. If
the argument is @pyret{Exactnum} 0, the result is @pyret{Exactnum} 1.

@examples{
check:
  num-tan(0) is 0
  num-tan(1) is%(within-abs(0.01)) 1.56
end
}

  }
  @function["num-asin" #:contract (a-arrow N N) #:return N]{
  
Returns the arcsine of the argument as an angle in radians in the range [-pi/2,
pi/2], usually as a @pyret{Roughnum}. If the argument is @pyret{Exactnum} 0, the
result is @pyret{Exactnum} 0.

@examples{
check:
  num-asin(0) is 0
  num-asin(0.84) is%(within-abs(0.01)) 1
end
}

  }
  @function["num-acos" #:contract (a-arrow N N) #:return N]{

Returns the arccosine of the argument as an angle in radians in the range [0,
pi], usually as a @pyret{Roughnum}. However, if the argument is
@pyret{Exactnum} 1, the result is @pyret{Exactnum} 0.

@examples{
check:
  num-acos(1) is 0
  num-acos(0.54) is%(within-abs(0.01)) 1
end
}
  }
  @function["num-atan" #:contract (a-arrow N N) #:return N]{

Returns the arctangent of the argument as an angle in radians in the range
(-pi/2, pi/2), usually as a @pyret{Roughnum}. However, if the argument is
@pyret{Exactnum} 0, the result is @pyret{Exactnum} 0.

@examples{
check:
  num-atan(0) is 0
  num-atan(1) is-roughly (3.141592 * 1/4) # 45 degrees = pi/4 radians
  num-atan(-1) is-roughly (-3.141592 * 1/4) # 315 degrees = -pi/4 radians
  num-atan(100000000000) is-roughly (3.141592 / 2) # 90 degrees = pi/2 radians
  num-atan(-100000000000) is-roughly (-3.141592 / 2) # 270 degrees = -pi/2 radians
end
}
  }

  @function["num-atan2" #:contract (a-arrow N N N) #:return N]{

The @pyret{num-atan} function takes a tangent value and returns @emph{a}
corresponding angle, but it is not clear which angle to return: for example,
both @pyret{num-tan(3.141592 * 1/4)} and @pyret{num-tan(3.141592 * 5/4)} have a
tangent of @pyret{~1}.  The @pyret{num-atan2} function produces an angle in
radians in the range [0, 2pi], where the tangent value is the @emph{ratio} of
the two arguments: the two arguments represent the (signed)
@emph{height} and @emph{width} of a triangle whose angle is unknown (i.e.,
their ratio is the "rise over run", defining the tangent of that angle).  The
return value of @pyret{num-atan2} chooses which angle to return based on the
following table:

@tabular[
  #:column-properties (list (list (attributes '((style . "padding: 5px;")))))
(list
  (list "If..."         @pyret{dx < 0} @pyret{dx > 0})
  (list @pyret{dy > 0}  "Quadrant II"   "Quadrant I")
  (list @pyret{dy < 0}  "Quadrant III"  "Quadrant IV"))
  ]

@examples{
check:
  num-atan2(0, 1) is 0
  num-atan2(1, 1) is-roughly (3.141592 * 1/4) # 45 degrees
  num-atan2(1, -1) is-roughly (3.141592 * 3/4) # 135 degrees 
  num-atan2(-1, -1) is-roughly (3.141592 * 5/4) # 225 degrees
  num-atan2(-1, 1) is-roughly (3.141592 * 7/4) # 315 degrees
  num-atan2(1, 0) is-roughly (3.141592 * 1/2) # 90 degrees
  num-atan2(-1, 0) is-roughly (3.141592 * 3/2) # 270 degrees
end
}
  }

  @function["num-modulo" #:contract (a-arrow N N N) #:return N]{
Returns the modulus of the first argument with respect to the
second, i.e. the remainder when dividing the first number by the second.

@examples{
check:
  num-modulo(5, 2) is 1
  num-modulo(-5, 2) is 1
  num-modulo(-5, -2) is -1
  num-modulo(7, 3) is 1
  num-modulo(0, 5) is 0
  num-modulo(-7, 3) is 2
end
}

It is useful for calculating if one number is a multiple of
another, by checking for a zero remainder.

@examples{
fun is-even(n :: Number) -> Boolean:
  num-modulo(n, 2) == 0
where:
  is-even(6) is true
  is-even(3) is false
end
}

  }
  @function["num-truncate" #:contract (a-arrow N N) #:return N]{

Returns the integer part of its argument by cutting off any
decimal part. Does not do any rounding.

@examples{
check:
  num-truncate(3.14) is 3
  num-truncate(-3.14) is -3
  num-truncate(~3.14) is-roughly ~3
  num-truncate(~-3.14) is-roughly ~-3
end
}

  }
  @function["num-sqrt" #:contract (a-arrow N N) #:return N]{

Returns the square root of the given argument.  If the argument is an @pyret{Exactnum} and a perfect
square, the result is an @pyret{Exactnum}, otherwise, it is a @pyret{Roughnum}.

@examples{
check:
  num-sqrt(4) is 2
  num-sqrt(5) is%(within-abs(0.001)) ~2.236
  num-sqrt(~4) is%(within-abs(0.001)) ~2
  num-sqrt(~5) is%(within-abs(0.001)) ~2.236
  num-sqrt(0.04) is 1/5
  num-sqrt(-1) raises "negative argument"
end
}
  }
  @function["num-sqr" #:contract (a-arrow N N) #:return N]{

Returns the square of the given argument.

@examples{
check:
  num-sqr(4) is 16
  num-sqr(5) is 25
  num-sqr(-4) is 16
  num-sqr(~4) is-roughly ~16
  num-sqr(0.04) is 1/625
end
}

  }
  @function["num-ceiling" #:contract (a-arrow N EN) #:return EN]{

Returns the smallest integer @pyret{Exactnum} greater than or equal to the
argument.

@examples{
check:
  num-ceiling(4.2) is 5
  num-ceiling(-4.2) is -4
end
}

  }
  @function["num-floor" #:contract (a-arrow N EN) #:return EN]{

Returns the largest integer @pyret{Exactnum} less than or equal to the argument.

@examples{
check:
  num-floor(4.2) is 4
  num-floor(-4.2) is -5
end
}
  }
  @function["num-round" #:contract (a-arrow N EN) #:return EN]{

Returns the closest integer @pyret{Exactnum} to the argument. 

@examples{
check:
  num-round(4.2) is 4
  num-round(4.8) is 5
  num-round(-4.2) is -4
  num-round(-4.8) is -5
end
}

If the argument is midway between integers, returns the integer further
away from zero.

@examples{
check:
  num-round(3.5) is 4
  num-round(2.5) is 3
end
}

  }
  @function["num-round-even" #:contract (a-arrow N EN) #:return EN]{

Similar to @pyret{num-round}, except that if the argument is
midway between integers, returns the even integer @pyret{Exactnum}.

@examples{
check:
  num-round-even(3.5) is 4
  num-round-even(2.5) is 2
end
}

  }  @function["num-log" #:contract (a-arrow N N) #:return N]{

Returns the natural logarithm (ln) of the argument, usually as a @pyret{Roughnum}.
If the argument is @pyret{Exactnum} 1, the
result is @pyret{Exactnum} 0. If the argument is non-positive, an error is
thrown.

@examples{
check:
  num-log(1) is 0
  num-log(0) raises "non-positive argument"
  num-log(-1) raises "non-positive argument"
  num-log(2.718281828) is%(within-abs(0.01)) 1
  num-log(10) is%(within-abs(0.1)) 2.3
end
}

  }
  @function["num-exp" #:contract (a-arrow N N) #:return N]{

Returns e raised to the argument, usually as a @pyret{Roughnum}.  However, if the
argument is @pyret{Exactnum} 0, the result is
@pyret{Exactnum} 1.

@examples{
check:
  num-exp(-1) is%(within-abs(0.0001)) (1 / num-exp(1))
  num-exp(0) is 1
  num-exp(1) is%(within-abs(0.0001)) 2.718281828
  num-exp(3) is%(within-abs(0.0001)) num-expt(2.718281828, 3)
  num-exp(710) raises "exp: argument too large: 710"
end
}

  }
  @function["num-expt" #:contract (a-arrow N N N) #:return N]{

Returns the first argument raised to the second argument.  An error
is thrown if the first argument is 0 and the second is negative.
If the first argument is @pyret{Exactnum} 0 or 1,
or the second argument is @pyret{Exactnum} 0, then the result is an
@pyret{Exactnum} even if the other argument is a @pyret{Roughnum}.

@examples{
check:
  num-expt(3, 0) is 1
  num-expt(1, 3) is 1
  num-expt(0, 0) is 1
  num-expt(0, 3) is 0
  num-expt(0, -3) raises "division by zero"
  num-expt(2, 3) is 8
  num-expt(2, -3) is 1/8
end
}

  }


  @function["num-to-roughnum" #:contract (a-arrow N RN) #:return RN]{

Given a number, returns the @pyret{Roughnum} version.

@examples{
check:
  num-is-roughnum(num-to-roughnum(3.14)) is true
  num-is-roughnum(num-to-roughnum(~3.14)) is true
end
}
  }
  @function["num-is-integer" #:contract (a-arrow N B) #:return B]{
Returns @pyret{true} if argument is an @pyret{Exactnum} integer.

@examples{
check:
  num-is-integer(2) is true
  num-is-integer(1/2) is false
  num-is-integer(1.609) is false
  num-is-integer(~2) is false
end
}

  }
  @function["num-is-rational" #:contract (a-arrow N B) #:return B]{

Returns @pyret{true} if argument is an @pyret{Exactnum} rational.

@examples{
check:
  num-is-rational(2) is true
  num-is-rational(1/2) is true
  num-is-rational(1.609) is true
  num-is-rational(~2) is false
end
}

  }
  @function["num-is-roughnum" #:contract (a-arrow N B) #:return B]{
Returns @pyret{true} if argument is a @pyret{Roughnum}.
@examples{
check:
  num-is-roughnum(2) is false
  num-is-roughnum(1/2) is false
  num-is-roughnum(1.609) is false
  num-is-roughnum(~2) is true
end
}

  }
  @function["num-is-positive" #:contract (a-arrow N B) #:return B]{

Returns @pyret{true} if argument is greater than zero.

@examples{
check:
  num-is-positive(~-2) is false
  num-is-positive(-2) is false
  num-is-positive(0) is false
  num-is-positive(-0) is false
  num-is-positive(2) is true
  num-is-positive(~2) is true
end
}
  }
  @function["num-is-negative" #:contract (a-arrow N B) #:return B]{

Returns @pyret{true} if argument is less than zero.

@examples{
check:
  num-is-negative(~-2) is true
  num-is-negative(-2) is true
  num-is-negative(0) is false
  num-is-negative(-0) is false
  num-is-negative(2) is false
  num-is-negative(~2) is false
end
}

  }
  @function["num-is-non-positive" #:contract (a-arrow N B) #:return B]{

Returns @pyret{true} if argument is less than or equal to zero.
@examples{
check:
  num-is-non-positive(~-2) is true
  num-is-non-positive(-2) is true
  num-is-non-positive(0) is true
  num-is-non-positive(-0) is true
  num-is-non-positive(2) is false
  num-is-non-positive(~2) is false
end
}

  }
  @function["num-is-non-negative" #:contract (a-arrow N B) #:return B]{

Returns @pyret{true} if argument is greater than or equal to zero.

@examples{
check:
  num-is-non-negative(~-2) is false
  num-is-non-negative(-2) is false
  num-is-non-negative(0) is true
  num-is-non-negative(-0) is true
  num-is-non-negative(2) is true
  num-is-non-negative(~2) is true
end
}
  }
  @function["num-to-string" #:contract (a-arrow N S) #:return S]{
Returns a @pyret{String} representing a literal form of the number.

@examples{
check:
  num-to-string(2.5) is "5/2"
  num-to-string(2) is "2"
  num-to-string(2/3) is "2/3"
  num-to-string(~2.718) is "~2.718"
  num-to-string(~6.022e23) is "~6.022e+23"
end
}
  }
  @function["num-to-string-digits" #:contract (a-arrow N N S) #:return S]{

Converts the number to a @pyret{String}, providing @pyret{digits} precision in the
output.  If @pyret{digits} is positive, provides that many digits to the right
of the decimal point (including adding zeroes beyond the actual precision of
the number).  If @pyret{digits} is negative, rounds that many positions to the
@emph{left} of the decimal, replacing them with zeroes.

Note that @pyret-id{num-to-string-digits} is only for formatting, and its
output's apparent precision may be unrelated to the actual precision of the
input number, which may have been an approximation, or unrepresentable in
decimal.

@examples{
check:
  num-to-string-digits(2/3, 3) is "0.667"
  num-to-string-digits(-2/3, 3) is "-0.667"
  num-to-string-digits(5, 2) is "5.00"
  num-to-string-digits(5, 0) is "5"
  num-to-string-digits(555, -2) is "600"
end
}
  }
  @function["num-within-abs" #:contract (a-arrow N eqfun)]{

Returns a predicate that checks if the difference of its two
arguments is less than @pyret{tol}.

@examples{
check:
   1  is%(num-within-abs(0.1))       1
   1  is%(num-within-abs(0.1))      ~1
  ~3  is%(num-within-abs(0.1))      ~3
  ~2  is-not%(num-within-abs(0.1))  ~3
  ~2  is%(num-within-abs(1.1))      ~3
  ~2  is%(num-within-abs(~1))       ~3
   2  is%(num-within-abs(1))        ~3
   5  is%(num-within-abs(4))         3

   num-within-abs(-0.1)(1, 1.05) raises "negative tolerance"
end
}

  }
  @function["num-within-rel" #:contract (a-arrow N eqfun)]{

Returns a predicate that checks that its first number argument
is no more than the fraction @pyret{tol} off from its second
argument.

This function is a.k.a. @pyret{num-within}.

@examples{
check:
  100000 is%(num-within-rel(0.1)) 95000
  100000 is-not%(num-within-rel(0.1)) 85000
end
}
  }

  @function["within" #:contract (a-arrow N eqfun)]
  @function["within-abs" #:contract (a-arrow N eqfun)]
  @function["within-rel" #:contract (a-arrow N eqfun)]
  @function["within-abs-now" #:contract (a-arrow N eqfun)]
  @function["within-rel-now" #:contract (a-arrow N eqfun)]

  These comparison functions compare both numbers and structures, and are
  documented in @seclink["s:bounded-equalities"].

  @function["within-abs3" #:contract (a-arrow N eq3fun)]
  @function["within-rel3" #:contract (a-arrow N eq3fun)]
  @function["within-abs-now3" #:contract (a-arrow N eq3fun)]
  @function["within-rel-now3" #:contract (a-arrow N eq3fun)]

  These comparison functions are like the ones above, but return
  @pyret-id["EqualityResult" "equality"]s, and are documented in @seclink["s:total-equality-predicates"].

@section{Random Numbers}

  @function["num-random" #:contract (a-arrow N N) #:return N]{

  Returns a pseudo-random positive integer from @pyret{0} to @pyret{max - 1}.

@examples{
check:
  fun between(min, max):
    lam(v): (v >= min) and (v <= max) end
  end
  for each(i from range(0, 100)):
    block:
      n = num-random(10)
      print(n)
      n satisfies between(0, 10 - 1)
    end
  end
end
}

  }
  @function["num-random-seed" #:contract (a-arrow N No) #:return No]{

  Sets the random seed.  Setting the seed to a particular number makes all
  future uses of random produce the same sequence of numbers.  Useful for
  testing and debugging functions that have random behavior.

  @examples{
check:
  num-random-seed(0)
  n = num-random(1000)
  n2 = num-random(1000)

  n is-not n2

  num-random-seed(0)
  n3 = num-random(1000)
  n3 is n
  n4 = num-random(1000)
  n4 is n2
end
}
  }

The random seed is set globally.  If it is set in tests in a game or another
program that should not run the same way every time, add an identifier you can
set as a flag indicating if you are running the code in testing or production.

@examples{

IS-TESTING = true  # change as needed

when IS-TESTING:
  num-random-seed(...)
end
}
  
@section{Other Number Functions}

  A few other number functions are useful in limited cases that don't come up
  in most programs.

  @function["num-is-fixnum" #:contract (a-arrow N B) #:return B]{

Returns @pyret{true} if the argument is represented directly as a
primitive
JavaScript number (i.e., JavaScript double).

@examples{
check:
  num-is-fixnum(10) is true
  num-is-fixnum(~10) is false
  num-is-fixnum(1000000000000000) is true
  num-is-fixnum(10000000000000000) is false
  num-is-fixnum(1.5) is false
end
}

@margin-note{Pyret represents @pyret{Exactnums} that are non-integers as tuples, 
and hence even small rationals such as 1.5 are considered non-@tt{fixnum},
although they could be represented as JavaScript doubles.}

  }
  @function["num-exact" #:contract (a-arrow N EN) #:return EN]
  @function["num-to-rational" #:contract (a-arrow N EN) #:return EN]


Given a @pyret{Roughnum}, returns an @pyret{Exactnum} number most equal to it. Given
an @pyret{Exactnum} num, returns it directly.

@margin-note{It is not good practice to indiscriminately convert
 @pyret{Roughnum}s to @pyret{Exactnum}s to make comparison easier.
 Use @pyret{within()} or @pyret{is-roughly}.}

@examples{
check:
  num-sqrt(2) is%(within-abs(0.000001)) ~1.4142135623730951
  num-exact(num-sqrt(2)) is 1.4142135623730951
  num-to-rational(num-sqrt(2)) is 1.4142135623730951
end
}

  }

