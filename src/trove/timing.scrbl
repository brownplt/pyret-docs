#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt" scriblib/footnote (only-in scribble/manual link))

@(append-gen-docs
  '(module "timing"
    (path "src/arr/trove/timing.arr")
    (fun-spec
      (name "time-only")
      (arity 1))
    (fun-spec
      (name "time-value")
      (arity 1))
    (fun-spec
      (name "time-now")
      (arity 0))))

@(define (T-of typ) (a-arrow (list) typ))

@docmodule["timing" #:friendly-title "Timing"]{

@section{Background and Caveat}

This library gives you the ability to determine how long a computation takes.

Please note that measuring the time of a computation can be very
complicated. Naturally, the same computation may take very different
amounts of time on different machines. However, it may also take very
different amounts of time on the same machine, depending on what else
is running. It may take very different amounts of time @emph{even if}
nothing else is running (are you sure?), because of cache effects, JIT
effects, and so on.

Therefore, you should either:
@itemlist[

@item{only use this library in an advisory way, not treat its answers as being too precise; and/or}

@item{perform timing many times and use appropriate statistical
methods to get a better sense of the true running time}

]
Nevertheless, this library can be very useful for rough approximation
and for telling apart coarse differences in running time.

@section{Design and Rationale}

The timing functions all take @emph{thunks}, i.e., procedures of no
argument, to represent the computation that needs to be timed.

It is important to understand why this is. Suppose we want to know how
long it takes to run some computation, @pyret{f(x)}. Pretend we had a
function called @pyret{time-of} and could just call
@pyret{time-of(f(x))}. We might expect this to determine how long it
takes for @pyret{f(x)} to run.

Unfortunately, that is not how functions work in Pyret (or indeed in most
programming languages: see the
@hyperlink["https://smol-tutor.xyz/"]{Standard Model of Languages}).
Instead, Pyret first turns @pyret{f(x)} into a value (if it has one),
and it is this @emph{value} that is supplied to
@pyret{time-of(…)}. Therefore, @pyret{time-of} already receives a
value, which takes effectively no time to compute; so no matter how
long @pyret{f(x)} took, @pyret{time-of(f(x))} will return essentially
the same answer, which will effectively be @pyret{0}.

In contrast, a thunk reflects the @emph{computation} rather than its
answer. When this thunk is passed to a timing function, the
computation has not yet occurred. Instead, the timing function can
call it in an appropriate way, and can thus measure how long it ran.

All the functions rely on the underlying system timers, which use
@hyperlink["https://en.wikipedia.org/wiki/Unix_time"]{Unix epoch}
time. There are many online converters that will translate the
resulting value into something human-readable.

@section[#:tag "timing-functions"]{Functions}

This library provides three functions. @pyret{time-now} is a low-level
primitive useful for building the other two. Most of the time you
would not use it directly, but we provide it in case you need
fine-grained control that doesn't easily fit the other two.

The other two functions determine how long a given thunk takes to run
by running it. They differ in what they produce as a result. One only
produces the @emph{time} that it takes (not to be confused with the
value produced by the thunk, which may also be a number, and even a
positive integer that is similar to the returned time); the other
produces both the duration and the value produced by the computation.

  @function["time-only"
    #:contract (a-arrow (T-of "T") N)
    #:args '(("f" #f))
    #:return N
  ]{

Consumes a thunk, runs it, and produces how long it takes to run (in
milliseconds).
  
@examples[#:show-try-it #t]{
include timing

check:
  produce-0-to-9 = {(): range(0, 10)}
  fun takes-less-than-1-second(t): t < 1000 end
  # NOTE: may fail on a sufficiently slooooow machine!
  time-only(produce-0-to-9) satisfies takes-less-than-1-second
end
}
}

  @function["time-value"
    #:contract (a-arrow (T-of "T") (a-tuple N "T"))
    #:args '(("f" #f))
    #:return (a-tuple N "T")
  ]{

Consumes a thunk, runs it, and produces both how
long it takes to run (in milliseconds) and the value that it produces.
  
@examples[#:show-try-it #t]{
include timing

check:
  produce-0-to-9 = {(): range(0, 10)}
  fun takes-less-than-1-second(t): t < 1000 end
  {t; v} = time-value(produce-0-to-9)
  t satisfies takes-less-than-1-second
  # NOTE: may fail on a sufficiently slooooow machine!
  v is [list: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
end
}
}

  @function["time-now"
    #:contract (a-arrow N)
    #:args '()
    #:return N
  ]{

Returns the current time, in milliseconds since the start of the
@hyperlink["https://en.wikipedia.org/wiki/Unix_time"]{Unix epoch}.
Since this value changes every millisecond, it is very difficult to
write a test where it succeeds; it's much easier to write a test that
it fails.
  
@examples[#:show-try-it #t]{
include timing

check:
  time-now() is-not 1740426758012
end
}

We can therefore reconstruct, for instance, @pyret{time-only} as follows:
@examples{
fun my-time-only(thunk):
  start-time = time-now()
  _ = thunk()
  end-time = time-now()
  end-time - start-time
end
}

}

}
