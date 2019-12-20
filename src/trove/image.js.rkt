#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
          (prefix-in html: "../../manual-html.rkt")
          2htdp/image racket/list
          scribble/manual)

@(define (transpose . args) (apply map list args))

@(define (type-versions v1 v2)
   (define (add-paras info)
     (cons (first info)
           (add-between (rest info) @para{})))
   @tabular[#:sep @hspace[4]
            #:row-properties '((center bottom-border) (top))
            (transpose (add-paras v1) (add-paras v2))])


@(define (draw-pinhole x y img #:color [c 'black])
   (overlay/offset (overlay (line 10 0 c) (line 0 10 c)) x y img))


@(append-gen-docs
`(module "image"
  (path "build/phase1/trove/image.js")
  (fun-spec (name "circle") (arity 3))
  (fun-spec (name "is-image-color") (arity 1))
  (fun-spec (name "is-mode") (arity 1))
  (fun-spec (name "is-x-place") (arity 1))
  (fun-spec (name "is-y-place") (arity 1))
  (fun-spec (name "is-angle") (arity 1))
  (fun-spec (name "is-side-count") (arity 1))
  (fun-spec (name "is-step-count") (arity 1))
  (fun-spec (name "is-image") (arity 1))
  (fun-spec (name "bitmap-url") (arity 1))
  (fun-spec (name "image-url") (arity 1))
  (fun-spec (name "images-equal") (arity 2))
  (fun-spec (name "images-difference") (arity 2))
  (fun-spec (name "text") (arity 3))
  (fun-spec (name "text-font") (arity 8))
  (fun-spec (name "overlay") (arity 2))
  (fun-spec (name "overlay-xy") (arity 4))
  (fun-spec (name "overlay-align") (arity 4))
  (fun-spec (name "overlay-onto-offset") (arity 8))
  (fun-spec (name "underlay") (arity 2))
  (fun-spec (name "underlay-xy") (arity 4))
  (fun-spec (name "underlay-align") (arity 4))
  (fun-spec (name "beside") (arity 2))
  (fun-spec (name "beside-align") (arity 3))
  (fun-spec (name "above") (arity 2))
  (fun-spec (name "above-align") (arity 3))
  (unknown-item (name "empty-image"))
  (fun-spec (name "empty-scene") (arity 2))
  (fun-spec (name "empty-color-scene") (arity 3))
  (fun-spec (name "put-image") (arity 4))
  (fun-spec (name "place-image") (arity 4))
  (fun-spec (name "place-image-align") (arity 6))
  (fun-spec (name "rotate") (arity 2))
  (fun-spec (name "scale") (arity 2))
  (fun-spec (name "scale-xy") (arity 3))
  (fun-spec (name "flip-horizontal") (arity 1))
  (fun-spec (name "flip-vertical") (arity 1))
  (fun-spec (name "frame") (arity 1))
  (fun-spec (name "crop") (arity 5))
  (fun-spec (name "line") (arity 3))
  (fun-spec (name "add-line") (arity 6))
  (fun-spec (name "scene-line") (arity 6))
  (fun-spec (name "square") (arity 3))
  (fun-spec (name "rectangle") (arity 4))
  (fun-spec (name "regular-polygon") (arity 4))
  (fun-spec (name "ellipse") (arity 4))
  (fun-spec (name "triangle") (arity 3))
  (fun-spec (name "triangle-sas") (arity 5))
  (fun-spec (name "triangle-sss") (arity 5))
  (fun-spec (name "triangle-ass") (arity 5))
  (fun-spec (name "triangle-ssa") (arity 5))
  (fun-spec (name "triangle-aas") (arity 5))
  (fun-spec (name "triangle-asa") (arity 5))
  (fun-spec (name "triangle-saa") (arity 5))
  (fun-spec (name "right-triangle") (arity 4))
  (fun-spec (name "isosceles-triangle") (arity 4))
  (fun-spec (name "star") (arity 3))
  (fun-spec (name "star-sized") (arity 5))
  (fun-spec (name "radial-star") (arity 5))
  (fun-spec (name "star-polygon") (arity 5))
  (fun-spec (name "rhombus") (arity 4))
  (fun-spec (name "point-polygon") (arity 3))
  (fun-spec (name "wedge") (arity 4))
  (fun-spec (name "color-at-position") (arity 3))
  (fun-spec (name "image-to-color-list") (arity 1))
  (fun-spec (name "color-list-to-image") (arity 1))
  (fun-spec (name "color-list-to-bitmap") (arity 1))
  (fun-spec (name "image-width") (arity 1))
  (fun-spec (name "image-height") (arity 1))
  (fun-spec (name "image-baseline") (arity 1))
  (fun-spec (name "name-to-color") (arity 1))
  (fun-spec (name "color-named") (arity 1))
  (fun-spec (name "move-pinhole") (arity 3))
  (fun-spec (name "place-pinhole") (arity 1))
  (fun-spec (name "center-pinhole") (arity 1))
  (fun-spec (name "draw-pinhole") (arity 1))
  (data-spec (name "Image") (variants) (shared))
  (data-spec (name "Scene") (variants) (shared))
  (data-spec (name "ImageColor") (variants) (shared))
  (data-spec (name "FontFamily") (variants "ff-default"
                                           "ff-decorative" "ff-roman"
                                           "ff-script" "ff-swiss"
                                           "ff-modern" "ff-symbol" "ff-system") (shared))
  (singleton-spec (name "ff-default") (with-members))
  (singleton-spec (name "ff-decorative") (with-members))
  (singleton-spec (name "ff-roman") (with-members))
  (singleton-spec (name "ff-script") (with-members))
  (singleton-spec (name "ff-swiss") (with-members))
  (singleton-spec (name "ff-modern") (with-members))
  (singleton-spec (name "ff-symbol") (with-members))
  (singleton-spec (name "ff-system") (with-members))
  (data-spec (name "FontStyle") (variants "fs-normal" "fs-italic" "fs-slant") (shared))
  (singleton-spec (name "fs-normal") (with-members))
  (singleton-spec (name "fs-italic") (with-members))
  (singleton-spec (name "fs-slant") (with-members))
  (data-spec (name "FontWeight") (variants "fw-normal" "fw-bold" "fw-light") (shared))
  (singleton-spec (name "fw-normal") (with-members))
  (singleton-spec (name "fw-bold") (with-members))
  (singleton-spec (name "fw-light") (with-members))
  (data-spec (name "XPlace") (variants) (shared))
  (singleton-spec (name "x-left") (with-members))
  (singleton-spec (name "x-middle") (with-members))
  (unknown-item (name "x-center"))
  (singleton-spec (name "x-pinhole") (with-members))
  (singleton-spec (name "x-right") (with-members))
  (data-spec (name "YPlace") (variants) (shared))
  (singleton-spec (name "y-top") (with-members))
  (singleton-spec (name "y-center") (with-members))
  (unknown-item (name "y-middle"))
  (singleton-spec (name "y-pinhole") (with-members))
  (singleton-spec (name "y-baseline") (with-members))
  (singleton-spec (name "y-bottom") (with-members))
  (data-spec (name "Point") (variants ("point-xy" "point-polar")) (shared))
  (data-spec (name "Point2D") (variants) (shared))
  (constr-spec (name "point-xy")
               (members (("x" ("type" "normal") ("contract" ,N))
                         ("y" ("type" "normal") ("contract" ,N))))
               (with-members))
  (constr-spec (name "point-polar")
               (members (("r" ("type" "normal") ("contract" ,N))
                         ("theta" ("type" "normal") ("contract" ,N))))
               (with-members))
  (fun-spec (name "point") (arity 2) (params [list: ]) (args ("x" "y"))
            (return (a-id "Point" (xref "image" "Point")))
            (contract (a-arrow ,N ,N (a-id "Point" (xref "image"
                                                         "Point")))))
  (data-spec (name "FillMode") (variants ("mode-solid" "mode-outline" "mode-fade")) (shared))
  (singleton-spec (name "mode-solid") (with-members))
  (singleton-spec (name "mode-outline") (with-members))
  (constr-spec (name "mode-fade")
               (members (("n" ("type" "normal") ("contract" ,N))))
               (with-members))
))


@(define Image (a-id "Image" (xref "image" "Image")))
@(define Scene (a-id "Scene" (xref "image" "Scene")))
@(define ImageColor (a-id "ImageColor" (xref "image" "ImageColor")))
@(define Color (a-id "Color" (xref "color" "Color")))
@(define OptColor (O-of Color))
@(define Point (a-id "Point" (xref "image" "Point")))
@(define FillMode (a-id "FillMode" (xref "image" "FillMode")))
@(define FontFamily (a-id "FontFamily" (xref "image" "FontFamily")))
@(define FontStyle (a-id "FontStyle" (xref "image" "FontStyle")))
@(define FontWeight (a-id "FontWeight" (xref "image" "FontWeight")))
@(define XPlace (a-id "XPlace" (xref "image" "XPlace")))
@(define YPlace (a-id "YPlace" (xref "image" "YPlace")))
@(define (paint-swatch color css-color)
   (list (html:span 'style: "font-size: initial;"
                    (html:image 'class: "paintBrush" "https://code.pyret.org/img/brush.svg")
                    (html:span 'class: "paintSpan"
                               (html:span 'class: "checkersBlob")
                               (html:span 'class: "paintBlob"
                                          'style: (format "background-color: ~a; margin-right: 0.25em;" css-color))))
         (pyret color)))

@docmodule["image" #:noimport #t #:friendly-title "The image libraries"]{

  @margin-note{
  The Pyret images library is based on the @code{images} teachpack in @emph{How to Design Programs},
  a textbook whose pedagogy has heavily influenced Pyret's design (see
  @hyperlink["https://www.pyret.org/pyret-code/#what-are-some-ways-the-educational-philosophy-influences-the-language"]{Why Pyret?} for more information).
  @bold{@emph{Note:}} this original library is written in Racket, a @emph{different} language than
  Pyret.  The examples in that file therefore do @emph{not} work with Pyret as written;
  however, analogous examples are shown here.  If you're curious,
  you can find documentation for the @code{images} teachpack here:

  @url["http://docs.racket-lang.org/teachpack/2htdpimage.html"]
  }

  Pyret supplies two modules for creating, combining, and displaying
  images.  These two libraries supply the same set of functions, but
  with different signatures:


  @itemlist[

            @item{The @pyret{image} module functions take
  in strings for many of the arguments.  To use this version of the library:

  @pyret{include image}
  
  @pyret{import image as ...}
  
  If you are new to programming, or to Pyret, we recommend that you
  use this version of the library.}

            @item{The @pyret{image-typed} module functions take in
enumerated values.  This second library is encouraged for use with the
@seclink["type-check"]{type checker}, as it can give more precise
feedback.  To use this version of the library:

  @pyret{include image}
  
  @pyret{import image as ...}

  }
            ]

  While you cannot @pyret{include} both versions of the library
simultaneously, you @emph{can} @pyret{import} them both, if you would
like to migrate from one version of the library to the other.


@section[#:tag "image_DataTypes"]{Data Types}
This section defines the key data types used in both versions of the
image library.  Wherever possible, the types are identical between the
two libraries.  When different, we will display equivalent versions of
the types side by side.

@type-spec["Image" (list)]{

    This is the return type of many of the functions in this module; it
    includes simple shapes, like circles and squares, and also combinations
    or transformations of existing shapes, like rotations, overlays, and
    scaling.
    }
  @type-spec["Scene" (list)]{

    Like an @pyret-id["Image"] but with a few special functions that crop any
    overhanging parts of images that are placed atop them, instead of
    stretching to accommodate.
    }
  @type-spec["ImageColor" (list)]{
   @type-versions[
     (list @bold{The @pyret{image} library}
           
           @nested{An @tt{ImageColor} can be a string describing a color
                 name, for example @pyret{"red"} or @pyret{"sea-green"}.
                 The collection of names Pyret understands is shown
                 @seclink["s:color-constants"]{here}: each name can be
                 used as a string (see @pyret-id{color-named} below).}
           
           @nested{An @tt{ImageColor} can be one of the
                 @seclink["s:color-constants"]{predefined colors}
                 themselves.  To use these colors with the @pyret{image}
                 library, you can write
                 
                 @pyret-block{
                 include color
                 include image
                                         
                 circle(50, "solid", sea-green)
                 }}
           
           @nested{An @tt{ImageColor} can be a @pyret-id["Color" "color"],
                 which you can use to construct colors other than the predefined ones,
                 including making colors partially transparent by controlling their
                 opacity.  To use this constructor with the
                 @pyret{image} library, you need to include the
                 @pyret{color} library as above.})

    (list @bold{The @pyret{image-typed} library}

          @nested{}

          @nested{An @tt{ImageColor} can be one of the
                @seclink["s:color-constants"]{predefined colors},
                which are included automatically when using the
                @pyret{image-typed} library}

          @nested{An @tt{ImageColor} can be a @pyret-id["Color" "color"],
                which you can use to construct colors other than the predefined ones,
                including making colors partially transparent by controlling their
                opacity.})]
    }

  @function[
    "color-named"
            #:contract (a-arrow S Color)
            #:return Color
            #:args (list '("name" ""))]

  Looks up the given string in the list of
@seclink["s:color-constants"]{predefined colors}.  The names are
treated case-insensitively.  Hyphens in the names can be replaced with
spaces, or can be dropped altogether.  Unknown color names produce an error.

  @repl-examples[
    `(@{color-named("red")} ,(paint-swatch "red" "red"))
    `(@{color-named("blue")} ,(paint-swatch "blue" "blue"))
    `(@{color-named("bLUE")} ,(paint-swatch "blue" "blue"))
    `(@{color-named("sea-green")} ,(paint-swatch "sea-green" "seagreen"))
    `(@{color-named("sea green")} ,(paint-swatch "sea-green" "seagreen"))
    `(@{color-named("seagreen")} ,(paint-swatch "sea-green" "seagreen"))
    `(@{color-named("transparent")} ,(paint-swatch "transparent" "rgba(0,0,0,0)"))
    `(@{color-named("UNKNOWN")} "Unknown color name 'UNKNOWN'")
  ]

  
  @function[
    "name-to-color"
            #:contract (a-arrow S Color)
            #:return OptColor
            #:args (list '("name" ""))]

  Looks up the given string in the list of predefined colors.  Names
  are simplified as in @pyret-id{color-named}.  If the color is known,
  then @pyret-id["some" "option"] @pyret-id["Color" "color"] value is returned; if the 
  color is unknown, the function returns @pyret-id["none" "option"].

  @repl-examples[
    `(@{name-to-color("red")} (,(pyret "some(") ,(paint-swatch "red" "red") ,(pyret ")")))
    `(@{name-to-color("blue")} (,(pyret "some(") ,(paint-swatch "blue" "blue") ,(pyret ")")))
    `(@{name-to-color("transparent")} (,(pyret "some(") ,(paint-swatch "transparent" "rgba(0,0,0,0)") ,(pyret ")")))
    `(@{color-named("UNKNOWN")} ,(pyret "none"))
  ]
  

  @data-spec2["Point" (list) (list
    (constructor-spec "Point" "point-xy"
                      `(("x" ("type" "normal") ("contract" ,N))
                        ("y" ("type" "normal") ("contract" ,N))))
    (constructor-spec "Point" "point-polar"
                      `(("r" ("type" "normal") ("contract" ,N))
                        ("theta" ("type" "normal") ("contract" ,N))))

                              )]

  @pyret-id{Point}s represent two-dimensional coordinates on a plane.
  Points can be defined using either Cartesian or polar coordinates.
  
  @nested[#:style 'inset]{
    @constructor-doc["Point" "point-xy"
                      `(("x" ("type" "normal") ("contract" ,N))
                        ("y" ("type" "normal") ("contract" ,N)))
                     (a-id "Point" (xref "image" "Point"))]{
    This constructor defines standard two-dimensional Cartesian
         coordinates.
         }
                                                 
    @function["point" #:alt-docstrings ""]
    A convenient synonym for @pyret{point-xy}.

    @constructor-doc["Point" "point-polar"
                     `(("r" ("type" "normal") ("contract" ,N))
                       ("theta" ("type" "normal") ("contract" ,N)))
                     (a-id "Point" (xref "image" "Point"))]{
    This constructor defines two-dimensional polar coordinates.  The
         angle @pyret{theta} should be specified in radians.

         }
                           }

  @type-spec["Point2D" (list)]{A convenient synonym for @|Point|.}

  
  @section{Basic Images}
  @function[
    "circle"
            #:contract (a-arrow N FillMode ImageColor Image)
            #:return Image
            #:args (list '("radius" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs a circle with the given radius, mode and color.
  }

  @repl-examples[
    `(@{circle(30, "outline", "red")} ,(circle 30 "outline" "red"))
    `(@{circle(20, "solid", "red")} ,(circle 20 "solid" "red"))
  ]

  @function[
    "ellipse"
            #:contract (a-arrow N N FillMode ImageColor Image)
            #:return Image
            #:args (list '("width" "") 
                         '("height" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an ellipse with the given width, height, mode and
    color.
  }
  @repl-examples[
    `(@{ellipse(60, 30, "outline", "black")} ,(ellipse 60 30 "outline" "black"))
    `(@{ellipse(30, 60, "solid", "blue")} ,(ellipse 30 60 "solid" "blue"))
  ]
  @function[
    "line"
            #:contract (a-arrow N N ImageColor Image)
            #:return Image
            #:args (list '("x" "") 
                         '("y" "") 
                         '("color" ""))]{
    Draws an image of a line that connects the point (0,0) to the point
    (x,y).
  }
  @repl-examples[
    `(@{line(60, 30, "black")} ,(line 60 30 "black"))
    `(@{line(30, 60, "blue")} ,(line 30 60 "blue"))
    `(@{line(-30, 20, "red")} ,(line -30 20 "red"))
    `(@{line(30, -20, "red")} ,(line 30 -20 "red"))
  ]
  @function[
    "add-line"
            #:contract (a-arrow Image N N N N ImageColor Image)
            #:return Image                                  
            #:args (list '("img" "") 
                         '("x1" "") 
                         '("y1" "") 
                         '("x2" "") 
                         '("y2" "") 
                         '("color" ""))]{
    Creates a new image like @pyret{img} with a line added starting from
    the point (x1,y1)
    and going to the point (x2,y2). Unlike @pyret-id["scene-line"],
    if the line passes outside of @pyret{img}, the image gets larger to
    accommodate the line.
  }
  @repl-examples[
    `(@{add-line(circle(20, "outline", "maroon"), 0, 40, 40, 0, "orange")}
      ,(add-line (circle 20 "outline" "maroon") 0 40 40 0 "orange"))
    `(@{add-line(rectangle(40, 40, "outline", "maroon"), -10, 50, 50, -10, "orange")}
      ,(add-line (rectangle 40 40 "outline" "maroon") -10 50 50 -10 "orange"))
  ]

  @subsection{Data types for drawing basic images}

    @type-spec["FillMode" (list) #:private #t]{
    @|FillMode|s describe the style for a shape.

    @type-versions[
     (list @bold{The @pyret{image} library}

           @nested{@|FillMode|s can be one of a fixed set of
                         @pyret-id["String" "<global>"]s, or a
                         @pyret-id["Number" "<global>"]}
           
           @nested{The string @pyret{"solid"}}
           @nested{The string @pyret{"outline"}}
           @nested{A number between 0 and 1}
           )
     
     (list @bold{The @pyret{image-typed} library}

           @nested{@|FillMode|s are an enumerated data definition:
                         
           @data-spec2["FillMode" (list) #:no-toc #t
                        (list
                         (singleton-spec2 "FillMode" "mode-solid")
                         (singleton-spec2 "FillMode" "mode-outline")
                         (constructor-spec "FillMode" "mode-fade"
                                           `(("n" ("type" "normal") ("contract" ,N)))))]}

           @nested{@singleton-doc["FillMode" "mode-solid" FillMode #:style ""]{
                 Shapes should be drawn solidly filled in}}

           @nested{@singleton-doc["FillMode" "mode-outline" FillMode #:style ""]{
                 Shapes should only be drawn in outline}}

           @nested{@constructor-doc["FillMode" "mode-fade"
                                  `(("n" ("type" "normal") ("contract" ,N)))
                                  FillMode #:style "pyret-header"]{
                 Shapes should be drawn semi-transparently,
                        where @pyret{n} is an opacity
                        between 0 (transparent) and 1 (fully opaque)
                        }}
           )
     ]
    }


  
  @section[#:tag "text-images"]{Text}

  @function[
    "text"
            #:contract (a-arrow S N ImageColor Image)
            #:return Image                                  
            #:args (list '("string" "") 
                         '("font-size" "") 
                         '("color" ""))]{
    Constructs an image of @pyret{string}, using the given font size
    and color.
  }
  @repl-examples[
    `(@{text("Hello", 24, "olive")}
      ,(text/font "Hello" 24 "olive" "DejaVu Serif" 'roman 'normal 'normal #f))
    `(@{text("Goodbye", 36, "indigo")}
      ,(text/font "Goodbye" 36 "indigo" "DejaVu Serif" 'roman 'normal 'normal #f))
  ]
  @margin-note{@pyret{font-face} is system-dependent because
    different computers and operating systems have different fonts installed.
    You can try different options for the names of fonts on your machine,
    and @pyret-id{text-font} will fall back to a default in the given family if
    it can't find the one provided.}
  @function[
    "text-font"
            #:contract (a-arrow S N ImageColor S FontFamily FontStyle FontWeight B Image)
            #:return Image
            #:args (list '("string" "") 
                         '("size" "") 
                         '("color" "") 
                         '("font-face" "") 
                         '("font-family" "") 
                         '("style" "") 
                         '("weight" "") 
                         '("underline" ""))]{
    Like @secref[(tag-name "image" "text")], constructs an image that draws the given
    string, but makes use of a complete font specification.  The various style
    options are described below.  
  }
  @repl-examples[
    `(@{text-font("Hello", 24, "green", "Gill Sans",
                  "swiss", "italic", "normal", true)}
      ,(text/font "Hello" 24 "green" "Gill Sans" 'swiss 'italic 'normal #t))
    `(@{text-font("Goodbye", 36, "turquoise", "Treasure Map Deadhand",
                  "decorative", "normal", "normal", false)}
      ,(text/font "Goodbye" 36 "turquoise" "Treasure Map Deadhand" 'decorative 'normal 'normal #f))
  ]

  @subsection{Data types for text images}
  
  @type-spec["FontFamily" (list) #:private #t]{
    @type-versions[
                   
     (list @bold{The @pyret{image} library}

           @nested{A @|FontFamily| can be one of a fixed set of @pyret-id["String" "<global>"]s}

           @nested{@pyret{"default"}}
           
           @nested{@pyret{"decorative"}}
           
           @nested{@pyret{"roman"}}
           
           @nested{@pyret{"script"}}
           
           @nested{@pyret{"swiss"}}
           
           @nested{@pyret{"modern"}}
           
           @nested{@pyret{"symbol"}}
           
           @nested{@pyret{"system"}})

     
     (list @bold{The @pyret{image-typed} library}

           @nested{A @|FontFamily| is an enumerated data definition:
                         
           @data-spec2["FontFamily" (list) #:no-toc #t
                        (list
                         (singleton-spec2 "FontFamily" "ff-default")
                         (singleton-spec2 "FontFamily" "ff-decorative")
                         (singleton-spec2 "FontFamily" "ff-roman")
                         (singleton-spec2 "FontFamily" "ff-script")
                         (singleton-spec2 "FontFamily" "ff-swiss")
                         (singleton-spec2 "FontFamily" "ff-modern")
                         (singleton-spec2 "FontFamily" "ff-symbol")
                         (singleton-spec2 "FontFamily" "ff-system"))]}

           @nested{@singleton-doc["FontFamily" "ff-default" FontFamily #:style ""]{}}
           @nested{@singleton-doc["FontFamily" "ff-decorative" FontFamily #:style ""]{}}
           @nested{@singleton-doc["FontFamily" "ff-roman" FontFamily #:style ""]{}}
           @nested{@singleton-doc["FontFamily" "ff-script" FontFamily #:style ""]{}}
           @nested{@singleton-doc["FontFamily" "ff-swiss" FontFamily #:style ""]{}}
           @nested{@singleton-doc["FontFamily" "ff-modern" FontFamily #:style ""]{}}
           @nested{@singleton-doc["FontFamily" "ff-symbol" FontFamily #:style ""]{}}
           @nested{@singleton-doc["FontFamily" "ff-system" FontFamily #:style ""]{}}
           )]

    }

  @type-spec["FontStyle" (list) #:private #t]{
    @type-versions[
                   
     (list @bold{The @pyret{image} library}

           @nested{A @|FontStyle| can be one of a fixed set of @pyret-id["String" "<global>"]s}

           @nested{@pyret{"normal"}}
           
           @nested{@pyret{"italic"}}
           
           @nested{@pyret{"slant"}}
           )

     
     (list @bold{The @pyret{image-typed} library}

           @nested{A @|FontStyle| is an enumerated data definition:
                         
           @data-spec2["FontStyle" (list) #:no-toc #t
                        (list
                         (singleton-spec2 "FontStyle" "fs-normal")
                         (singleton-spec2 "FontStyle" "fs-italic")
                         (singleton-spec2 "FontStyle" "fs-slant"))]}

           @nested{@singleton-doc["FontStyle" "fs-normal" FontStyle #:style ""]{}}
           @nested{@singleton-doc["FontStyle" "fs-italic" FontStyle #:style ""]{}}
           @nested{@singleton-doc["FontStyle" "fs-slant" FontStyle #:style ""]{}}
           )]

    }
  @type-spec["FontWeight" (list) #:private #t]{
    @type-versions[
                   
     (list @bold{The @pyret{image} library}

           @nested{A @|FontWeight| can be one of a fixed set of @pyret-id["String" "<global>"]s}

           @nested{@pyret{"normal"}}
           
           @nested{@pyret{"bold"}}
           
           @nested{@pyret{"light"}}
           )

     
     (list @bold{The @pyret{image-typed} library}

           @nested{A @|FontWeight| is an enumerated data definition:
                         
           @data-spec2["FontWeight" (list) #:no-toc #t
                        (list
                         (singleton-spec2 "FontWeight" "fw-normal")
                         (singleton-spec2 "FontWeight" "fw-bold")
                         (singleton-spec2 "FontWeight" "fw-light"))]}

           @nested{@singleton-doc["FontWeight" "fw-normal" FontWeight #:style ""]{}}
           @nested{@singleton-doc["FontWeight" "fw-bold" FontWeight #:style ""]{}}
           @nested{@singleton-doc["FontWeight" "fw-light" FontWeight #:style ""]{}}
           )]

    }

  @section{Polygons}
  @function[
    "triangle"
            #:contract (a-arrow N FillMode ImageColor Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of an upward-pointing equilateral triangle. Each
    side will be of length @pyret{side-length}.
  }
  @repl-examples[
    `(@{triangle(40, "solid", "tan")}
      ,(triangle 40 'solid 'tan))
  ]
  @function[
    "right-triangle"
            #:contract (a-arrow N N FillMode ImageColor Image)
            #:return Image
            #:args (list '("side-length1" "") 
                         '("side-length2" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle with a right angle at the bottom-left
    corner and where the two sides adjacent to the right angle have lengths
    @pyret{side-length1} and @pyret{side-length2}.
  }
  @repl-examples[
    `(@{right-triangle(36, 48, "solid", "steel blue")}
      ,(right-triangle 36 48 'solid "steelblue"))
  ]
  @function[
    "isosceles-triangle"
            #:contract (a-arrow N N FillMode ImageColor Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle with two equal-length sides, of
    length @pyret{side-length} where the angle between those two sides is
    @pyret{angle-c}. if the angle is less than @pyret{180}, then the triangle
    will point up; otherwise, the triangle will point down.
  }
  @repl-examples[
    `(@{isosceles-triangle(200, 170, "solid", "sea-green")}
      ,(isosceles-triangle 200 170 'solid "seagreen"))
    `(@{isosceles-triangle(60, 30, "solid", "royal-blue")}
      ,(isosceles-triangle 60 30 'solid "royalblue"))
    `(@{isosceles-triangle(60, 330, "solid", "dark-magenta")}
      ,(isosceles-triangle 60 330 'solid "darkmagenta"))
  ]
  @function[
    "triangle-sss"
            #:contract (a-arrow N N N FillMode ImageColor Image)
            #:return Image
            #:args (list '("side-a" "") 
                         '("side-b" "") 
                         '("side-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the three given sides.
  }
  @repl-examples[
    `(@{triangle-sss(40, 60, 80, "solid", "sea-green")}
      ,(triangle/sss 40 60 80 'solid "seagreen"))
    `(@{triangle-sss(80, 40, 60, "solid", "royal-blue")}
      ,(triangle/sss 80 40 60 'solid "royalblue"))
    `(@{triangle-sss(80, 80, 40, "solid", "dark-magenta")}
      ,(triangle/sss 80 80 40 'solid "darkmagenta"))
  ]
  @function[
    "triangle-ass"
            #:contract (a-arrow N N N FillMode ImageColor Image)
            #:return Image
            #:args (list '("angle-a" "") '("side-b" "") '("side-c" "") '("mode" "") '("color" ""))]{
    Constructs an image of a triangle using the given angle and two sides.
  }
  @repl-examples[
    `(@{triangle-ass(10, 60, 100, "solid", "sea-green")}
      ,(triangle/ass 10 60 100 'solid "seagreen"))
    `(@{triangle-ass(90, 60, 100, "solid", "royal-blue")}
      ,(triangle/ass 90 60 100 'solid "royalblue"))
    `(@{triangle-ass(130, 60, 100, "solid", "dark-magenta")}
      ,(triangle/ass 130 60 100 'solid "darkmagenta"))
  ]
  @function[
    "triangle-sas"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("side-a" "") 
                         '("angle-b" "") 
                         '("side-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the given angle and two sides.
  }
  @repl-examples[
    `(@{triangle-sas(60, 10, 100, "solid", "sea-green")}
      ,(triangle/sas 60 10 100 'solid "seagreen"))
    `(@{triangle-sas(60, 90, 100, "solid", "royal-blue")}
      ,(triangle/sas 60 90 100 'solid "royalblue"))
    `(@{triangle-sas(60, 130, 100, "solid", "dark-magenta")}
      ,(triangle/sas 60 130 100 'solid "darkmagenta"))
  ]
  @function[
    "triangle-ssa"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("side-a" "") 
                         '("side-b" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the given angle and two sides.
  }
  @repl-examples[
    `(@{triangle-ssa(60, 100, 10, "solid", "sea-green")}
      ,(triangle/ssa 60 100 10 'solid "seagreen"))
    `(@{triangle-ssa(60, 100, 90, "solid", "royal-blue")}
      ,(triangle/ssa 60 100 90 'solid "royalblue"))
    `(@{triangle-ssa(60, 100, 130, "solid", "dark-magenta")}
      ,(triangle/ssa 60 100 130 'solid "darkmagenta"))
  ]
  @function[
    "triangle-aas"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("angle-a" "") 
                         '("angle-b" "") 
                         '("side-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the two given angles and
    side.
  }
  @repl-examples[
    `(@{triangle-aas(10, 40, 200, "solid", "sea-green")}
      ,(triangle/aas 10 40 200 'solid "seagreen"))
    `(@{triangle-aas(90, 40, 200, "solid", "royal-blue")}
      ,(triangle/aas 90 40 200 'solid "royalblue"))
    `(@{triangle-aas(130, 40, 40, "solid", "dark-magenta")}
      ,(triangle/aas 130 40 40 'solid "darkmagenta"))
  ]
  @function[
    "triangle-asa"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("angle-a" "") 
                         '("side-b" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the two given angles and
    side.
  }
  @repl-examples[
    `(@{triangle-asa(10, 200, 40, "solid", "sea-green")}
      ,(triangle/asa 10 200 40 'solid "seagreen"))
    `(@{triangle-asa(90, 200, 40, "solid", "royal-blue")}
      ,(triangle/asa 90 200 40 'solid "royalblue"))
    `(@{triangle-asa(130, 40, 40, "solid", "dark-magenta")}
      ,(triangle/asa 130 40 40 'solid "darkmagenta"))
  ]
  @function[
    "triangle-saa"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("side-a" "") 
                         '("angle-b" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the two given angles and
    sides.
  }
  @repl-examples[
    `(@{triangle-saa(200, 10, 40, "solid", "sea-green")}
      ,(triangle/saa 200 10 40 'solid "seagreen"))
    `(@{triangle-saa(200, 90, 40, "solid", "royal-blue")}
      ,(triangle/saa 200 90 40 'solid "royalblue"))
    `(@{triangle-saa(40, 130, 40, "solid", "dark-magenta")}
      ,(triangle/saa 40 130 40 'solid "darkmagenta"))
  ]
  @function[
    "square"
            #:contract (a-arrow N S ImageColor Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a square with the given side length, mode and color.
  }
  @repl-examples[
    `(@{square(40, "solid", "slate-blue")}
      ,(square 40 "solid" "slateblue"))
    `(@{square(50, "outline", "light-steel-blue")}
      ,(square 50 "outline" "lightsteelblue"))
  ]
  @function[
    "rectangle"
            #:contract (a-arrow N N S ImageColor Image)
            #:return Image
            #:args (list '("width" "") 
                         '("height" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a rectangle with the given side width, height,
    mode and color.
  }
  @repl-examples[
    `(@{rectangle(60, 30, "outline", "black")} ,(rectangle 60 30 "outline" "black"))
    `(@{rectangle(30, 60, "solid", "blue")} ,(rectangle 30 60 "solid" "blue"))
  ]
  @function[
    "rhombus"
            #:contract (a-arrow N N S ImageColor Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("angle" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs a four-sided polygon whose sides are of length
    @pyret{side-length} and thus has angles equal to their opposites. The
    top and bottom pair of angles is @pyret{angle} and the left and right
    pair is @pyret{180 - angle}.
  }
  @repl-examples[
    `(@{rhombus(40, 45, "solid", "magenta")} ,(rhombus 40 45 "solid" "magenta"))
    `(@{rhombus(80, 150, "solid", "medium-purple")} ,(rhombus 80 150 "solid" "mediumpurple"))
  ]
  @function[
    "star"
            #:contract (a-arrow N S ImageColor Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs a five-pointed star with sides of length @pyret{side-length},
    and with the given mode and color.
  }
  @repl-examples[
    `(@{star(40, "solid", "gray")} ,(star 40 "solid" "gray"))
  ]
  @function[
    "radial-star"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("point-count" "") '("outer" "") '("inner" "") '("mode" "") '("color" ""))]{
    Constructs a star with @pyret{point-count} points. The outer points will
    lie a distance of @pyret{outer} from the center of the star, while the
    inner points will lie a distance of @pyret{inner} from the center.
  }
  @repl-examples[
    `(@{radial-star(8, 28, 64, "solid", "dark-green")} ,(radial-star 8 28 64 "solid" "darkgreen"))
    `(@{radial-star(32, 30, 40, "outline", "black")} ,(radial-star 32 30 40 "outline" "black"))
  ]
  @function[
    "star-sized"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("point-count" "") 
                         '("outer" "") 
                         '("inner" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Same as @secref[(tag-name "image" "radial-star")].
  }
  @function[
    "star-polygon"
            #:contract (a-arrow N N N S ImageColor Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("point-count" "") 
                         '("step" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of an arbitrary regular star polygon. The polygon
    is enclosed by a regular polygon with @pyret{side-count} sides each
    @pyret{side-length} long. The polygon is actually constructed by going
    from vertex to vertex around the regular polygon, but connecting every
    @pyret{step-count}-th vertex (i.e., skipping every 
    @pyret{step-count - 1} vertices).
  }
  @repl-examples[
    `(@{star-polygon(40, 5, 2, "solid", "sea-green")} ,(star-polygon 40 5 2 "solid" "seagreen"))
    `(@{star-polygon(40, 7, 3, "outline", "dark-red")} ,(star-polygon 40 7 3 "outline" "darkred"))
    `(@{star-polygon(40, 8, 3, "outline", "goldenrod")} ,(star-polygon 40 8 3 "outline" "goldenrod"))
    ; NOTE: This example doesn't work!  Needs the new image library...
    ;`(@{star-polygon(40, 8, 2, "outline", "burlywood")}
    ;  ,(overlay (star-polygon 40 4 1 "outline" "burlywood")
    ;            (rotate 45 (star-polygon 40 4 1 "outline" "burlywood"))))
    `(@{star-polygon(20, 10, 3, "solid", "cornflower-blue")} ,(star-polygon 20 10 3 "solid" "cornflowerblue"))
  ]
  @function[
    "regular-polygon"
            #:contract (a-arrow N N S ImageColor Image)
            #:return Image
            #:args (list '("length" "") 
                         '("count" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a regular polygon with @pyret{side-count} sides.
  }
  @repl-examples[
    `(@{regular-polygon(40, 5, "solid", "sea-green")} ,(regular-polygon 40 5 "solid" "seagreen"))
    `(@{regular-polygon(40, 7, "outline", "dark-red")} ,(regular-polygon 40 7 "outline" "darkred"))
    `(@{regular-polygon(40, 8, "outline", "goldenrod")} ,(regular-polygon 40 8 "outline" "goldenrod"))
    `(@{regular-polygon(20, 8, "solid", "cornflower-blue")} ,(regular-polygon 20 8 "solid" "cornflowerblue"))
  ]

  @function["point-polygon"
            #:contract (a-arrow (L-of Point) FillMode ImageColor Image)
            #:return Image
            #:args '(("points" "") ("mode" "") ("color" ""))]{
    Creates a polygon whose corners are specified by the given list of
    points.
  }        
  
  @function["wedge"
            #:contract (a-arrow N N FillMode ImageColor Image)
            #:return Image
            #:args '(("radius" "") ("angle" "") ("mode" "") ("color" ""))]{
    Draws a pie-shaped section of a circle.  The
    @seclink["pinholes"]{pinhole} of the resulting image is at the
    center of the circle from which this wedge is cut.  The angle is
    measured in degrees, measured counterclockwise from the positive x-axis.
  }

  
  @section{Overlaying Images}

  @function[
    "overlay"
            #:contract (a-arrow Image Image Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("img2" ""))]{
    Constructs a new image where @pyret{img1} overlays @pyret{img2}.
  }
  @repl-examples[
    `(@{overlay(rectangle(30, 60, "solid", "orange"),
          ellipse(60, 30, "solid", "purple"))}
      ,(overlay (rectangle 30 60 "solid" "orange") (ellipse 60 30 "solid" "purple")))
  ]
  @function[
    "overlay-align"
            #:contract (a-arrow XPlace YPlace Image Image Image)
            #:return Image
            #:args (list '("place-x" "") 
                         '("place-y" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Overlays @pyret{img1} on @pyret{img2} like 
    @secref[(tag-name "image" "overlay")], but uses @pyret{place-x} and
    @pyret{place-y} to determine where the images should line up.
  }

  @function[
    "overlay-onto-offset"
            #:contract (a-arrow Image XPlace YPlace N N XPlace YPlace Image Image Image)
            #:return Image
            #:args (list '("img1" "")
                         '("place-x1" "") 
                         '("place-y1" "") 
                         '("offset-x" "") 
                         '("offset-y" "") 
                         '("place-x2" "") 
                         '("place-y2" "") 
                         '("img2" ""))]{
    Overlays @pyret{img1} on @pyret{img2} like 
    @secref[(tag-name "image" "overlay")], but uses @pyret{place-x1} and
    @pyret{place-y1} to choose the reference point for the first
    image, @pyret{place-x2} and @pyret{place-y2} to choose the
    reference point for the second image, and slides the second
    image's reference point down and to the right by @pyret{offset-x}
    and @pyret{offset-y}.
  }
  @function[
    "overlay-xy"
            #:contract (a-arrow Image N N Image Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("dx" "") 
                         '("dy" "") 
                         '("img2" ""))]{
    Overlays @pyret{img1} on @pyret{img2} like 
    @secref[(tag-name "image" "overlay")], but initially lines up the two
    images upper-left corners and then shifts @pyret{img2} to the right
    by @pyret{dx} pixels, and then down by @pyret{dy} pixels.
  }
  @repl-examples[
    `(@{overlay-xy(0, 0,
          square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
      ,(overlay/xy (square 30 "solid" "bisque") 0 0 (square 50 "solid" "darkgreen")))
    `(@{overlay-xy(30, 20, # Move green square right 30 and down 20
          square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
      ,(overlay/xy (square 30 "solid" "bisque") 30 20 (square 50 "solid" "darkgreen")))
    `(@{overlay-xy(-10, -20, # Move green square left 10 and up 20
          square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
      ,(overlay/xy (square 30 "solid" "bisque") -10 -20 (square 50 "solid" "darkgreen")))
  ]
  @function[
    "underlay"
            #:contract (a-arrow Image Image Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("img2" ""))]{
    Constructs a new image by placing @pyret{img1} under @pyret{img2}.
    This is the reverse of @secref[(tag-name "image" "overlay")].
  }
  @repl-examples[
    `(@{underlay(rectangle(30, 60, "solid", "orange"),
          ellipse(60, 30, "solid", "purple"))}
      ,(underlay (rectangle 30 60 "solid" "orange") (ellipse 60 30 "solid" "purple")))
  ]
  @function[
    "underlay-align"
            #:contract (a-arrow XPlace YPlace Image Image Image)
            #:return Image
            #:args (list '("place-x" "") 
                         '("place-y" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Underlays @pyret{img1} beneath @pyret{img2} like 
    @secref[(tag-name "image" "underlay")], but uses @pyret{place-x} and
    @pyret{place-y} to determine where the images should line up.  This is the
    reverse of @secref[(tag-name "image" "overlay-align")].
  }
  @repl-examples[
   `(@{underlay-align("left", "top",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'left 'top (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("center", "top",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'center 'top (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("middle", "top",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'middle 'top (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("right", "top",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'right 'top (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("left", "top",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'left 'top (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("left", "middle",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'left 'middle (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("left", "center",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'left 'center (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("left", "bottom",
         square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
     ,(underlay/align 'left 'bottom (square 50 "solid" "bisque") (square 30 "solid" "darkgreen")))
   `(@{underlay-align("left", "baseline",
         rectangle(140, 3, "solid", "bisque"), text("Pyret", 50, "dark-green"))}
     ,(underlay/align 'left 'baseline (rectangle 140 3 "solid" "bisque")
                     (text/font "Pyret" 50 "darkgreen" "DejaVu Serif" 'roman 'normal 'normal #f)))
   `(@{underlay-align("left", "bottom",
         rectangle(140, 3, "solid", "bisque"), text("Pyret", 50, "dark-green"))}
     ,(underlay/align 'left 'bottom (rectangle 140 3 "solid" "bisque")
                     (text/font "Pyret" 50 "darkgreen" "DejaVu Serif" 'roman 'normal 'normal #f)))
  ]
  @function[
    "underlay-xy"
            #:contract (a-arrow Image N N Image Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("dx" "") 
                         '("dy" "") 
                         '("img2" ""))]{
    Underlays @pyret{img1} beneath @pyret{img2} like 
    @secref[(tag-name "image" "underlay")], but initially lines up the two
    images upper-left corners and then shifts @pyret{img2} to the right
    by @pyret{x} pixels, and then down by @pyret{y} pixels.  This is the
    reverse of @secref[(tag-name "image" "overlay-xy")].
  }
  @repl-examples[
    `(@{underlay-xy(0, 0,
          square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
      ,(underlay/xy (square 50 "solid" "bisque") 0 0 (square 30 "solid" "darkgreen")))
    `(@{underlay-xy(50, 20, # Move green square right 50 and down 20
          square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
      ,(underlay/xy (square 50 "solid" "bisque") 50 20 (square 30 "solid" "darkgreen")))
    `(@{underlay-xy(-10, -20, # Move green square left 10 and up 20
          square(50, "solid", "bisque"), square(30, "solid", "dark-green"))}
      ,(underlay/xy (square 50 "solid" "bisque") -10 -20 (square 30 "solid" "darkgreen")))
  ]
  @function[
    "beside"
            #:contract (a-arrow Image Image Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("img2" ""))]{
    Constructs an image by placing @pyret{img1} to the left of
    @pyret{img2}.
  }
  @repl-examples[
    `(@{beside(rectangle(30, 60, "solid", "orange"),
          ellipse(60, 30, "solid", "purple"))}
      ,(beside (rectangle 30 60 "solid" "orange") (ellipse 60 30 "solid" "purple")))
  ]
  @function[
    "beside-align"
            #:contract (a-arrow YPlace Image Image Image)
            #:return Image
            #:args (list '("place-y" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Constructs an image by placing @pyret{img1} to the left of
    @pyret{img2}, and aligning the two images as indicated by
    @pyret{place-y}.
  }
  @repl-examples[
   `(@{beside-align("top",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(beside/align 'top (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{beside-align("middle",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(beside/align 'middle (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{beside-align("center",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(beside/align 'center (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{beside-align("bottom",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(beside/align 'bottom (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{beside-align("baseline",
         text("Hello", 30, "dark-green"), text(" Pyret", 18, "lawn-green"))}
     ,(beside/align 'baseline
                     (text/font "Hello" 30 "darkgreen" "DejaVu Serif" 'roman 'normal 'normal #f)
                     (text/font " Pyret" 18 "lawngreen" "DejaVu Serif" 'roman 'normal 'normal #f)))
  ]
  @function[
    "above"
            #:contract (a-arrow Image Image Image)
            #:return Image
            #:args (list '("img1" "") '("img2" ""))]{
    Constructs an image by placing @pyret{img1} above @pyret{img2}.
  }
  @repl-examples[
    `(@{above(rectangle(30, 60, "solid", "orange"),
          ellipse(60, 30, "solid", "purple"))}
      ,(above (rectangle 30 60 "solid" "orange") (ellipse 60 30 "solid" "purple")))
  ]
  @function[
    "above-align"
            #:contract (a-arrow XPlace Image Image Image)
            #:return Image
            #:args (list '("place-x" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Constructs an image by placing @pyret{img1} above @pyret{img2},
    and aligning the two images as indicated by @pyret{place-x}.
  }
  @repl-examples[
   `(@{above-align("left",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(above/align 'left (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{above-align("center",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(above/align 'center (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{above-align("middle",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(above/align 'middle (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{above-align("right",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(above/align 'right (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
  ]

  @subsection{Data types for aligning images}

  
  @type-spec["XPlace" (list) #:private #t]{
    @|XPlace|s describe a landmark to align an image along the x-axis.

    @type-versions[
                   
     (list @bold{The @pyret{image} library}

           @nested{@|XPlace|s can be one of a fixed set of
                           @pyret-id["String" "<global>"]s}

           @nested{@pyret{"left"}}
           
           @nested{@pyret{"center"} or @pyret{"middle"} (these are synonyms)} 

           @nested{@pyret{"pinhole"}}

           @nested{@pyret{"right"}})

     
     (list @bold{The @pyret{image-typed} library}

           @nested{@|XPlace|s are an enumerated data definition:
                         
           @data-spec2["XPlace" (list) #:no-toc #t
                        (list
                         (singleton-spec2 "XPlace" "x-left")
                         (singleton-spec2 "XPlace" "x-middle")
                         (singleton-spec2 "XPlace" "x-pinhole")
                         (singleton-spec2 "XPlace" "x-right"))]}

           @nested{@singleton-doc["XPlace" "x-left" XPlace #:style ""]{
                 Shape should be aligned along its left edge.}}

           @nested{@singleton-doc["XPlace" "x-middle" XPlace #:style ""]{}
                   @value["x-center" XPlace #:style ""]{
                 Shape should be aligned at its horizontal midpoint.  For
                 convenience, you can also write @pyret-id{x-center}
                 as a synonym.}}

           @nested{@singleton-doc["XPlace" "x-pinhole" XPlace #:style ""]{
                 Shape should be aligned by its @seclink["pinholes"]{pinhole}.}}

           @nested{@singleton-doc["XPlace" "x-right" XPlace #:style ""]{
                 Shape should be aligned along its right edge.}})]

    }

  @repl-examples[
   `(@{overlay-align("left", "top",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'left 'top (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{overlay-align("center", "top",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'center 'top (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{overlay-align("middle", "top",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'middle 'top (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{overlay-align("right", "top",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'right 'top (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
  ]
  
  @type-spec["YPlace" (list) #:private #t]{
    @|YPlace|s describe a landmark to align an image along the y-axis.

    @type-versions[
                   
     (list @bold{The @pyret{image} library}

           @nested{@|YPlace|s can be one of a fixed set of
                           @pyret-id["String" "<global>"]s}

           @nested{@pyret{"top"}}
           
           @nested{@pyret{"middle"} or @pyret{"center"} (these are synonyms)} 

           @nested{@pyret{"pinhole"}}

           @nested{@pyret{"baseline"}}

           @nested{@pyret{"bottom"}})

     
     (list @bold{The @pyret{image-typed} library}

           @nested{@|YPlace|s are an enumerated data definition:
                         
           @data-spec2["YPlace" (list) #:no-toc #t
                        (list
                         (singleton-spec2 "YPlace" "y-top")
                         (singleton-spec2 "YPlace" "y-center")
                         (singleton-spec2 "YPlace" "y-pinhole")
                         (singleton-spec2 "YPlace" "y-baseline")
                         (singleton-spec2 "YPlace" "y-bottom"))]}

           @nested{@singleton-doc["YPlace" "y-top" YPlace #:style ""]{
                 Shape should be aligned along its top edge.}}

           @nested{@singleton-doc["YPlace" "y-center" YPlace #:style ""]{}
                   @value["y-middle" YPlace #:style ""]{
                 Shape should be aligned at its vertical midpoint.  For
                 convenience, you can also write @pyret-id{y-middle}
                 as a synonym.}}

           @nested{@singleton-doc["YPlace" "y-pinhole" YPlace #:style ""]{
                 Shape should be aligned by its @seclink["pinholes"]{pinhole}.}}

           @nested{@singleton-doc["YPlace" "y-baseline" YPlace #:style ""]{
                 Shape should be aligned by its basline. This option only makes sense with
                 @seclink["text-images"]{text images}. It allows
                 aligning multiple images of text at their baseline, as if they
                 were part of a single image, or to appear to underline text.
                 For all other images, their baseline is the same as
                 their bottom.
                 }}

           @nested{@singleton-doc["YPlace" "y-bottom" YPlace #:style ""]{
                 Shape should be aligned along its bottom edge.}})]

    }
  @repl-examples[
   `(@{overlay-align("left", "top",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'left 'top (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{overlay-align("left", "middle",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'left 'middle (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{overlay-align("left", "center",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'left 'center (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{overlay-align("left", "bottom",
         square(30, "solid", "bisque"), square(50, "solid", "dark-green"))}
     ,(overlay/align 'left 'bottom (square 30 "solid" "bisque") (square 50 "solid" "darkgreen")))
   `(@{overlay-align("left", "baseline",
         rectangle(140, 3, "solid", "bisque"), text("Pyret", 50, "dark-green"))}
     ,(overlay/align 'left 'baseline (rectangle 140 3 "solid" "bisque")
                     (text/font "Pyret" 50 "darkgreen" "DejaVu Serif" 'roman 'normal 'normal #f)))
   `(@{overlay-align("left", "bottom",
         rectangle(140, 3, "solid", "bisque"), text("Pyret", 50, "dark-green"))}
     ,(overlay/align 'left 'bottom (rectangle 140 3 "solid" "bisque")
                     (text/font "Pyret" 50 "darkgreen" "DejaVu Serif" 'roman 'normal 'normal #f)))
  ]

  
  @section{Placing Images & Scenes}
  @function[
    "empty-scene"
            #:contract (a-arrow N N Image)
            #:return Image
            #:args (list '("width" "") 
                         '("height" ""))]{
    Construct an empty scene of given width and height.  The background is transparent,
    and a black frame is drawn around the outside of the scene.
  }
  @repl-examples[
   `(@{empty-scene(30, 40)} ,(empty-scene 30 40))
  ]
  @function[
    "empty-color-scene"
            #:contract (a-arrow N N ImageColor Image)
            #:return Image
            #:args (list '("width" "") 
                         '("height" "")
                         '("color" ""))]{
    Construct an empty scene of given width and height.  The background is the given color,
    and a black frame is drawn around the outside of the scene.
  }
  @repl-examples[
   `(@{empty-color-scene(30, 40, "red")} ,(empty-scene 30 40 'red))
  ]
  @value["empty-image" Image]{
    An empty image of zero size.  Equivalent to @pyret{empty-scene(0, 0)}.
  }
  @repl-examples[
   `(@{empty-image # Not much to see here!} ,empty-image)
  ]  
  @function[
    "put-image"
            #:contract (a-arrow Image N N Image Image)
            #:return Image
            #:args (list '("picture" "") 
                         '("x" "") 
                         '("y" "") 
                         '("background" ""))]{
    Places the image @pyret{img} on the scene @pyret{background} so that
    its center is located at the coordinates (x,y), cropping the resulting
    image as necessary to maintain the size of @pyret{background}. The
    coordinates are relative to the @emph{bottom-left} of
    @pyret{background} (i.e., Quadrant I of the Cartesian plane).
  }
  @repl-examples[
   `(@{put-image(
         circle(10, "solid", "red"),
         10, 20,
         empty-scene(80, 50))}
     ,(place-image (circle 10 "solid" "red") 10 (- 50 20) (empty-scene 80 50)))
   `(@{put-image(
         circle(10, "solid", "red"),
         80, 50,
         empty-scene(80, 50))}
     ,(place-image (circle 10 "solid" "red") 80 (- 50 50) (empty-scene 80 50)))
  ]
  @function[
    "place-image"
            #:contract (a-arrow Image N N Image Image)
            #:return Image
            #:args (list '("img" "") 
                         '("x" "") 
                         '("y" "") 
                         '("background" ""))]{
    Places the image @pyret{img} on the scene @pyret{background} so that
    its center is located at the coordinates (x,y), cropping the resulting
    image as necessary to maintain the size of @pyret{background}. The
    coordinates are relative to the @emph{top-left} of
    @pyret{background} (i.e. standard screen coordinates).
  }
  @repl-examples[
   `(@{place-image(
         circle(10, "solid", "red"),
         10, 20,
         empty-scene(80, 50))}
     ,(place-image (circle 10 "solid" "red") 10 20 (empty-scene 80 50)))
   `(@{place-image(
         circle(10, "solid", "red"),
         80, 50,
         empty-scene(80, 50))}
     ,(place-image (circle 10 "solid" "red") 80 50 (empty-scene 80 50)))
  ]
  @function[
    "place-image-align"
            #:contract (a-arrow Image N N XPlace YPlace Image Image)
            #:return Image
            #:args (list '("img" "") 
                         '("x" "") 
                         '("y" "") 
                         '("place-x" "") 
                         '("place-y" "") 
                         '("background" ""))]{
    Behaves similar to @secref[(tag-name "image" "place-image")], but uses
    @pyret{place-x} and @pyret{place-y} to determine where to anchor
    @pyret{img}, instead of always using the center.
  }
  @repl-examples[
   `(@{place-image-align(
         star(15, "solid", "red"),
         80, 50, "center", "center"
         empty-scene(80, 50))}
     ,(place-image/align (star 15 "solid" "red") 80 50 'center 'center (empty-scene 80 50)))
   `(@{place-image-align(
         star(15, "solid", "red"),
         80, 50, "right", "bottom",
         empty-scene(80, 50))}
     ,(place-image/align (star 15 "solid" "red") 80 50 'right 'bottom (empty-scene 80 50)))
  ]
  @function[
    "scene-line"
            #:contract (a-arrow Image N N N N Image)
            #:return Image
            #:args (list '("img" "") 
                         '("x1" "") 
                         '("y1" "") 
                         '("x2" "") 
                         '("y2" "") 
                         '("background" ""))]{
    Draws a line from (x1,y1) to (x2,y2) on the scene
    @pyret{background}. Unlike @secref[(tag-name "image" "add-line")],
    this function crops the resulting image to be the same size as
    @pyret{background}.
  }
  @repl-examples[
    `(@{scene-line(circle(20, "outline", "maroon"), 0, 40, 40, 0, "orange")}
      ,(scene+line (circle 20 "outline" "maroon") 0 40 40 0 "orange"))
    `(@{scene-line(rectangle(40, 40, "outline", "maroon"), -10, 50, 50, -10, "orange")}
      ,(scene+line (rectangle 40 40 "outline" "maroon") -10 50 50 -10 "orange"))
  ]
  @section{Rotating, Scaling, Flipping, Cropping and Framing Images}
  @function[
    "rotate"
            #:contract (a-arrow N Image Image)
            #:return Image
            #:args (list '("angle" "") 
                         '("img" ""))]{
    Rotates @pyret{img} counter-clockwise by @pyret{angle} degrees.
  }
  @repl-examples[
   `(@{rotate(40, ellipse(60, 20, "solid", "olive-drab"))}
     ,(rotate 45 (ellipse 60 20 "solid" "olivedrab")))
   `(@{rotate(5, square(50, "outline", "black"))}
     ,(rotate 5 (square 50 "outline" "black")))
   `(@{rotate(45,
         beside-align("center",
           rectangle(40, 20, "solid", "dark-sea-green"),
           rectangle(20, 100, "solid", "light-sea-green")))}
     ,(rotate 45
          (beside/align
           "center"
           (rectangle 40 20 "solid" "darkseagreen")
           (rectangle 20 100 "solid" "lightseagreen"))))
  ]
  @function[
    "scale"
            #:contract (a-arrow N Image Image)
            #:return Image
            #:args (list '("factor" "") 
                         '("img" ""))]{
    Scales @pyret{img} by @pyret{factor}.
  }
  @repl-examples[
   `(@{scale(2, ellipse(20, 30, "solid", "blue"))}
     ,(scale 2 (ellipse 20 30 "solid" "blue")))
   `(@{ellipse(40, 60, "solid", "blue")}
     ,(ellipse 40 60 "solid" "blue"))
  ]
  @function[
    "scale-xy"
            #:contract (a-arrow N N Image Image)
            #:return Image
            #:args (list '("x-factor" "") 
                         '("y-factor" "") 
                         '("img" ""))]{
    Scales by @pyret{x-factor} horizontally and by @pyret{y-factor}
    vertically.
  }
  @repl-examples[
   `(@{scale-xy(2, 3, circle(10, "solid", "blue"))}
     ,(scale/xy 2 3 (circle 10 "solid" "blue")))
   `(@{ellipse(40, 60, "solid", "blue")}
     ,(ellipse 40 60 "solid" "blue"))
  ]
  @function[
    "flip-horizontal"
            #:contract (a-arrow Image Image)
            #:return Image
            #:args (list '("img" ""))]{
    Flips @pyret{img} left to right.
  }
  @repl-examples[
   `(@{flip-horizontal(text("Hello", 40, "darkgreen"))}
     ,(flip-horizontal (freeze (text/font "Hello" 30 "darkgreen" "DejaVu Serif" 'roman 'normal 'normal #f))))
   `(@{beside(
         rotate(30, square(50, "solid", "red")),
         flip-horizontal(rotate(30, square(50, "solid", "blue"))))}
     ,(beside
       (rotate 30 (square 50 "solid" "red"))
       (flip-horizontal
        (rotate 30 (square 50 "solid" "blue")))))
  ]
  @function[
    "flip-vertical"
            #:contract (a-arrow Image Image)
            #:return Image
            #:args (list '("img" ""))]{
    Flips @pyret{img} top to bottom.
  }
  @repl-examples[
   `(@{flip-vertical(text("Hello", 40, "darkgreen"))}
     ,(flip-vertical (freeze (text/font "Hello" 30 "darkgreen" "DejaVu Serif" 'roman 'normal 'normal #f))))
   `(@{above(
         star(40, "solid", "fire-brick"),
         scale-xy(1, 1/2, (flip-vertical(star(40, "solid", "gray")))))}
     ,(above
       (star 40 "solid" "firebrick")
       (scale/xy 1 1/2 (flip-vertical (star 40 "solid" "gray")))))
  ]
  @function[
    "crop"
            #:contract (a-arrow N N N N Image Image)
            #:return Image
            #:args (list '("x" "") 
                         '("y" "") 
                         '("width" "") 
                         '("height" "") 
                         '("img" ""))]{
    Crops @pyret{img} to the rectangle with the upper left at the point
    (x,y) and with width @pyret{width} and height @pyret{height}.
  }
  @repl-examples[
   `(@{crop(0, 0, 40, 40, circle(40, "solid", "chocolate"))}
     ,(crop 0 0 40 40 (circle 40 "solid" "chocolate")))
   `(@{crop(40, 60, 40, 60, ellipse(80, 120, "solid", "dodger-blue"))}
     ,(crop 40 60 40 60 (ellipse 80 120 "solid" "dodgerblue")))
   `(@{above(
         beside(
           crop(40, 40, 40, 40, circle(40, "solid", "pale-violet-red")),
           crop(0, 40, 40, 40, circle(40, "solid", "light-coral"))),
         beside(
           crop(40, 0, 40, 40, circle(40, "solid", "light-coral")),
           crop(0, 0, 40, 40, circle(40, "solid", "pale-violet-red"))))}
     ,(above
       (beside (crop 40 40 40 40 (circle 40 "solid" "palevioletred"))
               (crop 0 40 40 40 (circle 40 "solid" "lightcoral")))
       (beside (crop 40 0 40 40 (circle 40 "solid" "lightcoral"))
               (crop 0 0 40 40 (circle 40 "solid" "palevioletred")))))
  ]
  @function[
    "frame"
            #:contract (a-arrow Image Image)
            #:return Image
            #:args (list '("img" ""))]{
    Construct an image similar to @pyret{img}, but with a black, single
    pixel frame draw around the bounding box of the image.
  }
  @repl-examples[
   `(@{frame(ellipse(40, 60, "solid", "gray"))}
     ,(frame (ellipse 40 60 "solid" "gray")))
   `(@{frame(beside(circle(20, "solid", "red"), circle(10, "solid", "blue")))}
     ,(frame (beside (circle 20 "solid" "red") (circle 10 "solid" "blue"))))
  ]
  @section{Bitmaps}
  @function[
    "image-url"
            #:contract (a-arrow S Image)
            #:return Image
            #:args (list '("url" ""))]{
    Loads the image specified by @pyret{url}.
  }
  @repl-examples[
    `(@{image-url("https://www.pyret.org/img/pyret-banner.png")}
      ,(html:image "https://www.pyret.org/img/pyret-banner.png"))
  ]
  @function[
    "bitmap-url"
            #:contract (a-arrow S Image)
            #:return Image
            #:args (list '("url" ""))]{
    Same as @secref[(tag-name "image" "image-url")]
  }
  @function[
    "color-at-position"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Color" (xref "color" "Color")))
            #:return Color
            #:args (list '("image" "") '("x" "") '("y" ""))]{
    Returns the color at the pixel given by @pyret{x} and @pyret{y}
    coordinates. The coordinates are 0-based, with 0, 0 in the top-left corner
    of the image.
  }
  @function[
    "image-to-color-list"
            #:contract (a-arrow Image (L-of Color))
            #:return (L-of Color)
            #:args (list '("image" ""))]{
    Returns a list of colors that correspond to the colors in the image,
    reading from left to right, top to bottom.
  }
  @repl-examples[
    `(@{image-to-color-list(rectangle(2, 2, "solid", "black"))}
      ,(list (pyret "[list:")
             (paint-swatch "black" "black") (pyret ", ")
             (paint-swatch "black" "black") (pyret ", ")
             (paint-swatch "black" "black") (pyret ", ")
             (paint-swatch "black" "black") (pyret "]")))
    `(@{image-to-color-list(above(
           beside(square(1, "solid", "red"), square(1, "solid", "blue")),
           beside(square(1, "solid", "green"), square(1, "solid", "yellow"))))}
      ,(list (pyret "[list:")
             (paint-swatch "red" "red") (pyret ", ")
             (paint-swatch "blue" "blue") (pyret ", ")
             (paint-swatch "green" "green") (pyret ", ")
             (paint-swatch "yellow" "yellow") (pyret "]")))
  ]
  @function[
    "color-list-to-image"
            #:contract (a-arrow (L-of ImageColor) N N N N Image)
            #:return Image
            #:args (list '("list" "") 
                         '("width" "") 
                         '("height" "") 
                         '("pinhole-x" "") 
                         '("pinhole-y" ""))]{
    Given a list of colors, creates an image with the given width
    @pyret{width} and height @pyret{height}.  The pinhole arguments
    specify where to place the @seclink["pinholes"]{pinhole} of the image.
  }
  @repl-examples[
   `(@{scale(20, color-list-to-image([list: "red", "blue", "green", "yellow"], 2, 2, 1, 1))}
     ,(scale 20 (color-list->bitmap '(red blue green yellow) 2 2)))
   `(@{scale(20, color-list-to-image([list: "red", "blue", "green", "yellow"], 4, 1, 1, 1))}
     ,(scale 20 (color-list->bitmap '(red blue green yellow) 4 1)))
  ]
  @function[
    "color-list-to-bitmap"
            #:contract (a-arrow (L-of Color) N N Image)
            #:return Image
            #:args (list '("list" "") 
                         '("width" "") 
                         '("height" ""))]{
    Same as @secref[(tag-name "image" "color-list-to-image")], but
    assumes the @seclink["pinholes"]{pinhole} is at the center of the image.
  }

  @section[#:tag "pinholes"]{Pinholes}

  When combining images with @pyret-id{overlay-align} or related
  functions, we need to specify which reference point in each image to
  bring into alignment.  Using the various @pyret-id{XPlace} and
  @pyret-id{YPlace} options, we can easily refer to the four corners,
  the four midpoints of the edges, or the center of the image.  But
  frequently, the "obvious" alignment point is not quite any of
  those.  Suppose we wanted to create a six-pointed star by overlaying
  two equilateral triangles:

  @repl-examples[
   `(@{overlay-align("middle", "center", triangle(50, "solid", "red"),
                     rotate(180, triangle(50, "solid", "blue")))}
     ,(overlay/align "middle" "middle" (triangle 50 "solid" "red")
                     (rotate 180 (triangle 50 "solid" "blue"))))
   ]

  Unfortunately, the @emph{center} of our triangles isn't the
  @emph{visual} center of our triangles, but instead is exactly half
  the triangles' heights.  To fix this, Pyret defines a notion of a
  @emph{pinhole}, which lets us specify one more point in our images,
  where we'd like to pin images together.  By default, Pyret's pinhole
  is either:
  @itemlist[
     @item{In the geometric center (half the width, half the height) of
           any polygon with an even number of sides, and}
     @item{In the @emph{visual} center of any polygon with an odd
           number of sides}
  ]

  If we use our pinholes to align these triangles, we get the more
  intuitive result:

  @repl-examples[
   `(@{overlay-align("pinhole", "pinhole", triangle(50, "solid", "red"),
                     rotate(180, triangle(50, "solid", "blue")))}
     ,(clear-pinhole
       (overlay/align "pinhole" "pinhole"
                      (put-pinhole 25 (* 25 (sqrt 3) 2/3) (triangle 50 "solid" "red"))
                      (rotate 180 (put-pinhole 25 (* 25 (sqrt 3) 2/3) (triangle 50 "solid" "blue"))))))
   ]

  When two images are overlaid, the pinhole of the resulting image is
  the pinhole of the second image.

  @function["move-pinhole"
            #:contract (a-arrow N N Image Image)
            #:return Image
            #:args '(("dx" "") ("dy" "") ("img" ""))]{
    Produces a new image just like the original, but where the pinhole
    has been offset down and to the right by @pyret{dx} and @pyret{dy}.
  }

  @function["place-pinhole"
            #:contract (a-arrow N N Image Image)
            #:return Image
            #:args '(("x" "") ("y" "") ("img" ""))]{
    Produces a new image just like the original, but where the pinhole
    has been placed at @pyret{x} and @pyret{y}, relative to the
    top-left corner of the image.
  }

  @function["center-pinhole"
            #:contract (a-arrow Image Image)
            #:return Image
            #:args '(("img" ""))]{
    Produces a new image just like the original, but where the pinhole
    has been placed at the geometric center of the image (exactly at
    half its width and half its height).
  }

  @function["draw-pinhole"
            #:contract (a-arrow Image Image)
            #:return Image
            #:args '(("img" ""))]{
    Produces a new image just like the original, but draws a small
    crosshatch at the location of the pinhole.  Useful for debugging
    where the pinholes of images currently are.
  }

  @repl-examples[
   `(@{draw-pinhole(triangle(50, "solid", "red"))}
     ,(draw-pinhole 0 (/ (- (* 25 (sqrt 3) 2/3) 43) 2) (triangle 50 "solid" "red")))
   `(@{draw-pinhole(center-pinhole(triangle(50, "solid", "tan")))}
     ,(draw-pinhole 0 0 (triangle 50 "solid" "tan")))
   ]

  This last one looks strange, but it is an optical illusion.
  Flipping the image vertically reveals that the pinhole really is centered:

  @repl-examples[
   `(@{beside(
         draw-pinhole(center-pinhole(triangle(50, "solid", "tan"))),
         draw-pinhole(rotate(180, center-pinhole(triangle(50, "solid" , "tan")))))}
     ,(beside (draw-pinhole 0 0 (triangle 50 "solid" "tan"))
              (draw-pinhole 0 0 (rotate 180 (triangle 50 "solid" "tan")))))
   ]
            
  
  @section{Image Properties}
  @function[
    "image-width"
            #:contract (a-arrow Image N)
            #:return N
            #:args (list '("img" ""))]{
    Returns the width of @pyret{img}.
  }
  @repl-examples[
   `(@{image-width(circle(30, "solid", "red"))} @,pyret{60})
   `(@{image-width(text("Pyret", 30, "green"))} @,pyret{82})
  ]
  @function[
    "image-height"
            #:contract (a-arrow Image N)
            #:return N
            #:args (list '("img" ""))]{
    Returns the height of @pyret{img}.
  }
  @repl-examples[
   `(@{image-height(rectangle(30, 40, "solid", "red"))} @,pyret{40})
   `(@{image-height(text("Pyret", 30, "green"))} @,pyret{36})
  ]
  @function[
    "image-baseline"
            #:contract (a-arrow Image N)
            #:return N
            #:args (list '("img" ""))]{
    Returns the distance from the top of @pyret{img} to its baseline. The
    baseline of an image is the place where the bottoms of letters line up,
    without counting the descender, such as the tails on "y", "g" or "j".
  }
  @repl-examples[
   `(@{image-baseline(rectangle(30, 40, "solid", "red"))} @,pyret{40})
   `(@{image-baseline(text("Pyret", 30, "green"))} @,pyret{30})
  ]
  @section{Image Predicates}
  @function[
    "is-image"
            #:contract (a-arrow A B)
            #:return B
            #:args (list '("maybe-image" ""))]{
    Checks if @pyret{maybe-image} is an image.
  }
  @function[
    "is-mode"
            #:contract (a-arrow A B)
            #:return B
            #:args (list '("maybe-mode" ""))]{
    Checks if @pyret{maybe-mode} is a mode.
  }
  @function[
    "is-image-color"
            #:contract (a-arrow A B)
            #:return B
            #:args (list '("maybe-color" ""))]{
    Checks if @pyret{maybe-color} can be used as a color. Strings, if
           names of colors (e.g. @pyret{"red"} or @pyret{"green"}) can
           also be used, if they exist in the color database.
           @bold{This function is only defined in the @pyret{image} library}
  }
  @function[
    "is-y-place"
            #:contract (a-arrow A B)
            #:return B
            #:args (list '("maybe-y-place" ""))]{
    Checks if @pyret{maybe-y-place} can be used as y-place in appropriate
    functions. Valid strings are @pyret{"top"}, @pyret{"bottom"},
    @pyret{"middle"}, @pyret{"center"}, @pyret{"baseline"} and
    @pyret{"pinhole"}. @bold{This function is only defined in the @pyret{image} library}

  }
  @function[
    "is-x-place"
            #:contract (a-arrow S B)
            #:return B
            #:args (list '("maybe-x-place" ""))]{
    Checks if @pyret{maybe-x-place} can be used as x-place in appropriate
    functions. Valid strings are @pyret{"left"}, @pyret{"right"},
    @pyret{"middle"}, @pyret{"center"} and @pyret{"pinhole"}.
    @bold{This function is only defined in the @pyret{image} library}
  }
  @function[
    "is-angle"
            #:contract (a-arrow N B)
            #:return B
            #:args (list '("maybe-angle" ""))]{
    Checks if @pyret{maybe-angle} is an angle, namely a real number. All
    angles in the library are in degrees.
  }
  @function[
    "is-side-count"
            #:contract (a-arrow A B)
            #:return B
            #:args (list '("side-count" ""))]{
    Checks if @pyret{maybe-side-count} is an integer greater than or equal
    to 3.
  }
  @function[
    "is-step-count"
            #:contract (a-arrow N B)
            #:return B
            #:args (list '("step-count" ""))]{
    Checks if @pyret{maybe-step-count} is an integer greater than or equal
    to 1.
  }
  @section{Image Equality}
  @function[
    "images-equal"
            #:contract (a-arrow Image Image B)
            #:return B
            #:args (list '("image1" "") 
                         '("image2" ""))]{
    Compares two images for equality.
  }
  @function[
    "images-difference"
            #:contract (a-arrow Image Image (E-of S N))
            #:return (E-of S N)
            #:args (list '("image1" "") 
                         '("image2" ""))]{

    Compares two images for approximate equality.  Returns @pyret-id["left"
    "either"] if they aren't the same size (and are thus incomparable).
    Returns @pyret-id["right" "either"] otherwise, with a number representing
    how far off they are.

    Numbers range from 0-255, where around 255 indicates completely different
    images, and numbers below 20 or so are very difficult to distinguish at a
    glance. Useful for testing against reference images (especially
    cross-browser).
  }
}
