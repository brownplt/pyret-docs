#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt")
@(define WC (a-id "WorldConfig" (xref "world" "WorldConfig")))

@(append-gen-docs
'(module "world"
  (path "build/phase1/trove/world.js")
  (unknown-item (name "big-bang"))
  (unknown-item (name "on-tick"))
  (unknown-item (name "on-tick-n"))
  (unknown-item (name "to-draw"))
  (unknown-item (name "stop-when"))
  (unknown-item (name "on-key"))
  (unknown-item (name "on-mouse"))
  (unknown-item (name "on-particle"))
  (unknown-item (name "to-particle"))
  (fun-spec (name "is-world-config") (arity 1))
  (fun-spec (name "is-key-equal") (arity 2))
))

@docmodule["world"]{

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


@section{Starting a big-bang}

 @function["big-bang"
            #:contract (a-arrow "a"
                                (a-app L
                                       (a-app WC "a"))
                                "a")
            #:return "a"
            #:args (list '("init" "")
                         '("handlers" ""))]
  

 
@pyret{big-bang} is called with an @tt{init} state and a list of handler
functions.  It immediately creates an interactive window based on @tt{init}
and optionally begins drawing graphics and text as defined by the @pyret{to-draw}
function, running handler functions scheduled by @pyret{on-tick} and
@pyret{on-tick-n} as well as those triggered by @pyret{on-mouse} and
@pyret{on-key}.

@verbatim{
big-bang(init,
  [list: 
    on-tick(@py-prod["expr"]),
    on-tick-n(@py-prod["expr"]),
    on-mouse(@py-prod["expr"]),
    on-key(@py-prod["expr"]),
    to-draw(@py-prod["expr"]),
    stop-when(@py-prod["expr"])
  ]
)
}

Syntactically, all of the handlers for @pyret{big-bang} are optional, with the
exception of @pyret{init}.  They can also appear in any order – the order
displayed above is not required.  Each option can only appear once.  So, for
example, these are valid @pyret{big-bang}s:

@pyret-block[#:style "good-ex"]{
include world
big-bang('inert', [list: ])

fun increment(x): 
  x + 1
end

big-bang(10, [list: on-tick(increment)])
big-bang(10, [list: on-tick-n(increment, 3)])
}

These are not allowed:

@pyret-block[#:style "bad-ex"]{
big-bang(10, 11)
}

@pyret-block[#:style "bad-ex"]{
big-bang([list: on-tick(increment)])
}

@pyret-block[#:style "bad-ex"]{
big-bang(10, [list: not-a-handler(increment)])
}

@pyret-block[#:style "bad-ex"]{
big-bang(10, on-tick(increment))
}
    
  @section{Functions}

  @function["on-tick"
            #:contract (a-arrow (a-arrow "a"
                                         "a")
                                WC)
            #:return (a-app WC "a")
            #:args (list '("handler" ""))]{
    Consumes a function and returns a handler that, when passed to
    @secref[(tag-name "world" "big-bang")], will be called each program tick
    with the current world state.
  }
  @function["on-tick-n"
            #:contract (a-arrow (a-arrow "a"
                                         "a")
                                N
                                WC)
            #:return (a-app WC "a")
            #:args (list '("handler" "")
                         '("n" ""))]{
    Consumes a function and returns a handler that, when passed to
    @secref[(tag-name "world" "big-bang")], will be called every @pyret["n"]
    program ticks with the current world state.
  }
  
  @function["to-draw"
            #:contract (a-arrow (a-arrow "a"
                                         (a-id "Scene" (xref "image" "Scene")))
                                WC)
            #:return (a-app WC "a")
            #:args (list '("drawer" ""))]{
    Consumes a function and returns a handler that, when passed to
    @secref[(tag-name "world" "big-bang")], will inform the world program
    what to draw.
  }

  @function["on-key"
            #:contract (a-arrow (a-arrow "a"
                                         S
                                         "a")
                                WC)
            #:return (a-app WC "a")
            #:args (list '("onKey" ""))]{
    Consumes a function and returns a handler that, when passed to
    @secref[(tag-name "world" "big-bang")], will be called every time a
    key is pressed. The function is called with the current world state
    and a @secref[(tag-name "<global>" "String")] representing the pressed
    key. For most keys, this is just the corresponding single character.

    The special keys are:

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

  }
  @function["on-mouse"
            #:contract (a-arrow (a-arrow "a"
                                         N N S
                                         "a")
                                WC)
            #:return (a-app WC "a")
            #:args (list '("mouse-handler" ""))]{
    Consumes a function and returns a handler that, when passed to
    @secref[(tag-name "world" "big-bang")], will be called on every sampled
    mouse movement. The function will receive the world state, the current
    @pyret["x"] and @pyret["y"] positions of the mouse, and a @secref[(tag-name
    "<global>" "String")] representing a mouse event. Possible mouse
    events are:

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
  }
  @function["stop-when"
            #:contract (a-arrow (a-arrow "a" B)
                                WC)
            #:return (a-app WC "a")
            #:args (list '("stopper" ""))]{
    Consumes a function and returns a handler that, when passed to
    @secref[(tag-name "world" "big-bang")], will be called to determine if
    the world should stop running. If the function returns @pyret["true"],
    then no other handlers will be called. The @secref[(tag-name "world" "big-bang")] 
    function will return this last world state.
  }
  @function["is-world-config"
            #:contract (a-arrow "Any" B)
            #:return (a-app WC "a")
            #:args (list '("v" ""))]{
    Tests if the input is of type @secref[(tag-name "world" "WorldConfig")].
  }
  @function["is-key-equal"
            #:contract (a-arrow S
                                S
                                B)
            #:return (a-app WC "a")
            #:args (list '("key1" "")
                         '("key2" ""))]{
    Tests if two key events are equals to each other.
  }

    @section[#:tag "image_DataTypes"]{Data Types}

  @type-spec["WorldConfig" (list "a")]

  This type includes the values that can be passed to @pyret-id{big-bang} as
  event handlers (e.g. @pyret-id{on-tick} and @pyret-id{on-key}), renderers
  (e.g. @pyret-id{to-draw}), and other configuration options (e.g.
  @pyret-id{stop-when}).
}



