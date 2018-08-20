#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
          (prefix-in html: "../../manual-html.rkt")
          2htdp/image
          scribble/manual)

@(append-gen-docs
'(module "image"
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
  (fun-spec (name "open-image-url") (arity 1))
  (fun-spec (name "image-url") (arity 1))
  (fun-spec (name "images-equal") (arity 2))
  (fun-spec (name "images-difference") (arity 2))
  (fun-spec (name "text") (arity 3))
  (fun-spec (name "text-font") (arity 8))
  (fun-spec (name "overlay") (arity 2))
  (fun-spec (name "overlay-xy") (arity 4))
  (fun-spec (name "overlay-align") (arity 4))
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
  (fun-spec (name "image-to-color-list") (arity 1))
  (fun-spec (name "color-list-to-image") (arity 1))
  (fun-spec (name "color-list-to-bitmap") (arity 1))
  (fun-spec (name "image-width") (arity 1))
  (fun-spec (name "image-height") (arity 1))
  (fun-spec (name "image-baseline") (arity 1))
  (fun-spec (name "name-to-color") (arity 1))
  (data-spec (name "Image") (variants) (shared))
  (data-spec (name "Scene") (variants) (shared))
  (data-spec (name "ImageColor") (variants) (shared))
  (data-spec (name "Mode") (variants) (shared))
  (data-spec (name "FontFamily") (variants) (shared))
  (data-spec (name "FontStyle") (variants) (shared))
  (data-spec (name "FontWeight") (variants) (shared))
  (data-spec (name "XPlace") (variants) (shared))
  (data-spec (name "YPlace") (variants) (shared))
))


@(define Image (a-id "Image" (xref "image" "Image")))
@(define Scene (a-id "Scene" (xref "image" "Scene")))
@(define ImageColor (a-id "ImageColor" (xref "image" "ImageColor")))
@(define Color (a-id "Color" (xref "image-structs" "Color")))
@(define Mode (a-id "Mode" (xref "image" "Mode")))
@(define FontFamily (a-id "FontFamily" (xref "image" "FontFamily")))
@(define FontStyle (a-id "FontStyle" (xref "image" "FontStyle")))
@(define FontWeight (a-id "FontWeight" (xref "image" "FontWeight")))
@(define XPlace (a-id "XPlace" (xref "image" "XPlace")))
@(define YPlace (a-id "YPlace" (xref "image" "YPlace")))
@(define (paint-swatch color css-color)
   (list (html:span 'style: "font-size: initial;"
                    (html:image 'class: "paintBrush" "https://code.pyret.org/img/brush.svg")
                    (html:span 'class: "paintSpan" 'style: "display: inline-block;"
                               (html:span 'class: "checkersBlob")
                               (html:span 'class: "paintBlob"
                                          'style: (format "background-color: ~a; margin-right: 0.25em;" css-color))))
         (pyret color)))

@docmodule["image"]{

  The functions in this module are used for creating, combining, and displaying
  images.

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

  @section[#:tag "image_DataTypes"]{Data Types}
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

    An @tt{ImageColor} is either a string from the list in
    @secref["s:color-constants"], or a @pyret-id["Color" "image-structs"],
    which you can use to construct colors other than the predefined ones,
    including making colors partially transparent by controlling their opacity.
    }
  @function[
    "name-to-color"
            #:contract (a-arrow S Color)
            #:return Color
            #:args (list '("name" ""))]

  Looks up the given string in the list of predefined colors.

  @repl-examples[
    `(@{name-to-color("red")} ,(paint-swatch "red" "red"))
    `(@{name-to-color("blue")} ,(paint-swatch "blue" "blue"))
    `(@{name-to-color("transparent")} ,(paint-swatch "transparent" "rgba(0,0,0,0)"))
  ]

  @type-spec["Mode" (list)]{

    A @pyret-id["String" "<global>"] that describes a style for a shape.  Either the string
    @pyret{"outline"} or the string @pyret{"solid"}.
    }

  @section{Basic Images}
  @function[
    "circle"
            #:contract (a-arrow N Mode ImageColor Image)
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
            #:contract (a-arrow N N Mode ImageColor Image)
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
  @type-spec["FontFamily" (list)]{

    A @pyret-id["String" "<global>"] that describes a family of fonts.  The
    following strings are options:

    @itemlist[
      @item{@pyret{"default"}}
      @item{@pyret{"decorative"}}
      @item{@pyret{"roman"}}
      @item{@pyret{"script"}}
      @item{@pyret{"swiss"}}
      @item{@pyret{"modern"}}
      @item{@pyret{"symbol"}}
      @item{@pyret{"system"}}
    ]
    }
  @type-spec["FontStyle" (list)]{

    A @pyret-id["String" "<global>"] that describes the style of a font.  One
    of @pyret{"normal"}, @pyret{"italic"}, or @pyret{"slant"}.
    }
  @type-spec["FontWeight" (list)]{

    A @pyret-id["String" "<global>"] that describes the weight of a font.  One
    of @pyret{"normal"}, @pyret{"bold"}, or @pyret{"light"}.
    }
  @section{Polygons}
  @function[
    "triangle"
            #:contract (a-arrow N Mode ImageColor Image)
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
            #:contract (a-arrow N N Mode ImageColor Image)
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
            #:contract (a-arrow N N Mode ImageColor Image)
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
            #:contract (a-arrow N N N Mode ImageColor Image)
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
            #:contract (a-arrow N N N Mode ImageColor Image)
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
  @type-spec["XPlace" (list)]{

    A @pyret-id["String" "<global>"] that represents a place to align an image
    on the x-axis.  One of
    @pyret{"left"}, 
    @pyret{"center"}, 
    @pyret{"middle"}, or
    @pyret{"right"}.  The options @pyret{"center"} and @pyret{"middle"} are synonyms.
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
  @type-spec["YPlace" (list)]{

    A @pyret-id["String" "<global>"] that represents a place to align an image
    on the y-axis.  One of
    @pyret{"top"}, 
    @pyret{"bottom"}, 
    @pyret{"baseline"},
    @pyret{"center"}, or
    @pyret{"middle"}.  The options @pyret{"center"} and @pyret{"middle"} are synonyms.

    The @pyret{"baseline"} option only makes sense with
    @seclink["text-images"]{text images}. It allows
    aligning multiple images of text at their baseline, as if they
    were part of a single image, or to appear to underline text.
    For all other images, their @pyret{"baseline"} is the same as
    their @pyret{"bottom"}.
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
             @(paint-swatch "black" "black") (pyret ", ")
             @(paint-swatch "black" "black") (pyret ", ")
             @(paint-swatch "black" "black") (pyret ", ")
             @(paint-swatch "black" "black") (pyret "]")))
    `(@{image-to-color-list(above(
           beside(square(1, "solid", "red"), square(1, "solid", "blue")),
           beside(square(1, "solid", "green"), square(1, "solid", "yellow"))))}
      ,(list (pyret "[list:")
             @(paint-swatch "red" "red") (pyret ", ")
             @(paint-swatch "blue" "blue") (pyret ", ")
             @(paint-swatch "green" "green") (pyret ", ")
             @(paint-swatch "yellow" "yellow") (pyret "]")))
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
    specify where to consider the ``center'' of the image.
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
    assumes the pinhole is at the center of the image.
  }
  @section{Image Properties}
  @function[
    "image-width"
            #:contract (a-arrow Image N)
            #:return N
            #:args (list '("img" ""))]{
    Returns the width of @pyret{img}.
  }
  @repl-examples[
   `(@{image-width(circle(30, "solid", "red"))} ,(pyret "60"))
   `(@{image-width(text("Pyret", 30, "green"))} ,(pyret "82"))
  ]
  @function[
    "image-height"
            #:contract (a-arrow Image N)
            #:return N
            #:args (list '("img" ""))]{
    Returns the height of @pyret{img}.
  }
  @repl-examples[
   `(@{image-height(rectangle(30, 40, "solid", "red"))} ,(pyret "40"))
   `(@{image-height(text("Pyret", 30, "green"))} ,(pyret "36"))
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
   `(@{image-baseline(rectangle(30, 40, "solid", "red"))} ,(pyret "40"))
   `(@{image-baseline(text("Pyret", 30, "green"))} ,(pyret "30"))
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
    Checks if @pyret{maybe-color} can be used as a color. Strings, if names of colors (e.g. @pyret{"red"} or @pyret{"green"}) can also be used, if they exist in the color database.
  }
  @function[
    "is-y-place"
            #:contract (a-arrow A B)
            #:return B
            #:args (list '("maybe-y-place" ""))]{
    Checks if @pyret{maybe-y-place} can be used as y-place in appropriate
    functions. Valid strings are @pyret{"top"}, @pyret{"bottom"},
    @pyret{"middle"}, @pyret{"center"}, @pyret{"baseline"} and
    @pyret{"pinhole"}.
  }
  @function[
    "is-x-place"
            #:contract (a-arrow S B)
            #:return B
            #:args (list '("maybe-x-place" ""))]{
    Checks if @pyret{maybe-x-place} can be used as x-place in appropriate
    functions. Valid strings are @pyret{"left"}, @pyret{"right"},
    @pyret{"middle"}, @pyret{"center"} and @pyret{"pinhole"}.
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
