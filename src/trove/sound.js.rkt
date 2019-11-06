#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
          (prefix-in html: "../../manual-html.rkt")
          2htdp/image
          scribble/manual)

@(append-gen-docs
'(module "sound"
  (path "build/phase1/trove/sound.js")
  (fun-spec (name "overlay") (arity 2))
  (fun-spec (name "overlay-xy") (arity 4))
  (data-spec (name "Image") (variants) (shared))
  (data-spec (name "Scene") (variants) (shared))
))

@docmodule["sound"]{

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
}