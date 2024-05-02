#lang scribble/base
@(require "../../scribble-api.rkt" scribble/core (prefix-in html: "../../manual-html.rkt"))

@(append-gen-docs
'(module
  "color"
  (path "src/arr/trove/color.arr")
  (data-spec (name "Color") (type-vars ()) (variants ("color")) (shared ()))
  
  (constr-spec
    (name "color")
    (members
      (("red"
        (type normal)
        (contract (a-id "Number" (xref "<global>" "Number"))))
      ("green"
        (type normal)
        (contract (a-id "Number" (xref "<global>" "Number"))))
      ("blue"
        (type normal)
        (contract (a-id "Number" (xref "<global>" "Number"))))
      ("alpha"
        (type normal)
        (contract (a-id "Number" (xref "<global>" "Number"))))))
    (with-members ()))
  (fun-spec
    (name "is-color")
    (arity 1)
    (params [list: ])
    (args ("val"))
    (return (a-id "Boolean" (xref "<global>" "Boolean")))
    (contract (a-arrow "Any" (a-id "Boolean" (xref "<global>" "Boolean"))))
    (doc "Checks whether the provided argument is in fact a color"))
  (unknown-item
    (name "orange")
    ;; ~color13(255, 165, 0, 1)
    )
  (unknown-item
    (name "red")
    ;; ~color13(255, 0, 0, 1)
    )
  (unknown-item
    (name "orange-red")
    ;; ~color13(255, 69, 0, 1)
    )
  (unknown-item
    (name "tomato")
    ;; ~color13(255, 99, 71, 1)
    )
  (unknown-item
    (name "dark-red")
    ;; ~color13(139, 0, 0, 1)
    )
  (unknown-item
    (name "fire-brick")
    ;; ~color13(178, 34, 34, 1)
    )
  (unknown-item
    (name "crimson")
    ;; ~color13(220, 20, 60, 1)
    )
  (unknown-item
    (name "deep-pink")
    ;; ~color13(255, 20, 147, 1)
    )
  (unknown-item
    (name "maroon")
    ;; ~color13(176, 48, 96, 1)
    )
  (unknown-item
    (name "indian-red")
    ;; ~color13(205, 92, 92, 1)
    )
  (unknown-item
    (name "medium-violet-red")
    ;; ~color13(199, 21, 133, 1)
    )
  (unknown-item
    (name "violet-red")
    ;; ~color13(208, 32, 144, 1)
    )
  (unknown-item
    (name "light-coral")
    ;; ~color13(240, 128, 128, 1)
    )
  (unknown-item
    (name "hot-pink")
    ;; ~color13(255, 105, 180, 1)
    )
  (unknown-item
    (name "pale-violet-red")
    ;; ~color13(219, 112, 147, 1)
    )
  (unknown-item
    (name "light-pink")
    ;; ~color13(255, 182, 193, 1)
    )
  (unknown-item
    (name "rosy-brown")
    ;; ~color13(188, 143, 143, 1)
    )
  (unknown-item
    (name "pink")
    ;; ~color13(255, 192, 203, 1)
    )
  (unknown-item
    (name "orchid")
    ;; ~color13(218, 112, 214, 1)
    )
  (unknown-item
    (name "lavender-blush")
    ;; ~color13(255, 240, 245, 1)
    )
  (unknown-item
    (name "snow")
    ;; ~color13(255, 250, 250, 1)
    )
  (unknown-item
    (name "chocolate")
    ;; ~color13(210, 105, 30, 1)
    )
  (unknown-item
    (name "saddle-brown")
    ;; ~color13(139, 69, 19, 1)
    )
  (unknown-item
    (name "brown")
    ;; ~color13(132, 60, 36, 1)
    )
  (unknown-item
    (name "dark-orange")
    ;; ~color13(255, 140, 0, 1)
    )
  (unknown-item
    (name "coral")
    ;; ~color13(255, 127, 80, 1)
    )
  (unknown-item
    (name "sienna")
    ;; ~color13(160, 82, 45, 1)
    )
  (unknown-item
    (name "salmon")
    ;; ~color13(250, 128, 114, 1)
    )
  (unknown-item
    (name "peru")
    ;; ~color13(205, 133, 63, 1)
    )
  (unknown-item
    (name "dark-goldenrod")
    ;; ~color13(184, 134, 11, 1)
    )
  (unknown-item
    (name "goldenrod")
    ;; ~color13(218, 165, 32, 1)
    )
  (unknown-item
    (name "sandy-brown")
    ;; ~color13(244, 164, 96, 1)
    )
  (unknown-item
    (name "light-salmon")
    ;; ~color13(255, 160, 122, 1)
    )
  (unknown-item
    (name "dark-salmon")
    ;; ~color13(233, 150, 122, 1)
    )
  (unknown-item
    (name "gold")
    ;; ~color13(255, 215, 0, 1)
    )
  (unknown-item
    (name "yellow")
    ;; ~color13(255, 255, 0, 1)
    )
  (unknown-item
    (name "olive")
    ;; ~color13(128, 128, 0, 1)
    )
  (unknown-item
    (name "burlywood")
    ;; ~color13(222, 184, 135, 1)
    )
  (unknown-item
    (name "tan")
    ;; ~color13(210, 180, 140, 1)
    )
  (unknown-item
    (name "navajo-white")
    ;; ~color13(255, 222, 173, 1)
    )
  (unknown-item
    (name "peach-puff")
    ;; ~color13(255, 218, 185, 1)
    )
  (unknown-item
    (name "khaki")
    ;; ~color13(240, 230, 140, 1)
    )
  (unknown-item
    (name "dark-khaki")
    ;; ~color13(189, 183, 107, 1)
    )
  (unknown-item
    (name "moccasin")
    ;; ~color13(255, 228, 181, 1)
    )
  (unknown-item
    (name "wheat")
    ;; ~color13(245, 222, 179, 1)
    )
  (unknown-item
    (name "bisque")
    ;; ~color13(255, 228, 196, 1)
    )
  (unknown-item
    (name "pale-goldenrod")
    ;; ~color13(238, 232, 170, 1)
    )
  (unknown-item
    (name "blanched-almond")
    ;; ~color13(255, 235, 205, 1)
    )
  (unknown-item
    (name "medium-goldenrod")
    ;; ~color13(234, 234, 173, 1)
    )
  (unknown-item
    (name "papaya-whip")
    ;; ~color13(255, 239, 213, 1)
    )
  (unknown-item
    (name "misty-rose")
    ;; ~color13(255, 228, 225, 1)
    )
  (unknown-item
    (name "lemon-chiffon")
    ;; ~color13(255, 250, 205, 1)
    )
  (unknown-item
    (name "antique-white")
    ;; ~color13(250, 235, 215, 1)
    )
  (unknown-item
    (name "cornsilk")
    ;; ~color13(255, 248, 220, 1)
    )
  (unknown-item
    (name "light-goldenrod-yellow")
    ;; ~color13(250, 250, 210, 1)
    )
  (unknown-item
    (name "old-lace")
    ;; ~color13(253, 245, 230, 1)
    )
  (unknown-item
    (name "linen")
    ;; ~color13(250, 240, 230, 1)
    )
  (unknown-item
    (name "light-yellow")
    ;; ~color13(255, 255, 224, 1)
    )
  (unknown-item
    (name "seashell")
    ;; ~color13(255, 245, 238, 1)
    )
  (unknown-item
    (name "beige")
    ;; ~color13(245, 245, 220, 1)
    )
  (unknown-item
    (name "floral-white")
    ;; ~color13(255, 250, 240, 1)
    )
  (unknown-item
    (name "ivory")
    ;; ~color13(255, 255, 240, 1)
    )
  (unknown-item
    (name "green")
    ;; ~color13(0, 255, 0, 1)
    )
  (unknown-item
    (name "lawn-green")
    ;; ~color13(124, 252, 0, 1)
    )
  (unknown-item
    (name "chartreuse")
    ;; ~color13(127, 255, 0, 1)
    )
  (unknown-item
    (name "green-yellow")
    ;; ~color13(173, 255, 47, 1)
    )
  (unknown-item
    (name "yellow-green")
    ;; ~color13(154, 205, 50, 1)
    )
  (unknown-item
    (name "medium-forest-green")
    ;; ~color13(107, 142, 35, 1)
    )
  (unknown-item
    (name "olive-drab")
    ;; ~color13(107, 142, 35, 1)
    )
  (unknown-item
    (name "dark-olive-green")
    ;; ~color13(85, 107, 47, 1)
    )
  (unknown-item
    (name "dark-sea-green")
    ;; ~color13(143, 188, 139, 1)
    )
  (unknown-item
    (name "lime")
    ;; ~color13(0, 255, 0, 1)
    )
  (unknown-item
    (name "dark-green")
    ;; ~color13(0, 100, 0, 1)
    )
  (unknown-item
    (name "lime-green")
    ;; ~color13(50, 205, 50, 1)
    )
  (unknown-item
    (name "forest-green")
    ;; ~color13(34, 139, 34, 1)
    )
  (unknown-item
    (name "spring-green")
    ;; ~color13(0, 255, 127, 1)
    )
  (unknown-item
    (name "medium-spring-green")
    ;; ~color13(0, 250, 154, 1)
    )
  (unknown-item
    (name "sea-green")
    ;; ~color13(46, 139, 87, 1)
    )
  (unknown-item
    (name "medium-sea-green")
    ;; ~color13(60, 179, 113, 1)
    )
  (unknown-item
    (name "aquamarine")
    ;; ~color13(112, 216, 144, 1)
    )
  (unknown-item
    (name "light-green")
    ;; ~color13(144, 238, 144, 1)
    )
  (unknown-item
    (name "pale-green")
    ;; ~color13(152, 251, 152, 1)
    )
  (unknown-item
    (name "medium-aquamarine")
    ;; ~color13(102, 205, 170, 1)
    )
  (unknown-item
    (name "turquoise")
    ;; ~color13(64, 224, 208, 1)
    )
  (unknown-item
    (name "light-sea-green")
    ;; ~color13(32, 178, 170, 1)
    )
  (unknown-item
    (name "medium-turquoise")
    ;; ~color13(72, 209, 204, 1)
    )
  (unknown-item
    (name "honeydew")
    ;; ~color13(240, 255, 240, 1)
    )
  (unknown-item
    (name "mint-cream")
    ;; ~color13(245, 255, 250, 1)
    )
  (unknown-item
    (name "royal-blue")
    ;; ~color13(65, 105, 225, 1)
    )
  (unknown-item
    (name "dodger-blue")
    ;; ~color13(30, 144, 255, 1)
    )
  (unknown-item
    (name "deep-sky-blue")
    ;; ~color13(0, 191, 255, 1)
    )
  (unknown-item
    (name "cornflower-blue")
    ;; ~color13(100, 149, 237, 1)
    )
  (unknown-item
    (name "steel-blue")
    ;; ~color13(70, 130, 180, 1)
    )
  (unknown-item
    (name "light-sky-blue")
    ;; ~color13(135, 206, 250, 1)
    )
  (unknown-item
    (name "dark-turquoise")
    ;; ~color13(0, 206, 209, 1)
    )
  (unknown-item
    (name "cyan")
    ;; ~color13(0, 255, 255, 1)
    )
  (unknown-item
    (name "aqua")
    ;; ~color13(0, 255, 255, 1)
    )
  (unknown-item
    (name "dark-cyan")
    ;; ~color13(0, 139, 139, 1)
    )
  (unknown-item
    (name "teal")
    ;; ~color13(0, 128, 128, 1)
    )
  (unknown-item
    (name "sky-blue")
    ;; ~color13(135, 206, 235, 1)
    )
  (unknown-item
    (name "cadet-blue")
    ;; ~color13(95, 158, 160, 1)
    )
  (unknown-item
    (name "dark-slate-gray")
    ;; ~color13(47, 79, 79, 1)
    )
  (unknown-item
    (name "dark-slate-grey")
    ;; ~color13(47, 79, 79, 1)
    )
  (unknown-item
    (name "light-slate-gray")
    ;; ~color13(119, 136, 153, 1)
    )
  (unknown-item
    (name "light-slate-grey")
    ;; ~color13(119, 136, 153, 1)
    )
  (unknown-item
    (name "slate-gray")
    ;; ~color13(112, 128, 144, 1)
    )
  (unknown-item
    (name "slate-grey")
    ;; ~color13(112, 128, 144, 1)
    )
  (unknown-item
    (name "light-steel-blue")
    ;; ~color13(176, 196, 222, 1)
    )
  (unknown-item
    (name "light-blue")
    ;; ~color13(173, 216, 230, 1)
    )
  (unknown-item
    (name "powder-blue")
    ;; ~color13(176, 224, 230, 1)
    )
  (unknown-item
    (name "pale-turquoise")
    ;; ~color13(175, 238, 238, 1)
    )
  (unknown-item
    (name "light-cyan")
    ;; ~color13(224, 255, 255, 1)
    )
  (unknown-item
    (name "alice-blue")
    ;; ~color13(240, 248, 255, 1)
    )
  (unknown-item
    (name "azure")
    ;; ~color13(240, 255, 255, 1)
    )
  (unknown-item
    (name "medium-blue")
    ;; ~color13(0, 0, 205, 1)
    )
  (unknown-item
    (name "dark-blue")
    ;; ~color13(0, 0, 139, 1)
    )
  (unknown-item
    (name "midnight-blue")
    ;; ~color13(25, 25, 112, 1)
    )
  (unknown-item
    (name "navy")
    ;; ~color13(36, 36, 140, 1)
    )
  (unknown-item
    (name "blue")
    ;; ~color13(0, 0, 255, 1)
    )
  (unknown-item
    (name "indigo")
    ;; ~color13(75, 0, 130, 1)
    )
  (unknown-item
    (name "blue-violet")
    ;; ~color13(138, 43, 226, 1)
    )
  (unknown-item
    (name "medium-slate-blue")
    ;; ~color13(123, 104, 238, 1)
    )
  (unknown-item
    (name "slate-blue")
    ;; ~color13(106, 90, 205, 1)
    )
  (unknown-item
    (name "purple")
    ;; ~color13(160, 32, 240, 1)
    )
  (unknown-item
    (name "dark-slate-blue")
    ;; ~color13(72, 61, 139, 1)
    )
  (unknown-item
    (name "dark-violet")
    ;; ~color13(148, 0, 211, 1)
    )
  (unknown-item
    (name "dark-orchid")
    ;; ~color13(153, 50, 204, 1)
    )
  (unknown-item
    (name "medium-purple")
    ;; ~color13(147, 112, 219, 1)
    )
  (unknown-item
    (name "medium-orchid")
    ;; ~color13(186, 85, 211, 1)
    )
  (unknown-item
    (name "magenta")
    ;; ~color13(255, 0, 255, 1)
    )
  (unknown-item
    (name "fuchsia")
    ;; ~color13(255, 0, 255, 1)
    )
  (unknown-item
    (name "dark-magenta")
    ;; ~color13(139, 0, 139, 1)
    )
  (unknown-item
    (name "violet")
    ;; ~color13(238, 130, 238, 1)
    )
  (unknown-item
    (name "plum")
    ;; ~color13(221, 160, 221, 1)
    )
  (unknown-item
    (name "lavender")
    ;; ~color13(230, 230, 250, 1)
    )
  (unknown-item
    (name "thistle")
    ;; ~color13(216, 191, 216, 1)
    )
  (unknown-item
    (name "ghost-white")
    ;; ~color13(248, 248, 255, 1)
    )
  (unknown-item
    (name "white")
    ;; ~color13(255, 255, 255, 1)
    )
  (unknown-item
    (name "white-smoke")
    ;; ~color13(245, 245, 245, 1)
    )
  (unknown-item
    (name "gainsboro")
    ;; ~color13(220, 220, 220, 1)
    )
  (unknown-item
    (name "light-gray")
    ;; ~color13(211, 211, 211, 1)
    )
  (unknown-item
    (name "light-grey")
    ;; ~color13(211, 211, 211, 1)
    )
  (unknown-item
    (name "silver")
    ;; ~color13(192, 192, 192, 1)
    )
  (unknown-item
    (name "gray")
    ;; ~color13(190, 190, 190, 1)
    )
  (unknown-item
    (name "grey")
    ;; ~color13(190, 190, 190, 1)
    )
  (unknown-item
    (name "dark-gray")
    ;; ~color13(169, 169, 169, 1)
    )
  (unknown-item
    (name "dark-grey")
    ;; ~color13(169, 169, 169, 1)
    )
  (unknown-item
    (name "dim-gray")
    ;; ~color13(105, 105, 105, 1)
    )
  (unknown-item
    (name "dim-grey")
    ;; ~color13(105, 105, 105, 1)
    )
  (unknown-item
    (name "black")
    ;; ~color13(0, 0, 0, 1)
    )
  (unknown-item
    (name "rebecca-purple")
    ;; ~color13(102, 51, 153, 1)
    )
  (unknown-item
    (name "transparent")
    ;; ~color13(0, 0, 0, 1)
    )))

@(define (paint-swatch color css-color)
   (list (html:span 'style: "font-size: initial;"
                    (html:image 'class: "paintBrush" "path://brush.svg")
                    (html:span 'class: "paintSpan"
                               (html:span 'class: "checkersBlob")
                               (html:span 'class: "paintBlob"
                                          'style: (format "background-color: ~a; margin-right: 0.25em;" css-color))))
         (pyret color)))
@(define (render-color name r g b a)
   (ignore (list name))
   (item (paint-swatch name (format "rgba(~a,~a,~a,~a)" r g b a)) ": "
         (make-element (make-style "relax" (list (make-color-property (list r g b)))) "abc123") " "
         (make-element (make-style "relax" (list (make-background-color-property (list r g b)))) "abc123")))
@(define number (a-id "Number" (xref "<global>" "Number")))
@(define color-args (list
      `("red"   ("type" "normal") ("contract" ,number))
      `("green" ("type" "normal") ("contract" ,number))
      `("blue"  ("type" "normal") ("contract" ,number))
      `("alpha" ("type" "normal") ("contract" ,number))))

@docmodule["color"]{
  @; Ignored type testers
  @ignore[(list "is-color")]
  @emph{@bold{Note:}} it is discouraged to use the @pyret{include} form of importing this library,
  since this library defines many names, some of which will likely conflict with existing names.
  (For instance, @pyret{tan} is both a color and a mathematical function.)  Use the @pyret{import}
  form instead. See @secref["s:modules:import"] for more detail.
  
  @section[#:tag "color_DataTypes"]{Data types}
  @data-spec2["Color" (list) (list
    @constructor-spec["Color" "color" color-args]
  )]
  @nested[#:style 'inset]{
    @constructor-doc["Color" "color" color-args (a-id "Color" (xref "color" "Color"))]{
      The values for red, green, and blue should be in the range 0--255, inclusive.
      The values for alpha should be in the range 0--1, and indicates how transparent the color is, with 0 as fully transparent and 1 as fully opaque.

      Note that the library does not @emph{enforce} these range restrictions when constructing custom colors, so that you can manipulate colors arithmetically (e.g. modeling ``additive color'' by literally adding components together).  The @emph{rendering} of these colors will clamp the values into those ranges, so e.g. @pyret{color(500, 255, 0, 1)} will look the same as @pyret{yellow} itself, but the values will not be equal.
    }
  }

  @section[#:tag "s:color-constants"]{Predefined colors}
  The following colors are predefined constants:
  @itemlist[
    @render-color["orange" 255 165 0 1]
    @render-color["red" 255 0 0 1]
    @render-color["orange-red" 255 69 0 1]
    @render-color["tomato" 255 99 71 1]
    @render-color["dark-red" 139 0 0 1]
    @render-color["fire-brick" 178 34 34 1]
    @render-color["crimson" 220 20 60 1]
    @render-color["deep-pink" 255 20 147 1]
    @render-color["maroon" 176 48 96 1]
    @render-color["indian-red" 205 92 92 1]
    @render-color["medium-violet-red" 199 21 133 1]
    @render-color["violet-red" 208 32 144 1]
    @render-color["light-coral" 240 128 128 1]
    @render-color["hot-pink" 255 105 180 1]
    @render-color["pale-violet-red" 219 112 147 1]
    @render-color["light-pink" 255 182 193 1]
    @render-color["rosy-brown" 188 143 143 1]
    @render-color["pink" 255 192 203 1]
    @render-color["orchid" 218 112 214 1]
    @render-color["lavender-blush" 255 240 245 1]
    @render-color["snow" 255 250 250 1]
    @render-color["chocolate" 210 105 30 1]
    @render-color["saddle-brown" 139 69 19 1]
    @render-color["brown" 132 60 36 1]
    @render-color["dark-orange" 255 140 0 1]
    @render-color["coral" 255 127 80 1]
    @render-color["sienna" 160 82 45 1]
    @render-color["salmon" 250 128 114 1]
    @render-color["peru" 205 133 63 1]
    @render-color["dark-goldenrod" 184 134 11 1]
    @render-color["goldenrod" 218 165 32 1]
    @render-color["sandy-brown" 244 164 96 1]
    @render-color["light-salmon" 255 160 122 1]
    @render-color["dark-salmon" 233 150 122 1]
    @render-color["gold" 255 215 0 1]
    @render-color["yellow" 255 255 0 1]
    @render-color["olive" 128 128 0 1]
    @render-color["burlywood" 222 184 135 1]
    @render-color["tan" 210 180 140 1]
    @render-color["navajo-white" 255 222 173 1]
    @render-color["peach-puff" 255 218 185 1]
    @render-color["khaki" 240 230 140 1]
    @render-color["dark-khaki" 189 183 107 1]
    @render-color["moccasin" 255 228 181 1]
    @render-color["wheat" 245 222 179 1]
    @render-color["bisque" 255 228 196 1]
    @render-color["pale-goldenrod" 238 232 170 1]
    @render-color["blanched-almond" 255 235 205 1]
    @render-color["medium-goldenrod" 234 234 173 1]
    @render-color["papaya-whip" 255 239 213 1]
    @render-color["misty-rose" 255 228 225 1]
    @render-color["lemon-chiffon" 255 250 205 1]
    @render-color["antique-white" 250 235 215 1]
    @render-color["cornsilk" 255 248 220 1]
    @render-color["light-goldenrod-yellow" 250 250 210 1]
    @render-color["old-lace" 253 245 230 1]
    @render-color["linen" 250 240 230 1]
    @render-color["light-yellow" 255 255 224 1]
    @render-color["seashell" 255 245 238 1]
    @render-color["beige" 245 245 220 1]
    @render-color["floral-white" 255 250 240 1]
    @render-color["ivory" 255 255 240 1]
    @render-color["green" 0 255 0 1]
    @render-color["lawn-green" 124 252 0 1]
    @render-color["chartreuse" 127 255 0 1]
    @render-color["green-yellow" 173 255 47 1]
    @render-color["yellow-green" 154 205 50 1]
    @render-color["medium-forest-green" 107 142 35 1]
    @render-color["olive-drab" 107 142 35 1]
    @render-color["dark-olive-green" 85 107 47 1]
    @render-color["dark-sea-green" 143 188 139 1]
    @render-color["lime" 0 255 0 1]
    @render-color["dark-green" 0 100 0 1]
    @render-color["lime-green" 50 205 50 1]
    @render-color["forest-green" 34 139 34 1]
    @render-color["spring-green" 0 255 127 1]
    @render-color["medium-spring-green" 0 250 154 1]
    @render-color["sea-green" 46 139 87 1]
    @render-color["medium-sea-green" 60 179 113 1]
    @render-color["aquamarine" 112 216 144 1]
    @render-color["light-green" 144 238 144 1]
    @render-color["pale-green" 152 251 152 1]
    @render-color["medium-aquamarine" 102 205 170 1]
    @render-color["turquoise" 64 224 208 1]
    @render-color["light-sea-green" 32 178 170 1]
    @render-color["medium-turquoise" 72 209 204 1]
    @render-color["honeydew" 240 255 240 1]
    @render-color["mint-cream" 245 255 250 1]
    @render-color["royal-blue" 65 105 225 1]
    @render-color["dodger-blue" 30 144 255 1]
    @render-color["deep-sky-blue" 0 191 255 1]
    @render-color["cornflower-blue" 100 149 237 1]
    @render-color["steel-blue" 70 130 180 1]
    @render-color["light-sky-blue" 135 206 250 1]
    @render-color["dark-turquoise" 0 206 209 1]
    @render-color["cyan" 0 255 255 1]
    @render-color["aqua" 0 255 255 1]
    @render-color["dark-cyan" 0 139 139 1]
    @render-color["teal" 0 128 128 1]
    @render-color["sky-blue" 135 206 235 1]
    @render-color["cadet-blue" 95 158 160 1]
    @render-color["dark-slate-gray" 47 79 79 1]
    @render-color["dark-slate-grey" 47 79 79 1]
    @render-color["light-slate-gray" 119 136 153 1]
    @render-color["light-slate-grey" 119 136 153 1]
    @render-color["slate-gray" 112 128 144 1]
    @render-color["slate-grey" 112 128 144 1]
    @render-color["light-steel-blue" 176 196 222 1]
    @render-color["light-blue" 173 216 230 1]
    @render-color["powder-blue" 176 224 230 1]
    @render-color["pale-turquoise" 175 238 238 1]
    @render-color["light-cyan" 224 255 255 1]
    @render-color["alice-blue" 240 248 255 1]
    @render-color["azure" 240 255 255 1]
    @render-color["medium-blue" 0 0 205 1]
    @render-color["dark-blue" 0 0 139 1]
    @render-color["midnight-blue" 25 25 112 1]
    @render-color["navy" 36 36 140 1]
    @render-color["blue" 0 0 255 1]
    @render-color["indigo" 75 0 130 1]
    @render-color["blue-violet" 138 43 226 1]
    @render-color["medium-slate-blue" 123 104 238 1]
    @render-color["slate-blue" 106 90 205 1]
    @render-color["purple" 160 32 240 1]
    @render-color["dark-slate-blue" 72 61 139 1]
    @render-color["dark-violet" 148 0 211 1]
    @render-color["dark-orchid" 153 50 204 1]
    @render-color["medium-purple" 147 112 219 1]
    @render-color["medium-orchid" 186 85 211 1]
    @render-color["magenta" 255 0 255 1]
    @render-color["fuchsia" 255 0 255 1]
    @render-color["dark-magenta" 139 0 139 1]
    @render-color["violet" 238 130 238 1]
    @render-color["plum" 221 160 221 1]
    @render-color["lavender" 230 230 250 1]
    @render-color["rebecca-purple" 102 51 153 1]
    @render-color["thistle" 216 191 216 1]
    @render-color["ghost-white" 248 248 255 1]
    @render-color["white" 255 255 255 1]
    @render-color["white-smoke" 245 245 245 1]
    @render-color["gainsboro" 220 220 220 1]
    @render-color["light-gray" 211 211 211 1]
    @render-color["light-grey" 211 211 211 1]
    @render-color["silver" 192 192 192 1]
    @render-color["gray" 190 190 190 1]
    @render-color["grey" 190 190 190 1]
    @render-color["dark-gray" 169 169 169 1]
    @render-color["dark-grey" 169 169 169 1]
    @render-color["dim-gray" 105 105 105 1]
    @render-color["dim-grey" 105 105 105 1]
    @render-color["black" 0 0 0 1]
    @render-color["transparent" 0 0 0 0]
  ]
}
