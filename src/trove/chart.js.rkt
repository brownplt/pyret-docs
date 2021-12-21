#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")
@(require (only-in scribble/core delayed-block))

@(define (in-link T) (a-id T (xref "chart" T)))
@(define (in-image f) (image (string-append "src/trove/chart-images/" f ".png") #:scale 0.4))
@(define Self A)
@(define Color (a-id "Color" (xref "color" "Color")))
@(define Image (a-id "Image" (xref "image" "Image")))
@(define Option (a-id "Option" (xref "option" "Option")))
@(define DataSeries (in-link "DataSeries"))
@(define ChartWindow (in-link "ChartWindow"))
@(define opaque '(("<opaque>" ("type" "normal") ("contract" #f))))
@(define (method-data-series variant name)
  (method-doc "DataSeries" variant name))

@(define color-meth
  `(method-spec
    (name "color")
    (arity 2)
    (params ())
    (args ("self" "color"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,Color ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new " ,Color ". By default, "
          "the color will be auto-generated."))))

@(define bar-chart-colors-meth
  `(method-spec
    (name "colors")
    (arity 2)
    (params ())
    (args ("self" "colors"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of Color) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new " ,Color " for each relevant component. By default, "
          "the colors will be auto-generated. If the " ,(L-of Color) " contains less elements than "
          "the number of components then the rest will be colored the default color (Can be changed by 
          using the " ,(in-link "bar-chart-series") ". color method). If the " ,(L-of Color) " contains more elements than the number of components
          , only the number of components of colors will be used"))))

@(define multi-bar-chart-colors-meth
  `(method-spec
    (name "colors")
    (arity 2)
    (params ())
    (args ("self" "colors"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of Color) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new " ,Color " for each relevant component. By default, "
          "the colors will be auto-generated. If the " ,(L-of Color) " contains less elements than "
          "the number of components then the rest will be colored Black. If the " ,(L-of Color)
          " contains more elements than the number of components, only the number of components of colors will be used"))))
          
@(define bar-chart-sort-meth
  `(method-spec
    (name "sort")
    (arity 1)
    (params ())
    (args ("self"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,DataSeries))
    (doc ("Construct a new " ,DataSeries " where the components of the " ,(in-link "bar-chart-series") 
          " are sorted by height using a comparison operator of < (ascending order) and equality operator of ==. 
          See more details at " ,L "." ,(a-id "sort" (xref "lists" "sort")) "." ))))

@(define multi-bar-chart-sort-meth
  `(method-spec
    (name "sort")
    (arity 1)
    (params ())
    (args ("self"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,DataSeries))
    (doc ("Construct a new " ,DataSeries " where the components of the " ,(in-link "multi-bar-chart-series") 
          " are sorted by the sum of their heights using a comparison operator of < (ascending order) 
          and equality operator of ==. See more details at " ,L "." ,(a-id "sort" (xref "lists" "sort")) "." ))))

@(define bar-chart-sort-by-meth
  `(method-spec
    (name "sort-by")
    (arity 3)
    (params ())
    (args ("self" "cmp" "eq"))
    (return ,DataSeries)
    (contract (a-arrow ,Self (a-arrow ,N ,N ,B) (a-arrow ,N ,N ,B) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " where the components of the " ,(in-link "bar-chart-series") 
          " are sorted by height using custom comparison and equality operators. See more details at " 
          ,L "." ,(a-id "sort-by" (xref "lists" "sort-by")) "." ))))

@(define multi-bar-chart-sort-by-meth
  `(method-spec
    (name "sort-by")
    (arity 3)
    (params ())
    (args ("self" "cmp" "eq"))
    (return ,DataSeries)
    (contract (a-arrow ,Self (a-arrow ,N ,N ,B) (a-arrow ,N ,N ,B) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " where the components of the " ,(in-link "multi-bar-chart-series") 
          " are sorted by the sum of their heights using custom comparison and equality operators. 
          See more details at " ,L "." ,(a-id "sort-by" (xref "lists" "sort-by")) "." ))))

@(define bar-chart-sort-by-label-meth
  `(method-spec
    (name "sort-by-label")
    (arity 3)
    (params ())
    (args ("self" "cmp" "eq"))
    (return ,DataSeries)
    (contract (a-arrow ,Self (a-arrow ,S ,S ,B) (a-arrow ,S ,S ,B) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " where the components of the " ,(in-link "bar-chart-series") 
          " are sorted by labels using custom comparison and equality operators. See more details at " 
          ,L "." ,(a-id "sort-by" (xref "lists" "sort-by")) "." ))))

@(define multi-bar-chart-sort-by-label-meth
  `(method-spec
    (name "sort-by-label")
    (arity 3)
    (params ())
    (args ("self" "cmp" "eq"))
    (return ,DataSeries)
    (contract (a-arrow ,Self (a-arrow ,S ,S ,B) (a-arrow ,S ,S ,B) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " where the components of the " ,(in-link "multi-bar-chart-series") 
          " are sorted by labels using custom comparison and equality operators. 
          See more details at " ,L "." ,(a-id "sort-by" (xref "lists" "sort-by")) "." ))))

@(define multi-bar-chart-sort-by-data-meth
  `(method-spec
    (name "sort-by-data")
    (arity 4)
    (params ())
    (args ("self" "scorer" "cmp" "eq"))
    (return ,DataSeries)
    (contract (a-arrow ,Self (a-arrow ,(L-of N) "A") (a-arrow "A" "A" ,B) (a-arrow "A" "A" ,B) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " where  the components of the " ,(in-link "multi-bar-chart-series") 
          " are scored by the scorer and then sorted by their score using custom comparison and equality operators. 
          See more details at " ,L "." ,(a-id "sort-by" (xref "lists" "sort-by")) "." ))))

@(define pointer-meth
  `(method-spec
    (name "add-pointers")
    (arity 3)
    (params ())
    (args ("self" "ticks" "labels"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of N) ,(L-of S) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new pointers at certain ticks on the axis to highlight lines of interest"
          "Be sure to space out the pointers because one of the labels will disappear if they are too close. Also add-pointers
           currently does not work in conjunction with " ,(in-link "bar-chart-series") ".sort_by"))))

@(define pointer-color-meth
  `(method-spec
    (name "pointer-color")
    (arity 2)
    (params ())
    (args ("self" "color"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,Color ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new color for the pointers added by " ,(in-link "bar-chart-series") "."
          "add pointers."))))

@(define format-axis-meth
  `(method-spec
    (name "format-axis")
    (arity 2)
    (params ())
    (args ("self" "formatter"))
    (return ,DataSeries)
    (contract (a-arrow ,Self (a-arrow ,N ,S) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with new tick labels on the axis."))))

@(define scale-meth
  `(method-spec
    (name "scale")
    (arity 2)
    (params ())
    (args ("self" "scale-function"))
    (return ,DataSeries)
    (contract (a-arrow ,Self (a-arrow ,N ,N) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with all the data scaled by the scale-function"))))

@(define multi-bar-chart-stacking-meth
  `(method-spec
    (name "stacking-type")
    (arity 2)
    (params ())
    (args ("self" "stack-type"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,S ,DataSeries))
    (doc ("Construct a new " ,DataSeries " for a " ,(in-link "multi-bar-chart-series") " where the stacking-type of "
          "the series is specified to be one of the following options: ['none', 'absolute', 'relative', 'percent']"
          "By Default the stacking type will be 'none' or 'absolute' depending on whether the " 
          ,(in-link "multi-bar-chart-series") " was constructed with " ,(in-link "from-list.grouped-bar-chart") " or "
          ,(in-link "from-list.stacked-bar-chart")))))

@(define horizontal-meth
  `(method-spec
    (name "horizontal")
    (arity 2)
    (params ())
    (args ("self" "horizontal"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,B ,DataSeries))
    (doc ("Applies to " ,(in-link "bar-chart-series") " and " ,(in-link "multi-bar-chart-series") ": Construct a new " 
          ,DataSeries " with all the bars set to be horizontal or vertical. By Default the bars are vertical."))))

@(define bar-chart-annotations-meth
  `(method-spec
    (name "annotations")
    (arity 2)
    (params ())
    (args ("self" "annotations"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of (O-of S)) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with annotations on all the bars of a " ,(in-link "bar-chart-series")
          ". Use none to have no annotations on a specific bar. See " ,Option))))

@(define multi-bar-chart-annotations-meth
  `(method-spec
    (name "annotations")
    (arity 2)
    (params ())
    (args ("self" "annotations"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of (L-of (O-of S))) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with annotations on all the bars of a " ,(in-link "multi-bar-chart-series")
          ". Use none to have no annotations on a specific bar. See " ,Option " for more information. Advice: Use "
          "annotations sparingly to reduce the amount of overlap between annotations."))))

@(define bar-chart-intervals-meth
  `(method-spec
    (name "intervals")
    (arity 2)
    (params ())
    (args ("self" "intervals"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of (L-of N)) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with intervals on all the bars of a " ,(in-link "bar-chart-series")
          ". Note: Saving the chart as an image might result in some of the intervals being cut off."))))

@(define multi-bar-chart-intervals-meth
  `(method-spec
    (name "intervals")
    (arity 2)
    (params ())
    (args ("self" "intervals"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of (L-of (L-of N))) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with intervals on all the bars of a " ,(in-link "multi-bar-chart-series")
          ". Note: Saving the chart as an image might result in some of the intervals being cut off."))))

@(define bar-chart-error-bars-meth
  `(method-spec
    (name "error-bars")
    (arity 2)
    (params ())
    (args ("self" "error-bars"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of (L-of N)) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with error-bars on all the bars of a " ,(in-link "bar-chart-series")
          ". Note: Saving the chart as an image might result in some of the intervals being cut off. Error bars are"
          ,L  "s of length 2 [lower, upper]"))))

@(define multi-bar-chart-error-bars-meth
  `(method-spec
    (name "error-bars")
    (arity 2)
    (params ())
    (args ("self" "error-bars"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,(L-of (L-of (L-of N))) ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with error-barss on all the bars of a " ,(in-link "multi-bar-chart-series")
          ". Note: Saving the chart as an image might result in some of the intervals being cut off. Error bars are"
          ,L  "s of length 2 [lower, upper]."))))

@(define interval-color-meth
  `(method-spec
    (name "interval-color")
    (arity 2)
    (params ())
    (args ("self" "color"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,Color ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new color for the intervals added by " ,(in-link "bar-chart-series") ".intervals, " 
          ,(in-link "bar-chart-series") ".error_bars" 
          ,(in-link "multi-bar-chart-series") ".intervals, or" 
          ,(in-link "multi-bar-chart-series") ".error-bars."))))

@(define legend-meth
  `(method-spec
    (name "legend")
    (arity 2)
    (params ())
    (args ("self" "legend"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,S ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new legend. By default, "
          "the legend will be auto-generated in the form `Plot <number>'."))))

@(define point-size-meth
  `(method-spec
    (name "point-size")
    (arity 2)
    (params ())
    (args ("self" "point-size"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,N ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new point size. By default, "
          "the point size is 7."))))

@(define bin-width-meth
  `(method-spec
    (name "bin-width")
    (arity 2)
    (params ())
    (args ("self" "bin-width"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,N ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new bin width. By default, "
          "the bin width will be inferred."))))

@(define max-num-bins-meth
  `(method-spec
    (name "max-num-bins")
    (arity 2)
    (params ())
    (args ("self" "max-num-bins"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,N ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new maximum number of "
          "allowed bins. By default, the number will be inferred."))))

@(define min-num-bins-meth
  `(method-spec
    (name "min-num-bins")
    (arity 2)
    (params ())
    (args ("self" "min-num-bins"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,N ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new minimum number of "
          "allowed bins. By default, the number will be inferred."))))

@(define num-bins-meth
  `(method-spec
    (name "num-bins")
    (arity 2)
    (params ())
    (args ("self" "num-bins"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,N ,DataSeries))
    (doc ("Construct a new " ,DataSeries " with a new number of bins. "
          "By default, the number will be inferred."))))

@(define x-axis-meth
  `(method-spec
    (name "x-axis")
    (arity 2)
    (params ())
    (args ("self" "x-axis"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,S ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new x-axis label. "
          "By default, the label is empty."))))

@(define y-axis-meth
  `(method-spec
    (name "y-axis")
    (arity 2)
    (params ())
    (args ("self" "y-axis"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,S ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new y-axis label. "
          "By default, the label is empty."))))

@(define x-min-meth
  `(method-spec
    (name "x-min")
    (arity 2)
    (params ())
    (args ("self" "x-min"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,N ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new window dimension where "
          "x-min is changed. By default, the value will be inferred."))))

@(define x-max-meth
  `(method-spec
    (name "x-max")
    (arity 2)
    (params ())
    (args ("self" "x-max"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,N ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new window dimension where "
          "x-max is changed. By default, the value will be inferred."))))

@(define y-min-meth
  `(method-spec
    (name "y-min")
    (arity 2)
    (params ())
    (args ("self" "y-min"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,N ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new window dimension where "
          "y-min is changed. By default, the value will be inferred."))))

@(define y-max-meth
  `(method-spec
    (name "y-max")
    (arity 2)
    (params ())
    (args ("self" "y-max"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,N ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new window dimension where "
          "y-max is changed. By default, the value will be inferred."))))

@(define num-samples-meth
  `(method-spec
    (name "num-samples")
    (arity 2)
    (params ())
    (args ("self" "num-samples"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,N ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new number of samples "
          "configuration to be used when rendering all "
          ,(in-link "function-plot-series") "s in the chart."))))

@(append-gen-docs
  `(module "chart"
    (path "src/arr/trove/chart.arr")

    (fun-spec (name "from-list.function-plot") (arity 1))
    (fun-spec (name "from-list.line-plot") (arity 1))
    (fun-spec (name "from-list.scatter-plot") (arity 1))
    (fun-spec (name "from-list.labeled-scatter-plot") (arity 1))
    (fun-spec (name "from-list.bar-chart") (arity 2))
    (fun-spec (name "from-list.grouped-bar-chart") (arity 3))
    (fun-spec (name "from-list.stacked-bar-chart") (arity 3))
    (fun-spec (name "from-list.freq-bar-chart") (arity 1))
    (fun-spec (name "from-list.pie-chart") (arity 2))
    (fun-spec (name "from-list.exploding-pie-chart") (arity 3))
    (fun-spec (name "from-list.histogram") (arity 2))
    (fun-spec (name "from-list.labeled-histogram") (arity 3))
    (fun-spec (name "render-chart") (arity 1))
    (fun-spec (name "render-charts") (arity 1))
    (constr-spec
      (name "function-plot-series")
      (with-members (,color-meth ,legend-meth)))
    (constr-spec
      (name "line-plot-series")
      (with-members (,color-meth ,legend-meth)))
    (constr-spec
      (name "scatter-plot-series")
      (with-members (,color-meth ,legend-meth ,point-size-meth)))
    (constr-spec
      (name "bar-chart-series")
      (with-members (,color-meth ,bar-chart-colors-meth ,bar-chart-sort-meth ,bar-chart-sort-by-meth
                     ,bar-chart-sort-by-label-meth ,pointer-meth ,pointer-color-meth ,format-axis-meth
                     ,scale-meth ,horizontal-meth ,bar-chart-annotations-meth ,bar-chart-intervals-meth
                     ,bar-chart-error-bars-meth ,interval-color-meth)))
    (constr-spec
      (name "multi-bar-chart-series")
      (with-members (,multi-bar-chart-colors-meth ,multi-bar-chart-sort-meth ,multi-bar-chart-sort-by-meth
                     ,multi-bar-chart-sort-by-label-meth ,multi-bar-chart-sort-by-data-meth ,pointer-meth
                     ,pointer-color-meth ,format-axis-meth ,scale-meth ,multi-bar-chart-stacking-meth
                     ,horizontal-meth ,multi-bar-chart-annotations-meth ,multi-bar-chart-intervals-meth
                     ,multi-bar-chart-error-bars-meth ,interval-color-meth)))
    (constr-spec
      (name "pie-chart-series")
      (with-members ()))
    (constr-spec
      (name "histogram-series")
      (with-members (,bin-width-meth ,max-num-bins-meth ,min-num-bins-meth
                     ,num-bins-meth)))
    (data-spec
      (name "DataSeries")
      (type-vars ())
      (variants ("function-plot-series" "line-plot-series" "scatter-plot-series"
                 "bar-chart-series" "multi-bar-chart-series" "pie-chart-series" "histogram-series"))
      (shared))
    (data-spec
      (name "ChartWindow")
      (type-vars ())
      (variants ("bar-chart-window"))
      (shared
        ((method-spec
          (name "title")
          (arity 2)
          (params ())
          (contract (a-arrow ,Self ,S ,ChartWindow))
          (args ("self" "title"))
          (return ,ChartWindow)
          (doc ("Construct a new " ,ChartWindow " with a new title. "
                "By default, the title will empty")))
        (method-spec
          (name "width")
          (arity 2)
          (params ())
          (contract (a-arrow ,Self ,N ,ChartWindow))
          (args ("self" "width"))
          (return ,ChartWindow)
          (doc ("Construct a new " ,ChartWindow " with a new width. "
                "By default, the width will be 800")))
        (method-spec
          (name "height")
          (arity 2)
          (params ())
          (contract (a-arrow ,Self ,N ,ChartWindow))
          (args ("self" "height"))
          (return ,ChartWindow)
          (doc ("Construct a new " ,ChartWindow " with a new height. "
                "By default, the height will 600")))
        (method-spec
          (name "display")
          (arity 1)
          (params ())
          (contract (a-arrow ,Self ,Image))
          (args ("self"))
          (return ,Image)
          (doc ("Display the chart on an interactive dialog, "
                "and produce an " ,Image " after the dialog is closed.")))
        (method-spec
          (name "get-image")
          (arity 1)
          (params ())
          (contract (a-arrow ,Self ,Image))
          (args ("self"))
          (return ,Image)
          (doc ("Produce an " ,Image " of the chart"))))))
    (constr-spec
      (name "plot-chart-window")
      (with-members (,x-min-meth ,x-max-meth ,y-min-meth ,y-max-meth ,x-axis-meth ,y-axis-meth
                     ,num-samples-meth)))
    (constr-spec
      (name "histogram-chart-window")
      (with-members (,x-min-meth ,x-max-meth ,y-max-meth ,x-axis-meth ,y-axis-meth)))
    (constr-spec
      (name "bar-chart-window")
      (with-members (,y-min-meth ,y-max-meth ,x-axis-meth ,y-axis-meth)))
    (constr-spec
      (name "pie-chart-window")
      (with-members ()))
  ))

@docmodule["chart"]{
  The Pyret Chart library. It consists of chart, plot, and data visualization tools,
  using @link["https://developers.google.com/chart/" "Google Charts"] as a backend.

  This documentation assumes that your program begins with including the @pyret{chart} library and importing the @pyret{color} library as follows:

  @pyret-block{
include chart
import color as C
  }

  There are two steps to create a chart: first, creating @emph{@|DataSeries|} representing the information to be charted, and second, rendering @|DataSeries| into a @emph{@|ChartWindow|}. We give examples of both steps below.

  @;############################################################################
  @section{Creating a DataSeries}

  In order to visualize data as a chart, you must decide what @emph{type} of chart (e.g., bar charts or pie charts; there are others detailed below) you want.

  The combination of data with a chart type and (optional) chart-specific configurations is called a @emph{@|DataSeries|}. For example, your program might have population data about English native speakers in several countries, and your goal is to visualize that data as a bar chart. One reasonable starting point is to represent the data as a list of strings (country names) and a list of numbers (number of English native speakers):

  @pyret-block{
countries =    [list: "US",      "India",   "Pakistan", "Philippines", "Nigeria"]
num-speakers = [list: 251388301, 125344736, 110041604,  89800800,      79000000]
  }

  Getting from this data to a data series is simple: use a @emph{chart constructor} -- here, the bar chart constructor @pyret{from-list.bar-chart} -- to create a @|DataSeries|:

  @pyret-block{
a-pie-chart-series = from-list.bar-chart(countries, num-speakers)
  }

  As another example, consider the typical high-school math task of ``graphing a function'', that is, plotting the values of a function for some range of inputs. Another chart constructor, @pyret{from-list.function-plot}, would create the relevant @|DataSeries|:

  @pyret-block{
fun some-fun(x): num-sin(2 * x) end # some arbitrary function
a-function-series = from-list.function-plot(some-fun)
  }

  So far, we have only constructed @|DataSeries| without any additionnal configuration. @|DataSeries| also exist to allow customizing individual plots. As a simple first example of this, suppose the function plot should be in a specific color. You might write:

  @pyret-block{
colorful-function-series = a-function-series.color(C.purple)
  }

  You can also combine @|DataSeries| creation and @|DataSeries| customization together via chaining to avoid an intermediate variable:

  @pyret-block{
fun some-fun(x): num-sin(2 * x) end # some arbitrary function
colorful-function-series = from-list.function-plot(some-fun)
                                    .color(C.purple)
  }

  There are also other customization options, described below, that can be chained onto the end of this expression to successively customize other details of the @|DataSeries|.

  @margin-note{We plan that the chart library should support the @pyret-id["Table" "tables"] inferface too.
  Hence, each chart constructor will be provided under both @pyret{from-list}
  and @pyret{from-table} object. However, currently only the list forms (@pyret{from-list})
  are supported.}

  @;############################################################################
  @section{Creating a ChartWindow}

  Given @|DataSeries|, we can render it/them on a window using
  the function @in-link{render-charts} or @in-link{render-chart}. The functions construct a @in-link{ChartWindow}.
  From the example in the previous section:

  @pyret-block{
fun some-fun(x): num-sin(2 * x) end
a-series = from-list.function-plot(some-fun)
  .color(C.purple)
a-chart-window = render-chart(a-series)
  }

  Once you have a @|ChartWindow|, you can use its @pyret-method["ChartWindow" "display"] method to actually open up an interactive dialog: @pyret{a-chart-window.display()} will produce a dialog like this:

@(in-image "dialog")

  In addition to displaying the interactive dialog, the @pyret-method["ChartWindow" "display"] method will also return the rendered chart as an @pyret-id["Image" "image"]. If you only need the @pyret-id["Image" "image"] but not the interactive dialog, you should use the method @pyret-method["ChartWindow" "get-image"] instead of @pyret-method["ChartWindow" "display"].

  @pyret-block{
an-image = a-chart-window.get-image()
  }

  Just as @|DataSeries| is an intermediate value allowing for the customization of individual plots, @in-link{ChartWindow} is an intermediate value allowing for the customization of the @emph{entire chart window}. For example, charts ought to have titles and axis labels. These options do not make sense on individual plots; they are properties of the chart window as a whole. So we might write:

  @pyret-block{
    a-chart-window
      .title("a sine function plot")
      .x-axis("this is x-axis")
      .y-axis("this is y-axis")
      .display()
  }

  These customizations change the output from the previous image to the following:

  @(in-image "window-config")

  @;############################################################################
  @subsection{Interactive Dialog}

  To close an interactive dialog, you can either click the close button on the top left corner, or press esc.

  In addition to being able to obtain the chart as a Pyret @|Image|, you can
  also save the chart image as a @pyret{png} file from the interactive dialog by
  clicking the save button which is next to the close button.

  For some kind of charts (e.g., function plot) there
  will be a controller panel for you to adjust configurations of the chart window interactively.

  @;############################################################################
  @subsection{Why are there watermarks on my charts?}

  If you evaluate @pyret{colorful-function-series} or @pyret{a-chart-window} in the interactions pane, you will produce images like the following:

  @repl-examples[
   `(@{colorful-function-series} ,(in-image "data-series-watermark"))
   `(@{a-chart-window}           ,(in-image "chart-window-watermark"))
  ]

  These images have watermarks on them to remind you that you are still working with @emph{intermediate} values, either @|DataSeries| or @|ChartWindow| respectively.  By default, both will render themselves as an appropriate chart with default configurations, but in order to interact with the chart you must use the @pyret-method["ChartWindow" "display"] method, and to produce an unwatermarked image of the chart you must use the @pyret-method["ChartWindow" "get-image"] method.

  @;############################################################################
  @section{Chart Constructors for List Interface}

  @function["from-list.function-plot"
    #:contract (a-arrow (a-arrow N N) DataSeries)
    #:args '(("f" #f))
    #:return (a-pred DataSeries (in-link "function-plot-series"))
  ]{

    Constructing a function plot series from @pyret{f}. See more details at
    @(in-link "function-plot-series").

    @examples{
NUM_E = ~2.71828
f-series = from-list.function-plot(lam(x): 1 - num-expt(NUM_E, 0 - x) end)
f-series
    }
    @(in-image "function-plot-constructor")
  }
  
  @function["from-list.line-plot"
    #:contract (a-arrow (L-of N) (L-of N) DataSeries)
    #:args '(("xs" #f) ("ys" #f))
    #:return (a-pred DataSeries (in-link "line-plot-series"))
  ]{

    Constructing a line plot series from @pyret{xs} and @pyret{ys}, representing x and y
    coordinates of points. See more details at @(in-link "line-plot-series").

    @examples{
a-series = from-list.line-plot(
  [list: 0,  1, 2,  3, 6, 7,  10, 13, 16, 20],
  [list: 18, 2, 28, 9, 7, 29, 25, 26, 29, 24])
a-series
    }
    @(in-image "line-plot-constructor")
  }

  @function["from-list.scatter-plot"
    #:contract (a-arrow (L-of N) (L-of N) DataSeries)
    #:args '(("xs" #f) ("ys" #f))
    #:return (a-pred DataSeries (in-link "scatter-plot-series"))
  ]{

    Constructing a scatter plot series from @pyret{xs} and @pyret{ys}, representing x and y
    coordinates of points. See more details at @(in-link "scatter-plot-series").

    @examples{
a-series = from-list.scatter-plot(
  [list: 0,  1, 2,  3, 6, 7,  10, 13, 16, 20],
  [list: 18, 2, 28, 9, 7, 29, 25, 26, 29, 24])
a-series
    }
    @(in-image "scatter-plot-constructor")
  }

  @function["from-list.labeled-scatter-plot"
    #:contract (a-arrow (L-of S) (L-of N) (L-of N) DataSeries)
    #:args '(("labels" #f) ("xs" #f) ("ys" #f))
    #:return (a-pred DataSeries (in-link "scatter-plot-series"))
  ]{

    Constructing a scatter plot series from @pyret{xs} and @pyret{ys}, representing x and y
    coordinates of points, and @pyret{labels} whose element representing a label for each point.
    The labels will show up when you display the chart and hover over the points. 
    See more details at @(in-link "scatter-plot-series").


    @examples{
a-series = from-list.labeled-scatter-plot(
  [list: "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"],
  [list: 0,   1,   2,   3,   6,   7,   10, 13,   16,  20],
  [list: 18,  2,   28,  9,   7,   29,  25, 26,   29,  24])
a-series
    }
    @(in-image "labeled-scatter-plot-constructor")
  }

  @function["from-list.bar-chart"
    #:contract (a-arrow (L-of S) (L-of N) DataSeries)
    #:args '(("labels" #f) ("values" #f))
    #:return (a-pred DataSeries (in-link "bar-chart-series"))
  ]{

    Constructing a bar chart series from @pyret{labels} and @pyret{values},
    representing the label and value of bars. See more details at
    @(in-link "bar-chart-series").

    @examples{
a-series = from-list.bar-chart(
  [list: "Pyret", "OCaml", "C", "C++", "Python", "Racket", "Smalltalk"],
  [list: 10,       6,       1,   3,     5,       8,        9])
a-series
# This data is obtained by randomization. They have no meaning whatsoever.
# (though we did run a few trials so that the result doesn't look egregious)
    }
  @(in-image "bar-chart-constructor")
  }

  @function["from-list.freq-bar-chart"
    #:contract (a-arrow (L-of S) DataSeries)
    #:args '(("values" #f))
    #:return (a-pred DataSeries (in-link "bar-chart-series"))
  ]{
    Constructing a bar chart series based on the frequencies of elements in
    @pyret{values}. See more details at @(in-link "bar-chart-series").

    @examples{
a-series = from-list.freq-bar-chart(
  [list: "Pyret", "OCaml", "Pyret", "Java", " Pyret", "Racket", "Coq", "Coq"])
a-series
    }
    @(in-image "freq-bar-chart-constructor")
  }

  @function["from-list.grouped-bar-chart"
    #:contract (a-arrow (L-of S) (L-of (L-of N)) (L-of S) DataSeries)
    #:args '(("labels" #f) ("value-lists" #f) ("legends" #f))
    #:return (a-pred DataSeries (in-link "multi-bar-chart-series"))
  ]{

    Constructing a bar chart series. A @pyret{value-list} in @pyret{value-lists} is
    a list of numbers, representing bars in a label but with different legends. The length
    of @pyret{value-lists} must match the length of @pyret{labels}, and the length of each
    @pyret{value-list} must match the length of @pyret{legends}. Bars in a label are grouped 
    next to each other. See more details at@(in-link "multi-bar-chart-series").

    @examples{
a-series = from-list.grouped-bar-chart(
  [list: 'CA', 'TX', 'NY', 'FL', 'IL', 'PA'],
  [list:
    [list: 2704659,4499890,2159981,3853788,10604510,8819342,4114496],
    [list: 2027307,3277946,1420518,2454721,7017731,5656528,2472223],
    [list: 1208495,2141490,1058031,1999120,5355235,5120254,2607672],
    [list: 1140516,1938695,925060,1607297,4782119,4746856,3187797],
    [list: 894368,1558919,725973,1311479,3596343,3239173,1575308],
    [list: 737462,1345341,679201,1203944,3157759,3414001,1910571]],
  [list:
    'Under 5 Years',
    '5 to 13 Years',
    '14 to 17 Years',
    '18 to 24 Years',
    '25 to 44 Years',
    '45 to 64 Years',
    '65 Years and Over'])
a-series
    }
    @(in-image "grouped-bar-chart-constructor")
  }

  @function["from-list.stacked-bar-chart"
    #:contract (a-arrow (L-of S) (L-of (L-of N)) (L-of S) DataSeries)
    #:args '(("labels" #f) ("value-lists" #f) ("legends" #f))
    #:return (a-pred DataSeries (in-link "multi-bar-chart-series"))
  ]{

    Constructing a bar chart series. A @pyret{value-list} in @pyret{value-lists} is
    a list of numbers, representing bars in a label but with different legends. The length
    of @pyret{value-lists} must match the length of @pyret{labels}, and the length of each
    @pyret{value-list} must match the length of @pyret{legends}. Bars in a label are stacked
    on top of each other. See more details at @(in-link "multi-bar-chart-series").

    @examples{
a-series = from-list.stacked-bar-chart(
  [list: 'CA', 'TX', 'NY', 'FL', 'IL', 'PA'],
  [list:
    [list: 2704659,4499890,2159981,3853788,10604510,8819342,4114496],
    [list: 2027307,3277946,1420518,2454721,7017731,5656528,2472223],
    [list: 1208495,2141490,1058031,1999120,5355235,5120254,2607672],
    [list: 1140516,1938695,925060,1607297,4782119,4746856,3187797],
    [list: 894368,1558919,725973,1311479,3596343,3239173,1575308],
    [list: 737462,1345341,679201,1203944,3157759,3414001,1910571]],
  [list:
    'Under 5 Years',
    '5 to 13 Years',
    '14 to 17 Years',
    '18 to 24 Years',
    '25 to 44 Years',
    '45 to 64 Years',
    '65 Years and Over'])
a-series
    }
    @(in-image "stacked-bar-chart-constructor")
  }

  @function["from-list.pie-chart"
    #:contract (a-arrow (L-of S) (L-of N) DataSeries)
    #:args '(("labels" #f) ("values" #f))
    #:return (a-pred DataSeries (in-link "pie-chart-series"))
  ]{
    Constructing a pie chart series from @pyret{labels} and @pyret{values},
    representing the label and value of slices. See more details at
    @(in-link "pie-chart-series").

    @examples{
a-series = from-list.pie-chart(
  [list: "Pyret", "OCaml", "C", "C++", "Python", "Racket", "Smalltalk"],
  [list: 10,       6,       1,   3,     5,       8,        9])
# This data is obtained by randomization. They have no meaning whatsoever.
# (though we did run a few trials so that the result doesn't look egregious)
a-series
    }
    @(in-image "pie-chart-constructor")
  }

  @function["from-list.exploding-pie-chart"
    #:contract (a-arrow (L-of S) (L-of N) (L-of N) DataSeries)
    #:args '(("labels" #f) ("values" #f) ("offsets" #f))
    #:return (a-pred DataSeries (in-link "pie-chart-series"))
  ]{
    Constructing a pie chart series from @pyret{labels} and @pyret{values},
    representing the label and value of slices. @pyret{offsets}
    indicates the offset from the center of the chart for each slice. Each offset
    must be in range 0 and 1. See more details at @(in-link "pie-chart-series").

    @examples{
a-series = from-list.exploding-pie-chart(
  [list: "Pyret", "OCaml", "C", "C++", "Python", "Racket", "Smalltalk"],
  [list: 10,       6,       1,   3,     5,       8,        9],
  [list: 0.2,      0,       0,   0,     0,       0.1,      0])
# This data is obtained by randomization. They have no meaning whatsoever.
# (though we did run a few trials so that the result doesn't look egregious)
a-series
    }
    @(in-image "exploding-pie-chart-constructor")
  }

  @function["from-list.histogram"
    #:contract (a-arrow (L-of N) DataSeries)
    #:args '(("values" #f))
    #:return (a-pred DataSeries (in-link "histogram-series"))
  ]{
    Constructing a histogram series, grouping @pyret{values} into bins.
    See more details at @(in-link "histogram-series").

    @examples{
a-series = from-list.histogram(range(1, 100).map(lam(_): num-random(1000) end))
a-series
    }
    @(in-image "histogram-constructor")
  }

  @function["from-list.labeled-histogram"
    #:contract (a-arrow (L-of S) (L-of N) DataSeries)
    #:args '(("labels" #f) ("values" #f))
    #:return (a-pred DataSeries (in-link "histogram-series"))
  ]{
    Constructing a histogram series, grouping @pyret{values} into bins.
    Each element of @pyret{labels} is attached to the corresponding value in
    the bin. The labels will show up when you display the chart and hover over the boxes. 
    See more details at @(in-link "histogram-series").

    @examples{
a-series = from-list.labeled-histogram(
  range(1, 100).map(lam(x): "foo " + num-to-string(x) end),
  range(1, 100).map(lam(_): num-random(1000) end))
a-series
    }
  @(in-image "labeled-histogram-constructor")
  }

  @;############################################################################
  @section{DataSeries}

  @data-spec2["DataSeries" (list) (list
  @constructor-spec["DataSeries" "function-plot-series" opaque]
  @constructor-spec["DataSeries" "line-plot-series" opaque]
  @constructor-spec["DataSeries" "scatter-plot-series" opaque]
  @constructor-spec["DataSeries" "bar-chart-series" opaque]
  @constructor-spec["DataSeries" "multi-bar-chart-series" opaque]
  @constructor-spec["DataSeries" "pie-chart-series" opaque]
  @constructor-spec["DataSeries" "histogram-series" opaque]
  )]

  @;################################
  @subsection{Function Plot Series}

  @constructor-doc["DataSeries" "function-plot-series" opaque DataSeries]{
    A function plot series. When it is rendered, the function will be sampled
    on different x values. The library intentionally does @emph{not} draw lines
    between sample points because it is possible that the function will be
    discontinuous, and drawing lines between sample points would mislead users
    that the function is continuous (for example, the stepping function
    @pyret{num-floor} should not have vertical lines in each step). Instead,
    we let users increase sample sizes, allowing the function to be rendered
    more accurately.
  }
  
  @repl-examples[
   `(@{NUM_E = ~2.71828
a-series = from-list.function-plot(lam(x): 1 - num-expt(NUM_E, 0 - x) end)
render-chart(a-series).display()} ,(in-image "function-plot-example"))
  ]

  @method-doc["DataSeries" "function-plot-series" "color"]
  @repl-examples[
   `(@{include color
     render-chart(a-series.color(orange)).display()} ,(in-image "function-plot-color-example"))
  ]

  @method-doc["DataSeries" "function-plot-series" "legend"]
  @repl-examples[
   `(@{render-chart(a-series.legend("My Legend")).display()} ,(in-image "function-plot-legend-example"))
  ]

  @;################################
  @subsection{Line Plot Series}

  @constructor-doc["DataSeries" "line-plot-series" opaque DataSeries]{
    A line plot series
  }
  @repl-examples[
   `(@{a-series = from-list.line-plot(
  [list: 0,  1, 2,  3, 6, 7,  10, 13, 16, 20],
  [list: 18, 2, 28, 9, 7, 29, 25, 26, 29, 24])
render-chart(a-series).display()} ,(in-image "line-plot-example"))
  ]

  @method-doc["DataSeries" "line-plot-series" "color"]
  @repl-examples[
   `(@{include color
render-chart(a-series.color(orange)).display()} ,(in-image "line-plot-color-example"))
  ]
  @method-doc["DataSeries" "line-plot-series" "legend"]
  @repl-examples[
   `(@{render-chart(a-series.legend("My Legend")).display()} ,(in-image "line-plot-legend-example"))
  ]

  @;################################
  @subsection{Scatter Plot Series}

  @constructor-doc["DataSeries" "scatter-plot-series" opaque DataSeries]{
    A scatter plot series. If a data point has a label, then hovering over the
    point in the interactive dialog will show the label.
  }
   @repl-examples[
   `(@{a-series = from-list.labeled-scatter-plot(
  [list: "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"],
  [list: 0,   1,   2,   3,   6,   7,   10, 13,   16,  20],
  [list: 18,  2,   28,  9,   7,   29,  25, 26,   29,  24])
render-chart(a-series).display()} ,(in-image "scatter-plot-example"))
  ]

  @method-doc["DataSeries" "scatter-plot-series" "color"]
  @repl-examples[
   `(@{include color
   render-chart(a-series.color(orange)).display()} ,(in-image "scatter-plot-color-example"))
  ]

  @method-doc["DataSeries" "scatter-plot-series" "legend"]
  @repl-examples[
   `(@{render-chart(a-series.legend("My Legend")).display()} ,(in-image "scatter-plot-legend-example"))
  ]

  @method-doc["DataSeries" "scatter-plot-series" "point-size"]
  @repl-examples[
   `(@{render-chart(a-series.point-size(10)).display()} ,(in-image "scatter-plot-ptsize-example"))
  ]

  @;################################
  @subsection{Bar Chart Series}

  @constructor-doc["DataSeries" "bar-chart-series" opaque DataSeries]{
    A bar chart series. In a label, there can only be a single bar.
  }
  @repl-examples[
   `(@{a-series = from-list.bar-chart(
  [list: "Pyret", "OCaml", "C", "C++", "Python", "Racket", "Smalltalk"],
  [list: 10,       6,       1,   3,     5,       8,        9])
# This data is obtained by randomization. They have no meaning whatsoever.
# (though we did run a few trials so that the result doesn't look egregious)
render-chart(a-series).display()} ,(in-image "bar-chart-example"))
  ]
  @method-doc["DataSeries" "bar-chart-series" "color"]
  @repl-examples[
   `(@{include color
  render-chart(a-series.color(red)).display()} ,(in-image "bar-chart-color-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "colors"]
  @repl-examples[
   `(@{render-chart(a-series.colors([list: red, orange, blue])).display()} ,(in-image "bar-chart-colors-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "sort"]
  @repl-examples[
   `(@{render-chart(a-series.sort()).display()} ,(in-image "bar-chart-sort-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "sort-by"]
  @repl-examples[
   `(@{descending-cmp = {(a, b): a > b}
   eq = {(a, b): a == b}
   render-chart(a-series.sort-by(descending-cmp, eq)).display()} ,(in-image "bar-chart-sort-by-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "sort-by-label"]
  @repl-examples[
   `(@{descending-str-len = {(a, b): string-length(a) > string-length(b)}
   eq = {(a, b): a == b}
   render-chart(a-series.sort-by-label(descending-str-len, eq)).display()} ,(in-image "bar-chart-sort-by-label-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "add-pointers"]
  @repl-examples[
   `(@{render-chart(a-series.add-pointers([list: 6, 7], 
                                          [list: "median", "mean + 1"]))
                            .display()} ,(in-image "bar-chart-pointers-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "pointer-color"]
  @repl-examples[
   `(@{render-chart(a-series.add-pointers([list: 6, 7], 
                                          [list: "median", "mean + 1"])
                            .pointer-color(orange))
                            .display()} ,(in-image "bar-chart-pointer-color-example"))
  ]
  
  @method-doc["DataSeries" "bar-chart-series" "format-axis"]
  @repl-examples[
   `(@{render-chart(a-series.format-axis({(n): num-to-string(n) + " votes"}))
                            .display()} ,(in-image "bar-chart-format-axis-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "scale"]
  @repl-examples[
   `(@{render-chart(a-series.scale({(n): n * n}))
                            .display()} ,(in-image "bar-chart-scale-example"))
  ]
  
  @method-doc["DataSeries" "bar-chart-series" "horizontal"]
  @repl-examples[
   `(@{render-chart(a-series.horizontal(true))
                            .display()} ,(in-image "bar-chart-horizontal-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "annotations"]
  @repl-examples[
   `(@{render-chart(a-series.annotations([list: some("P"), some("O"), some("C"),
      none, some("P"), some("R"), some("SM")]))
                            .display()} ,(in-image "bar-chart-annotations-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "intervals"]
  @repl-examples[
   `(@{render-chart(a-series.intervals([list: [list: 9, 11],
      [list: 1, 2, 3, 4, 5], [list: -1, -2], empty, empty, empty, empty]))
                            .display()} ,(in-image "bar-chart-intervals-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "error-bars"]
  @repl-examples[
   `(@{render-chart(a-series.error-bars([list: [list: -1, 1], [list: -1, 1],
      [list: -1, 2], [list: -1, 1], [list: -1, 1], [list: -1, 1],
      [list: -1, 1]]))
                            .display()} ,(in-image "bar-chart-error-bars-example"))
  ]

  @method-doc["DataSeries" "bar-chart-series" "interval-color"]
  @repl-examples[
   `(@{render-chart(a-series.error-bars([list: [list: -1, 1], [list: -1, 1],
      [list: -1, 2], [list: -1, 1], [list: -1, 1], [list: -1, 1],
      [list: -1, 1]])       
                            .interval-color(orange))
                            .display()} ,(in-image "bar-chart-interval-color-example"))
  ]

  @;################################
  @subsection{Multi Bar Chart Series}

  @constructor-doc["DataSeries" "multi-bar-chart-series" opaque DataSeries]{
    A bar chart series. In a label, there could be several bars (grouped or stacked).
  }

  @repl-examples[
   `(@{grouped-series = from-list.grouped-bar-chart(
  [list: 'CA', 'TX', 'NY', 'FL', 'IL', 'PA'],
  [list:
    [list: 2704659,4499890,2159981,3853788,10604510,8819342,4114496],
    [list: 2027307,3277946,1420518,2454721,7017731,5656528,2472223],
    [list: 1208495,2141490,1058031,1999120,5355235,5120254,2607672],
    [list: 1140516,1938695,925060,1607297,4782119,4746856,3187797],
    [list: 894368,1558919,725973,1311479,3596343,3239173,1575308],
    [list: 737462,1345341,679201,1203944,3157759,3414001,1910571]],
  [list:
    'Under 5 Years',
    '5 to 13 Years',
    '14 to 17 Years',
    '18 to 24 Years',
    '25 to 44 Years',
    '45 to 64 Years',
    '65 Years and Over'])
    render-chart(grouped-series).display()} ,(in-image "grouped-bar-chart-example"))
  `(@{stacked-series = from-list.stacked-bar-chart(
  [list: 'CA', 'TX', 'NY', 'FL', 'IL', 'PA'],
  [list:
    [list: 2704659,4499890,2159981,3853788,10604510,8819342,4114496],
    [list: 2027307,3277946,1420518,2454721,7017731,5656528,2472223],
    [list: 1208495,2141490,1058031,1999120,5355235,5120254,2607672],
    [list: 1140516,1938695,925060,1607297,4782119,4746856,3187797],
    [list: 894368,1558919,725973,1311479,3596343,3239173,1575308],
    [list: 737462,1345341,679201,1203944,3157759,3414001,1910571]],
  [list:
    'Under 5 Years',
    '5 to 13 Years',
    '14 to 17 Years',
    '18 to 24 Years',
    '25 to 44 Years',
    '45 to 64 Years',
    '65 Years and Over'])
    render-chart(stacked-series).display()} ,(in-image "stacked-bar-chart-example"))
  ]

  @method-doc["DataSeries" "multi-bar-chart-series" "colors"]
  @repl-examples[
   `(@{render-chart(grouped-series.colors([list: red, orange, blue])).display()} ,(in-image "grouped-bar-chart-colors-example"))
   `(@{render-chart(stacked-series.colors([list: red, orange, blue])).display()} ,(in-image "stacked-bar-chart-colors-example"))
  ]

  @method-doc["DataSeries" "multi-bar-chart-series" "sort"]
  @repl-examples[
   `(@{render-chart(grouped-series.sort()).display()} ,(in-image "grouped-bar-chart-sort-example"))
   `(@{render-chart(stacked-series.sort()).display()} ,(in-image "stacked-bar-chart-sort-example"))
  ]

  @method-doc["DataSeries" "multi-bar-chart-series" "sort-by"]
  @repl-examples[
   `(@{descending-cmp = {(a, b): a > b}
   eq = {(a, b): a == b}
   render-chart(grouped-series.sort-by(descending-cmp, eq)).display()} ,(in-image "grouped-bar-chart-sort-by-example"))
   `(@{descending-cmp = {(a, b): a > b}
   eq = {(a, b): a == b}
   render-chart(stacked-series.sort-by(descending-cmp, eq)).display()} ,(in-image "stacked-bar-chart-sort-by-example"))
  ]

  @method-doc["DataSeries" "multi-bar-chart-series" "sort-by-label"]
  @repl-examples[
   `(@{descending-str-cmp = {(a, b): a > b}
   eq = {(a, b): a == b}
   render-chart(grouped-series.sort-by-label(descendong-str-cmp, eq))
                              .display()} ,(in-image "grouped-bar-chart-sort-by-label-example"))
    `(@{descendong-str-cmp = {(a, b): a > b}
   eq = {(a, b): a == b}
   render-chart(stacked-series.sort-by-label(descend-str-cmp, eq))
                              .display()} ,(in-image "stacked-bar-chart-sort-by-label-example"))
  ]

   @method-doc["DataSeries" "multi-bar-chart-series" "sort-by-data"]
  @repl-examples[
   `(@{get-last = {(l): l.get(6)}
   ascending-cmp = {(a, b): a < b}
   eq = {(a, b): a == b}
   render-chart(grouped-series.sort-by-data(get-last, ascending-cmp, eq))
                              .display()} ,(in-image "grouped-bar-chart-sort-by-data-example"))
    `(@{get-last = {(l): l.get(6)}
   ascending-cmp = {(a, b): a > b}
   eq = {(a, b): a == b}
   render-chart(stacked-series.sort-by-data(get-last, ascending-cmp, eq))
                              .display()} ,(in-image "stacked-bar-chart-sort-by-data-example"))
  ]

  @examples{
a-series = from-list.grouped-bar-chart(
  [list: 'CA', 'TX', 'NY', 'FL', 'IL', 'PA'],
  [list:
    [list: 2704659,4499890,2159981,3853788,10604510,8819342,4114496],
    [list: 2027307,3277946,1420518,2454721,7017731,5656528,2472223],
    [list: 1208495,2141490,1058031,1999120,5355235,5120254,2607672],
    [list: 1140516,1938695,925060,1607297,4782119,4746856,3187797],
    [list: 894368,1558919,725973,1311479,3596343,3239173,1575308],
    [list: 737462,1345341,679201,1203944,3157759,3414001,1910571]],
  [list:
    'Under 5 Years',
    '5 to 13 Years',
    '14 to 17 Years',
    '18 to 24 Years',
    '25 to 44 Years',
    '45 to 64 Years',
    '65 Years and Over'])
render-chart(a-series).display()
  }
  @(in-image "grouped-bar-chart")

  @;################################
  @subsection{Pie Chart Series}

  @constructor-doc["DataSeries" "pie-chart-series" opaque DataSeries]{
    A pie chart series. Each slice could be offset from the center.
  }

  @examples{
a-series = from-list.exploding-pie-chart(
  [list: "Pyret", "OCaml", "C", "C++", "Python", "Racket", "Smalltalk"],
  [list: 10,       6,       1,   3,     5,       8,        9],
  [list: 0.2,      0,       0,   0,     0,       0.1,      0])
render-chart(a-series).display()
  }
  @(in-image "exploding-pie-chart")


  @;################################
  @subsection{Histogram Series}

  @constructor-doc["DataSeries" "histogram-series" opaque DataSeries]{
    A histogram series.
  }

  @method-doc["DataSeries" "histogram-series" "bin-width"]
  @method-doc["DataSeries" "histogram-series" "max-num-bins"]
  @method-doc["DataSeries" "histogram-series" "min-num-bins"]
  @method-doc["DataSeries" "histogram-series" "num-bins"]

  @examples{
a-series = from-list.labeled-histogram(
  range(1, 100).map(lam(x): "foo " + num-to-string(x) end),
  range(1, 100).map(lam(_): num-random(1000) end))
render-chart(a-series).display()
  }
  @(in-image "labeled-histogram")

  @;############################################################################
  @section{Renderers}

  @function["render-chart"
    #:contract (a-arrow DataSeries ChartWindow)
    #:args '(("series" #f))
    #:return ChartWindow
  ]{
    Constructing a chart window from one @|DataSeries|.

    @itemlist[
    @item{@in-link{function-plot-series} creates a @in-link{plot-chart-window}}
    @item{@in-link{line-plot-series} creates a @in-link{plot-chart-window}}
    @item{@in-link{scatter-plot-series} creates a @in-link{plot-chart-window}}
    @item{@in-link{bar-chart-series} creates a @in-link{bar-chart-window}}
    ;@item{@in-link{multi-bar-chart-series} creates a @in-link{multi-bar-chart-window}}
    @item{@in-link{pie-chart-series} creates a @in-link{pie-chart-window}}
    @item{@in-link{histogram-series} creates a @in-link{histogram-chart-window}}
    ]

    @examples{
a-series = from-list.function-plot(lam(x): x * x end)
a-chart-window = render-chart(a-series)
    }
  }

  @function["render-charts"
    #:contract (a-arrow (L-of DataSeries) ChartWindow)
    #:args '(("lst" #f))
    #:return ChartWindow
  ]{
    Constructing a chart window from several @|DataSeries| and draw them together
    in the same window. All @|DataSeries| in @pyret{lst} must be either
    a @in-link{function-plot-series}, @in-link{line-plot-series}, or
    @in-link{scatter-plot-series}.

    @examples{
series-1 = from-list.function-plot(lam(x): x end)
series-2 = from-list.scatter-plot(
  [list: 1, 2, 3,  4.1, 4.1, 4.5],
  [list: 2, 1, 3.5, 3.9, 3.8, 4.9])
a-chart-window = render-charts([list: series-1, series-2])
    }

    @(in-image "render-charts")
  }

  @;############################################################################
  @section{ChartWindow}

  @data-spec2["ChartWindow" (list) (list
  @constructor-spec["ChartWindow" "pie-chart-window" opaque]
  @constructor-spec["ChartWindow" "bar-chart-window" opaque]
  @constructor-spec["ChartWindow" "histogram-chart-window" opaque]
  @constructor-spec["ChartWindow" "plot-chart-window" opaque]
  )]

  @;################################
  @subsection{Shared Methods}

  @method-doc["ChartWindow" #f "title"]
  @method-doc["ChartWindow" #f "width"]
  @method-doc["ChartWindow" #f "height"]
  @method-doc["ChartWindow" #f "display"]
  @method-doc["ChartWindow" #f "get-image"]

  @;################################
  @subsection{Plot Chart Window}

  @constructor-doc["ChartWindow" "plot-chart-window" opaque ChartWindow]{
    A plot chart window. For this type of chart window, when it is displayed in
    an interactive dialog, there will be a controller panel to control @pyret{x-min},
    @pyret{x-max}, @pyret{y-min}, @pyret{y-max}, and possibly @pyret{num-samples} (if the chart contains @in-link{function-plot-series})
  }
  @method-doc["ChartWindow" "plot-chart-window" "x-min"]
  @method-doc["ChartWindow" "plot-chart-window" "x-max"]
  @method-doc["ChartWindow" "plot-chart-window" "y-min"]
  @method-doc["ChartWindow" "plot-chart-window" "y-max"]
  @method-doc["ChartWindow" "plot-chart-window" "num-samples"]
  @method-doc["ChartWindow" "plot-chart-window" "x-axis"]
  @method-doc["ChartWindow" "plot-chart-window" "y-axis"]

  @;################################
  @subsection{Bar Chart Window}

  @constructor-doc["ChartWindow" "bar-chart-window" opaque ChartWindow]{
    A bar chart window.
  }
  @method-doc["ChartWindow" "bar-chart-window" "y-min"]
  @method-doc["ChartWindow" "bar-chart-window" "y-max"]
  @method-doc["ChartWindow" "bar-chart-window" "x-axis"]
  @method-doc["ChartWindow" "bar-chart-window" "y-axis"]

  @;################################
  @subsection{Pie Chart Window}

  @constructor-doc["ChartWindow" "pie-chart-window" opaque ChartWindow]{
    A pie chart window.
  }

  @;################################
  @subsection{Histogram Chart Window}

  @constructor-doc["ChartWindow" "histogram-chart-window" opaque ChartWindow]{
    A histogram chart window.
  }
  @method-doc["ChartWindow" "histogram-chart-window" "x-min"]
  @method-doc["ChartWindow" "histogram-chart-window" "x-max"]
  @method-doc["ChartWindow" "histogram-chart-window" "y-max"]
  @method-doc["ChartWindow" "histogram-chart-window" "x-axis"]
  @method-doc["ChartWindow" "histogram-chart-window" "y-axis"]
}
