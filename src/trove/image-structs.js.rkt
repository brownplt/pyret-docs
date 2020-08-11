#lang scribble/base
@(require "../../scribble-api.rkt"
          "../abbrevs.rkt"
          (prefix-in html: "../../manual-html.rkt")
          2htdp/image
          scribble/manual)

@(append-gen-docs
  `(module "image-structs"
    (path "src/arr/trove/image-structs.arr")))

@docmodule["image-structs"]{
@bold{@emph{This library is deprecated.}}

It used to contain the definitions for @pyret-id["Color" "color"],
which you can now find by importing the @seclink{color} module
instead.

To maintain backward compatibility, this library still provides those
definitions, but your program should update to using the
@seclink{color} library.

}
