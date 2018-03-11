#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(append-gen-docs
'(module
  "reactors"
  (path "src/arr/trove/reactors.arr")
  (data-spec
    (name "Event")
    (type-vars ())
    (variants ("time-tick") ("mouse") ("keypress")
    (shared ())))
  (data-spec
    (name "Reactor")
    (type-vars ("a"))
    (variants ("reactor"))
    (shared ()))
  (constr-spec (name "time-tick"))
  (constr-spec (name "mouse"))
  (constr-spec (name "keypress"))

  (fun-spec (name "get-value"))
  (fun-spec (name "draw"))
  (fun-spec (name "interact"))
  (fun-spec (name "interact-trace"))
  (fun-spec (name "simulate-trace"))
  (fun-spec (name "start-trace"))
  (fun-spec (name "stop-trace"))
  (fun-spec (name "get-trace"))
  (fun-spec (name "get-trace-as-table"))
  (fun-spec (name "react"))
  (fun-spec (name "is-stopped"))))



@(define (R-of typ) (a-app (a-id "Reactor" (xref "reactors" "Reactor")) typ))
@(define Image (a-id "Image" (xref "image" "Image")))
@(define Event (a-id "Event" (xref "reactors" "Event")))

@(define key-args (list `("key"   ("type" "normal") ("contract" ,S))))
@(define mouse-args (list
  `("x" ("type" "normal") ("contract" ,N))
  `("y" ("type" "normal") ("contract" ,N))
  `("kind" ("type" "normal") ("contract" ,S))
  ))


@docmodule["reactors"]{

Pyret's @secref["world"] and @secref["reactors"] modules both facilitate
creating animated time-based simulation and interactive programs.
Using the @pyret{world} module and the @pyret{big-bang} function is
the quickest way to get a basic simulation or game running.  @pyret{reactors}
provide more advanced features for exploring, testing and debugging
reactive programs.

Handler functions written for @pyret{big-bang} are compatible with
@pyret{reactors}, so it is easy to start with @pyret{big-bang} and
move to @pyret{reactors} if you need their advanced features.
                       
  @margin-note{The world/reactor model is based on the universe teachpack in HtDP. You
  can find documentation for the teachpack here:

  @url["http://docs.racket-lang.org/teachpack/2htdpuniverse.html"]}

                       
@section[#:tag "s:reactors"]{Creating Reactors}

@type-spec["Reactor" (list "a")]{Reactors are values enabling the creation of time-based animations, simulations, and interactive programs.}

@pyret{reactor}s are created with special syntax:

@verbatim{
reactor:
  init: @py-prod["expr"],
  
  on-tick: @py-prod["expr"],
  seconds-per-tick: @py-prod["expr"]

  on-mouse: @py-prod["expr"],
  on-key: @py-prod["expr"],

  to-draw: @py-prod["expr"],

  stop-when: @py-prod["expr"],
  close-when-stop: @py-prod["expr"],

  title: @py-prod["expr"]
end
}

Syntactically, all of the components of a @pyret{reactor} are optional, with the
exception of @pyret{init:}.  They can also appear in any order --- the order
displayed above is not required.  Each option can only appear once.  So, for
example, these are valid reactors:

@pyret-block[#:style "good-ex"]{
reactor:
  init: "inert"
end
}

@pyret-block[#:style "good-ex"]{
fun increment(x): x + 1 end

reactor:
  on-tick: increment,
  init: 10,
end
}

@pyret-block[#:style "good-ex"]{
fun tencrement(x): x + 10 end

reactor:
  seconds-per-tick: 0.1,
  title: "Count by 10",
  on-tick: tencrement,
  init: 10,
end
}

These are not allowed:

@pyret-block[#:style "bad-ex"]{
reactor:
  init: 10,
  init: 11,
end
}

@pyret-block[#:style "bad-ex"]{
reactor:
  title: "No init",
  seconds-per-tick: 0.1,
end
}

@pyret-block[#:style "bad-ex"]{
reactor:
  init: 10,
  not-a-handler: "not allowed"
end
}

@section{Configuring and Running a Reactor}

@function["interact"
  #:contract (a-arrow (R-of "a") (R-of "a"))
  #:args '(("r" #f))
  #:return (R-of "a")
]{

While there are a number of useful operations on a reactor, the most central is
interacting with one.  The @pyret-id{interact} function takes a reactor as an
argument starts an interactive event loop as described by the reactor's
configuration.  In @url{https://code.pyret.org}, for a very simple reactor with
just an initial value, the reactor's display looks like:

@(image "src/builtin/inert-reactor.png")

Any value can be used for @pyret{init}, and that value will be shown by default
by @pyret-id{interact}.

Each of the options below adds or configures some interactive option in the
reactor.

}

@subsection{@pyret{init}}

Specifies the initial value for the reactor.  This is the beginning state of
the values that change throughout the simulation or game.


@subsection{@pyret{on-tick}}

The @pyret{on-tick} option expects to be given a function of one argument.  The
argument should be of the same type as the value given to @pyret{init}, and the
function should return the same type.  So for a @(R-of "a"), the type of the
on-tick handler is:

@tt{
on-tick :: @(a-arrow "a" "a")
}

This function is called every time the reactor's clock ticks, which happens by
default 28 times per second, this can be configured with
@secref["s:seconds-per-tick"].  The value returned by the function becomes the
new value of the reactor.

@(image "src/builtin/on-tick.gif")

@subsection[#:tag "s:seconds-per-tick"]{@pyret{seconds-per-tick}}

The @pyret{seconds-per-tick} option expects to be given a @|N|.

@tt{
seconds-per-tick :: @N
}

If it is provided, the delay between two successive calls to the
@pyret{on-tick} handler is equal to the provided number in seconds (up to the
granularity of tick events on the underlying machine).  If not provided, the
default delay is 1/28 seconds.




@subsection{@pyret{to-draw}}

The @pyret{to-draw} option expects to be given a function of one argument.  The
argument should be of the same type as the value given to @pyret{init}, and the
function should return a @pyret-id["Image" "image"].  So for a @(R-of "a"), the
type of the to-draw handler is:

@(image "src/builtin/to-draw.gif")

@tt{
to-draw :: @(a-arrow "a" Image)
}

This function is called each time the reactor's value changes, and is displayed
instead of the reactor's value.





@subsection{@pyret{on-key}}

The @pyret{on-key} handler expects to be given a function of two arguments,
which describe the current reactor state and a key event:

@tt{
on-key :: @(a-arrow "a" S "a")
}

The string describes a single keypress.  Most keys map directly to
single-character strings (striking the A key produces @pyret{"a"}, for
instance).  A number of special keys are encoded as longer words for ease of
use:

@itemlist[

@item{Backspace key: @pyret{"backspace"}}
@item{Tab key: @pyret{"tab"}}
@item{Enter key: @pyret{"enter"}}
@item{Shift key: @pyret{"shift"}}
@item{Control key: @pyret{"control"}}
@item{Pause key: @pyret{"pause"}}
@item{Escape key: @pyret{"escape"}}
@item{Prior key: @pyret{"prior"}}
@item{Next key: @pyret{"next"}}
@item{End key: @pyret{"end"}}
@item{Home key: @pyret{"home"}}
@item{Left arrow: @pyret{"left"}}
@item{Up arrow: @pyret{"up"}}
@item{Right arrow: @pyret{"right"}}
@item{Down arrow: @pyret{"down"}}
@item{Print key: @pyret{"print"}}
@item{Insert key: @pyret{"insert"}}
@item{Delete key: @pyret{"delete"}}
@item{Backspace key: @pyret{"backspace"}}
@item{Num lock key: @pyret{"numlock"}}
@item{Scroll key: @pyret{"scroll"}}

]

@subsection{@pyret{on-mouse}}

The @pyret{on-mouse} handler expects to be given a function of four arguments,
which describe the current reactor state and a mouse event:

@tt{
on-mouse :: @(a-arrow "a" N N S "a")
}

The two numbers indicate the x and y coordinates of the mouse, and the string
indicates the type of mouse event, which is one of:

@itemlist[(item (pyret "\"button-down\"") 
                " signals that the computer user has pushed a mouse button down;")
          (item (pyret "\"button-up\"") 
                " signals that the computer user has let go of a mouse button;")
          (item (pyret "\"drag\"") 
                " signals that the computer user is dragging the mouse. A dragging event occurs when the mouse moves while a mouse button is pressed.")
          (item (pyret "\"move\"") 
                " signals that the computer user has moved the mouse;")
          (item (pyret "\"enter\"") 
                " signals that the computer user has moved the mouse into the canvas area; and")
          (item (pyret "\"leave\"") 
                " signals that the computer user has moved the mouse out of the canvas area.")]


@subsection[#:tag "s:stop-when"]{@pyret{stop-when}}

The @pyret{stop-when} handler expects to be given a function of one argument.
The argument is the reactor state, and it should return a @|B|:

@tt{
stop-when :: @(a-arrow "a" B)
}

This function is called each time the reactor changes its state.  If it returns
@pyret{true}, then the reactor stays in that state and no longer responds to
stimuli like clock ticks, key presses, or mouse events.  If
@secref["s:close-when-stop"] is @pyret{true}, the
window closes immediately and evaluation continues.

@subsection[#:tag "s:close-when-stop"]{@pyret{close-when-stop}}

The @pyret{close-when-stop} option expects to be given a @|B|.

@tt{
close-when-stop :: @B
}


If it is @pyret{false} or not provided, the window stays open when
@pyret{stop-when} is triggered, showing the last drawn frame.  If it is
@pyret{true}, the window is immediately closed.


@subsection[#:tag "s:title"]{@pyret{title}}

The @pyret{title} option expects to be given a @|S|.

@tt{
title :: @S
}

The string is used instead of "reactor" in the title bar of the interaction
window.

@section[#:tag "s:manual-events"]{Reacting to Events Manually}

Several functions are provided to programmatically trigger the various handlers
of a reactor.  This can be used to simulate an interaction for testing or
exploration.

@function["get-value"
  #:contract (a-arrow (R-of "a") "a")
  #:args '(("r" #f))
  #:return "a"]{

  Given a reactor, returns the current value of its state.

@examples{
include reactors

r = reactor:
  init: 0,
end

check:
  get-value(r) is 0
end
}

}

@function["react"
  #:contract (a-arrow (R-of "a") Event (R-of "a"))
  #:args '(("r" #f) ("event" #f))
  #:return (R-of "a")]{

  Given a reactor and a single @pyret-id["Event"], produce a new reactor that
  results from calling the appropriate handler.  Note that it does not change
  the state of the input reactor; a @emph{new} reactor is created.

@examples{
include reactors

fun increment(x): x + 1 end

r = reactor:
  init: 0,
  on-tick: increment,
end

check:
  get-value(r) is 0
  r2 = react(r, time-tick)
  get-value(r2) is 1
  get-value(r) is 0
end
}


  }

@function["draw"
  #:contract (a-arrow (R-of "a") Image)
  #:args '(("r" #f))
  #:return Image]{

  Produces the result of calling the @tt{to-draw} handler on the given reactor
  with its current state.

  }

@function["is-stopped"
  #:contract (a-arrow (R-of "a") B)
  #:args '(("r" #f))
  #:return B]{

  Produces the result of calling the @tt{stop-when} handler on the given
  reactor with its current state.

  }

@data-spec2["Event" (list) (list
  @singleton-spec2["Event" "time-tick"]
  @constructor-spec["Event" "keypress" key-args]
  @constructor-spec["Event" "mouse" mouse-args]
)]

@nested[#:style 'inset]{
  @singleton-doc["Event" "time-tick" Event]{
    Represents a single tick of the clock
  }
  @constructor-doc["Event" "keypress" key-args Event]{
    Represents a key press of the given key.
  }
  @constructor-doc["Event" "mouse" mouse-args Event]{
    Represents a mouse event at the given location of the given kind.
  }
}

@section{Tracing}

Several functions control @emph{tracing} the evaluation of a reactor to provide
the history of states as data.

@function["interact-trace"
  #:contract (a-arrow (R-of "a") TA)
  #:args '(("r" #f))
  #:return TA]{

  Evaluates the same as @pyret-id{interact}, but instead of returning the final
  reactor, return a @TA of two columns, @pyret{tick} and @pyret{state}.  The
  @pyret{state} column holds the values of all the states that the reactor held
  during the interaction, and the @pyret{tick} column numbers them.

  This is equivalent to @pyret{get-trace-as-table(interact(start(r)))}.

  }


@function["simulate-trace"
  #:contract (a-arrow (R-of "a") N TA)
  #:args '(("r" #f) ("limit" #f))
  #:return TA]{

  Similar to @pyret-id{interact-trace}, but instead of opening an interaction
  window, simply supplies tick events to the reactor until either the
  @secref["s:stop-when"] condition becomes true, or @pyret{limit} ticks have
  been processed.  Useful for driving simulations without waiting for delayed
  tick intervals. 

  }

@function["start-trace"
  #:contract (a-arrow (R-of "a") (R-of "a"))
  #:args '(("r" #f))
  #:return (R-of "a")]{

Returns a new reactor that is just like the input reactor, but has tracing
enabled.  This means on each interaction, or call to @pyret-id{react}, the
current state will be saved to a list in the reactor, for later extraction with
@pyret-id{get-trace} or @pyret-id{get-trace-as-table}.

  }

@function["stop-trace"
  #:contract (a-arrow (R-of "a") (R-of "a"))
  #:args '(("r" #f))
  #:return (R-of "a")]{

Returns a new reactor with tracing disabled.  This is useful for toggling a
reactor back and forth between modes, since storing traces can take up lots of
memory for if states are large or an interaction is long-running.

  }


@function["get-trace"
  #:contract (a-arrow (R-of "a") (L-of "a"))
  #:args '(("r" #f))
  #:return (L-of "a")]{

Returns a @L of the traced states of the reactor.

  }

@function["get-trace-as-table"
  #:contract (a-arrow (R-of "a") TA)
  #:args '(("r" #f))
  #:return TA]{

Returns a @TA of the traced states of the reactor, in two columns, @pyret{tick}
and @pyret{state}.

  }
  
}


