#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
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
  (fun-spec (name "empty-scene") (arity 2))
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
  @function[
    "line"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("x" "") 
                         '("y" "") 
                         '("color" ""))]{
    Draws an image of a line that connects the point (0,0) to the point
    (x,y).
  }
  @function[
    "add-line"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image                                  
            #:args (list '("img" "") 
                         '("x1" "") 
                         '("y1" "") 
                         '("x2" "") 
                         '("y2" "") 
                         '("color" ""))]{
    Creates a new image like @pyret["img"] with a line added starting from
    the point (x1,y1)
    and going to the point (x2,y2). Unlike @pyret-id["scene-line"],
    if the line passes outside of @pyret["img"], the image gets larger to
    accommodate the line.
  }

  @section{Text}

  @function[
    "text"
            #:contract (a-arrow S N ImageColor Image)
            #:return Image                                  
            #:args (list '("string" "") 
                         '("font-size" "") 
                         '("color" ""))]{
    Constructs an image of @pyret["string"], using the given font size
    and color.
  }
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
    side will be of length @pyret["side-length"].
  }
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
    @pyret["side-length1"] and @pyret["side-length2"].
  }
  @function[
    "isosceles-triangle"
            #:contract (a-arrow N N Mode ImageColor Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle with two equal-length sides, of
    length @pyret["side-length"] where the angle between those two sides is
    @pyret["angle-c"]. if the angle is less than @pyret["180"], then the triangle
    will point up; otherwise, the triangle will point down.
  }
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
  @function[
    "triangle-ass"
            #:contract (a-arrow N N N Mode ImageColor Image)
            #:return Image
            #:args (list '("angle-a" "") '("side-b" "") '("side-c" "") '("mode" "") '("color" ""))]{
    Constructs an image of a triangle using the given angle and two sides.
  }
  @function[
    "triangle-sas"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("side-a" "") 
                         '("angle-b" "") 
                         '("side-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the given angle and two sides.
  }
  @function[
    "triangle-ssa"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("side-a" "") 
                         '("side-b" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the given angle and two sides.
  }
  @function[
    "triangle-aas"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("angle-a" "") 
                         '("angle-b" "") 
                         '("side-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the two given angles and
    side.
  }
  @function[
    "triangle-asa"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("angle-a" "") 
                         '("side-b" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the two given angles and
    side.
  }
  @function[
    "triangle-saa"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("side-a" "") 
                         '("angle-b" "") 
                         '("angle-c" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a triangle using the two given angles and
    sides.
  }
  @function[
    "square"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a square with the given side length, mode and color.
  }
  @function[
    "rectangle"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("width" "") 
                         '("height" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a rectangle with the given side width, height,
    mode and color.
  }
  @function[
    "rhombus"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("angle" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs a four-sided polygon whose sides are of length
    @pyret["side-length"] and thus has angles equal to their opposites. The
    top and bottom pair of angles is @pyret["angle"] and the left and right
    pair is @pyret["180 - angle"].
  }
  @function[
    "star"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs a five-pointed star with sides of length @pyret["side-length"],
    and with the given mode and color.
  }
  @function[
    "radial-star"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("point-count" "") '("outer" "") '("inner" "") '("mode" "") '("color" ""))]{
    Constructs a star with @pyret["point-count"] points. The outer points will
    lie a distance of @pyret["outer"] from the center of the star, while the
    inner points will lie a distance of @pyret["inner"] from the center.
  }
  @function[
    "star-sized"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
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
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("side-length" "") 
                         '("point-count" "") 
                         '("step" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of an arbitrary regular star polygon. The polygon
    is enclosed by a regular polygon with @pyret["side-count"] sides each
    @pyret["side-length"] long. The polygon is actually constructed by going
    from vertex to vertex around the regular polygon, but connecting every
    @pyret["step-count"]-th vertex (i.e., skipping every 
    @pyret["step-count - 1"] vertices).
  }
  @function[
    "regular-polygon"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "String" (xref "<global>" "String"))
                                (a-id "Color"  (xref "image-structs" "Color"))
                                Image)
            #:return Image
            #:args (list '("length" "") 
                         '("count" "") 
                         '("mode" "") 
                         '("color" ""))]{
    Constructs an image of a regular polygon with @pyret["side-count"] sides.
  }
  @section{Overlaying Images}

  @function[
    "overlay"
            #:contract (a-arrow Image
                                Image
                                Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("img2" ""))]{
    Constructs a new image where @pyret["img1"] overlays @pyret["img2"]. 
  }
  @function[
    "overlay-align"
            #:contract (a-arrow XPlace
                                YPlace
                                Image
                                Image
                                Image)
            #:return Image
            #:args (list '("place-x" "") 
                         '("place-y" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Overlays @pyret["img1"] on @pyret["img2"] like 
    @secref[(tag-name "image" "overlay")], but uses @pyret["place-x"] and
    @pyret["place-y"] to determine where the images should line up.
  }
  @type-spec["XPlace" (list)]{

    A @pyret-id["String" "<global>"] that represents a place to align an image
    on the x-axis.  One of
    @pyret{"left"}, 
    @pyret{"center"}, 
    @pyret{"middle"}, or
    @pyret{"right"}.
    }
  @type-spec["YPlace" (list)]{

    A @pyret-id["String" "<global>"] that represents a place to align an image
    on the y-axis.  One of
    @pyret{"top"}, 
    @pyret{"bottom"}, 
    @pyret{"baseline"},
    @pyret{"center"}, or
    @pyret{"middle"}.
    }
  @function[
    "overlay-xy"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                Image
                                Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("dx" "") 
                         '("dy" "") 
                         '("img2" ""))]{
    Overlays @pyret["img1"] on @pyret["img2"] like 
    @secref[(tag-name "image" "overlay")], but initially lines up the two
    images upper-left corners and then shifts @pyret["img2"] to the right
    by @pyret["dx"] pixels, and then down by @pyret["dy"] pixels.
  }
  @function[
    "underlay"
            #:contract (a-arrow Image
                                Image
                                Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("img2" ""))]{
    Constructs a new image by placing @pyret["img1"] under @pyret["img2"].
  }
  @function[
    "underlay-align"
            #:contract (a-arrow XPlace
                                YPlace
                                Image
                                Image
                                Image)
            #:return Image
            #:args (list '("place-x" "") 
                         '("place-y" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Underlays @pyret["img1"] beneath @pyret["img2"] like 
    @secref[(tag-name "image" "underlay")], but uses @pyret["place-x"] and
    @pyret["place-y"] to determine where the images should line up.
  }
  @function[
    "underlay-xy"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                Image
                                Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("dx" "") 
                         '("dy" "") 
                         '("img2" ""))]{
    Underlays @pyret["img1"] beneath @pyret["img2"] like 
    @secref[(tag-name "image" "underlay")], but initially lines up the two
    images upper-left corners and then shifts @pyret["img2"] to the right
    by @pyret["x"] pixels, and then down by @pyret["y"] pixels.
  }
  @function[
    "beside"
            #:contract (a-arrow Image
                                Image
                                Image)
            #:return Image
            #:args (list '("img1" "") 
                         '("img2" ""))]{
    Constructs an image by placing @pyret["img1"] to the left of
    @pyret["img2"].
  }
  @function[
    "beside-align"
            #:contract (a-arrow YPlace
                                Image
                                Image
                                Image)
            #:return Image
            #:args (list '("place-y" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Constructs an image by placing @pyret["img1"] to the left of
    @pyret["img2"], and aligning the two images as indicated by
    @pyret["place-y"].
  }
  @function[
    "above"
            #:contract (a-arrow Image
                                Image
                                Image)
            #:return Image
            #:args (list '("img1" "") '("img2" ""))]{
    Constructs an image by placing @pyret["img1"] above @pyret["img2"].
  }
  @function[
    "above-align"
            #:contract (a-arrow XPlace
                                Image
                                Image
                                Image)
            #:return Image
            #:args (list '("place-x" "") 
                         '("img1" "") 
                         '("img2" ""))]{
    Constructs an image by placing @pyret["img1"] above @pyret["img2"],
    and aligning the two images as indicated by @pyret["place-x"].
  }
  @section{Placing Images & Scenes}
  @function[
    "empty-scene"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Scene" (xref "image" "Scene")))
            #:return Scene
            #:args (list '("width" "") 
                         '("height" ""))]{
    Construct an empty scene of given width and height.
  }
  @function[
    "put-image"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Scene"  (xref "image" "Scene"))
                                (a-id "Scene"  (xref "image" "Scene")))
            #:return Image
            #:args (list '("picture" "") 
                         '("x" "") 
                         '("y" "") 
                         '("background" ""))]{
    Places the image @pyret["img"] on the scene @pyret["background"] so that
    its center is located at the coordinates (x,y), cropping the resulting
    image as necessary to maintain the size of @pyret["background"]. The
    coordinates are relative to the bottom-left of @pyret["background"].
  }
  @function[
    "place-image"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Scene"  (xref "image" "Scene"))
                                (a-id "Scene"  (xref "image" "Scene")))
            #:return Image
            #:args (list '("img" "") 
                         '("x" "") 
                         '("y" "") 
                         '("background" ""))]{
    Places the image @pyret["img"] on the scene @pyret["background"] so that
    its center is located at the coordinates (x,y), cropping the resulting
    image as necessary to maintain the size of @pyret["background"]. The
    coordinates are relative to the top-left of @pyret["background"].
  }
  @function[
    "place-image-align"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                XPlace
                                YPlace
                                (a-id "Scene"  (xref "image" "Scene"))
                                (a-id "Scene"  (xref "image" "Scene")))
            #:return Image
            #:args (list '("img" "") 
                         '("x" "") 
                         '("y" "") 
                         '("place-x" "") 
                         '("place-y" "") 
                         '("background" ""))]{
    Functions like @secref[(tag-name "image" "place-image")], but uses
    @pyret["place-x"] and @pyret["place-y"] to determine where to anchor
    @pyret["img"], instead of using the center.
  }
  @function[
    "scene-line"
            #:contract (a-arrow (a-id "Scene"  (xref "image" "Scene"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Scene"  (xref "image" "Scene")))
            #:return Scene
            #:args (list '("img" "") 
                         '("x1" "") 
                         '("y1" "") 
                         '("x2" "") 
                         '("y2" "") 
                         '("background" ""))]{
    Draws a line from (x1,y1) to (x2,y2) on the scene
    @pyret["background"]. Unlike @secref[(tag-name "image" "add-line")],
    this function crops the resulting image to be the same size as
    @pyret["background"].
  }
  @section{Rotating, Scaling, Flipping, Cropping and Framing Images}
  @function[
    "rotate"
            #:contract (a-arrow (a-id "Number"  (xref "<global>" "Number"))
                                Image
                                Image)
            #:return Image
            #:args (list '("angle" "") 
                         '("img" ""))]{
    Rotates @pyret["img"] counter-clockwise by @pyret["angle"] degrees.
  }
  @function[
    "scale"
            #:contract (a-arrow (a-id "Number"  (xref "<global>" "Number"))
                                Image
                                Image)
            #:return Image
            #:args (list '("factor" "") 
                         '("img" ""))]{
    Scales @pyret["img"] by @pyret["factor"].
  }
  @function[
    "scale-xy"
            #:contract (a-arrow (a-id "Number"  (xref "<global>" "Number"))
                                (a-id "Number"  (xref "<global>" "Number"))
                                Image
                                Image)
            #:return Image
            #:args (list '("x-factor" "") 
                         '("y-factor" "") 
                         '("img" ""))]{
    Scales by @pyret["x-factor"] horizontally and by @pyret["y-factor"]
    vertically.
  }
  @function[
    "flip-horizontal"
            #:contract (a-arrow Image
                                Image)
            #:return Image
            #:args (list '("img" ""))]{
    Flips @pyret["img"] left to right.
  }
  @function[
    "flip-vertical"
            #:contract (a-arrow Image
                                Image)
            #:return Image
            #:args (list '("img" ""))]{
    Flips @pyret["img"] top to bottom.
  }
  @function[
    "crop"
            #:contract (a-arrow (a-id "Number"  (xref "<global>" "Number"))
                                (a-id "Number"  (xref "<global>" "Number"))
                                (a-id "Number"  (xref "<global>" "Number"))
                                (a-id "Number"  (xref "<global>" "Number"))
                                Image
                                Image)
            #:return Image
            #:args (list '("x" "") 
                         '("y" "") 
                         '("width" "") 
                         '("height" "") 
                         '("img" ""))]{
    Crops @pyret["img"] to the rectangle with the upper left at the point
    (x,y) and with width @pyret["width"] and height @pyret["height"].
  }
  @function[
    "frame"
            #:contract (a-arrow Image
                                Image)
            #:return Image
            #:args (list '("img" ""))]{
    Construct an image similar to @pyret["img"], but with a black, single
    pixel frame draw around the bounding box of the image.
  }
  @section{Bitmaps}
  @function[
    "open-image-url"
            #:contract (a-arrow (a-id "String" (xref "<global>" "String"))
                                Image)
            #:return Image
            #:args (list '("url" ""))]{
    Loads the image specified by @pyret["url"].
  }
  @function[
    "image-url"
            #:contract (a-arrow (a-id "String" (xref "<global>" "String"))
                                Image)
            #:return Image
            #:args (list '("url" ""))]{
    Loads the image specified by @pyret["url"].
  }
  @function[
    "bitmap-url"
            #:contract (a-arrow (a-id "String" (xref "<global>" "String"))
                                Image)
            #:return Image
            #:args (list '("url" ""))]{
    Loads the image specified by @pyret["url"].
  }
  @function[
    "image-to-color-list"
            #:contract (a-arrow Image
                                (a-app (a-id "List" (xref "lists" "List"))
                                       (a-id "Color" (xref "image-structs" "Color"))))
            #:return (L-of Color)
            #:args (list '("image" ""))]{
    Returns a list of colors that correspond to the colors in the image,
    reading from left to right, top to bottom.
  }
  @function[
    "color-list-to-image"
            #:contract (a-arrow (a-app (a-id "List" (xref "lists" "List"))
                                       (a-id "Color" (xref "image-structs" "Color")))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                Image)
            #:return Image
            #:args (list '("list" "") 
                         '("width" "") 
                         '("height" "") 
                         '("pinhole-x" "") 
                         '("pinhole-y" ""))]{
    Given a list of colors, creates an image with the given width
    @pyret["width"] and height @pyret["height"].
  }
  @function[
    "color-list-to-bitmap"
            #:contract (a-arrow (a-app (a-id "List" (xref "lists" "List"))
                                       (a-id "Color" (xref "image-structs" "Color")))
                                (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Number" (xref "<global>" "Number"))
                                Image)
            #:return Image
            #:args (list '("list" "") 
                         '("width" "") 
                         '("height" ""))]{
    Given a list of colors, creates an image with the given width
    @pyret["width"] and height @pyret["height"].
  }
  @section{Image Properties}
  @function[
    "image-width"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number")))
            #:return N
            #:args (list '("img" ""))]{
    Returns the width of @pyret["img"].
  }
  @function[
    "image-height"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number")))
            #:return N
            #:args (list '("img" ""))]{
    Returns the height of @pyret["img"].
  }
  @function[
    "image-baseline"
            #:contract (a-arrow Image
                                (a-id "Number" (xref "<global>" "Number")))
            #:return N
            #:args (list '("img" ""))]{
    Returns the distance from the top of @pyret["img"] to its baseline. The
    baseline of an image is the place where the bottoms of letters line up,
    without counting the descender, such as the tails on "y", "g" or "j".
  }
  @section{Image Predicates}
  @function[
    "is-image"
            #:contract (a-arrow "Any"
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("maybe-image" ""))]{
    Checks if @pyret["maybe-image"] is an image.
  }
  @function[
    "is-mode"
            #:contract (a-arrow "Any"
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("maybe-mode" ""))]{
    Checks if @pyret["maybe-mode"] is a mode.
  }
  @function[
    "is-image-color"
            #:contract (a-arrow "Any"
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("maybe-color" ""))]{
    Checks if @pyret["maybe-color"] can be used as a color. Strings, if names of colors (e.g. "red" or "green") can also be used, if they exist in the color database.
  }
  @function[
    "is-y-place"
            #:contract (a-arrow "Any"
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("maybe-y-place" ""))]{
    Checks if @pyret["maybe-y-place"] can be used as y-place in appropriate
    functions. Valid strings are @pyret["top"], @pyret["bottom"],
    @pyret["middle"], @pyret["center"], @pyret["baseline"] and
    @pyret["pinhole"].
  }
  @function[
    "is-x-place"
            #:contract (a-arrow (a-id "String" (xref "<global>" "String"))
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("maybe-x-place" ""))]{
    Checks if @pyret["maybe-x-place"] can be used as x-place in appropriate
    functions. Valid strings are @pyret["left"], @pyret["right"],
    @pyret["middle"], @pyret["center"] and @pyret["pinhole"].
  }
  @function[
    "is-angle"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("maybe-angle" ""))]{
    Checks if @pyret["maybe-angle"] is an angle, namely a real number. All
    angles in the library are in degrees.
  }
  @function[
    "is-side-count"
            #:contract (a-arrow "Any"
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("side-count" ""))]{
    Checks if @pyret["maybe-side-count"] is an integer greater than or equal
    to 3.
  }
  @function[
    "is-step-count"
            #:contract (a-arrow (a-id "Number" (xref "<global>" "Number"))
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("step-count" ""))]{
    Checks if @pyret["maybe-step-count"] is an integer greater than or equal
    to 1.
  }
  @section{Image Equality}
  @function[
    "images-equal"
            #:contract (a-arrow Image
                                Image
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return B
            #:args (list '("image1" "") 
                         '("image2" ""))]{
    Compares two images for equality.
  }
  @function[
    "images-difference"
            #:contract (a-arrow Image
                                Image
                                (a-id "Boolean" (xref "<global>" "Boolean")))
            #:return (E-of S N)
            #:args (list '("image1" "") 
                         '("image2" ""))]{

    Compares two images for approximate equality.  Returns @pyret-id["left"
    "either"] if they aren't the same size (and are this incomparable).
    Returns @pyret-id["right" "either"] otherwise, with a number representing
    how far off they are.

    Numbers range from 0-255, where around 255 indicates completely different
    images, and numbers below 20 or so are very difficult to distinguish at a
    glance. Useful for testing against reference images (especially
    cross-browser).
  }
}
