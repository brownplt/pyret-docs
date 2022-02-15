#lang scribble/manual
@(require "../../scribble-api.rkt" "../abbrevs.rkt")
@(require (only-in scribble/core delayed-block))

@(define (in-link T) (a-id T (xref "chart" T)))
@(define (in-image f) (image (string-append "src/trove/chart-images/" f ".png") #:scale 0.4))
@(define Self A)
@(define Color (a-id "Color" (xref "color" "Color")))
@(define Image (a-id "Image" (xref "image" "Image")))
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

@(define horizontal-meth
  `(method-spec
    (name "horizontal")
    (arity 2)
    (params ())
    (args ("self" "horizontal"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,N ,DataSeries))
    (doc ("Construct a new " ,DataSeries " that will be displayed horizontally. "
          "By default, box-plot-series will display vertically."))))

@(define show-outliers-meth
  `(method-spec
    (name "show-outliers")
    (arity 2)
    (params ())
    (args ("self" "show-outliers"))
    (return ,DataSeries)
    (contract (a-arrow ,Self ,N ,DataSeries))
    (doc ("Construct a new " ,DataSeries " that will display outliers "
          "as small circles, beyond the whiskers of a box-plot. When the "
          "value is false, the whiskers will be extended to the full "
          "range of the dataset. Note: the default value is true."))))

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

@(define min-meth
  `(method-spec
    (name "min")
    (arity 2)
    (params ())
    (args ("self" "min"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,N ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new window dimension where "
          "min is changed. By default, the value will be inferred."))))

@(define max-meth
  `(method-spec
    (name "max")
    (arity 2)
    (params ())
    (args ("self" "max"))
    (return ,ChartWindow)
    (contract (a-arrow ,Self ,N ,ChartWindow))
    (doc ("Construct a new " ,ChartWindow " with a new window dimension where "
          "max is changed. By default, the value will be inferred."))))

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
    (fun-spec (name "from-list.freq-bar-chart") (arity 1))
    (fun-spec (name "from-list.pie-chart") (arity 2))
    (fun-spec (name "from-list.exploding-pie-chart") (arity 3))
    (fun-spec (name "from-list.histogram") (arity 2))
    (fun-spec (name "from-list.labeled-histogram") (arity 3))
    (fun-spec (name "from-list.box-plot") (arity 2))
    (fun-spec (name "from-list.labeled-box-plot") (arity 3))
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
      (with-members ()))
    (constr-spec
      (name "pie-chart-series")
      (with-members ()))
    (constr-spec
      (name "histogram-series")
      (with-members (,bin-width-meth ,max-num-bins-meth ,min-num-bins-meth
                     ,num-bins-meth)))
    (constr-spec
      (name "box-plot-series")
      (with-members (,horizontal-meth ,show-outliers-meth)))
    (data-spec
      (name "DataSeries")
      (type-vars ())
      (variants ("function-plot-series" "line-plot-series" "scatter-plot-series"
                 "bar-chart-series" "pie-chart-series" "histogram-series"
                 "box-plot-series"))
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
      (name "box-plot-chart-window")
      (with-members (,min-meth ,max-meth)))
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
    }
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
    }
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
    }
  }

  @function["from-list.labeled-scatter-plot"
    #:contract (a-arrow (L-of S) (L-of N) (L-of N) DataSeries)
    #:args '(("labels" #f) ("xs" #f) ("ys" #f))
    #:return (a-pred DataSeries (in-link "scatter-plot-series"))
  ]{

    Constructing a scatter plot series from @pyret{xs} and @pyret{ys}, representing x and y
    coordinates of points, and @pyret{labels} whose element representing a label for each point.
    See more details at @(in-link "scatter-plot-series").

    @examples{
a-series = from-list.labeled-scatter-plot(
  [list: "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"],
  [list: 0,   1,   2,   3,   6,   7,   10, 13,   16,  20],
  [list: 18,  2,   28,  9,   7,   29,  25, 26,   29,  24])
    }
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
# This data is obtained by randomization. They have no meaning whatsoever.
# (though we did run a few trials so that the result doesn't look egregious)
    }
  }

  @function["from-list.grouped-bar-chart"
    #:contract (a-arrow (L-of S) (L-of (L-of N)) (L-of S) DataSeries)
    #:args '(("labels" #f) ("value-lists" #f) ("legends" #f))
    #:return (a-pred DataSeries (in-link "bar-chart-series"))
  ]{

    Constructing a bar chart series. A @pyret{value-list} in @pyret{value-lists} is
    a list of numbers, representing bars in a label but with different legends. The length
    of @pyret{value-lists} must match the length of @pyret{labels}, and the length of each
    @pyret{value-list} must match the length of @pyret{legends}. See more details at
    @(in-link "bar-chart-series").

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
    }
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
    }
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
    }
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
    }
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
    }
  }

  @function["from-list.labeled-histogram"
    #:contract (a-arrow (L-of S) (L-of N) DataSeries)
    #:args '(("labels" #f) ("values" #f))
    #:return (a-pred DataSeries (in-link "histogram-series"))
  ]{
    Constructing a histogram series, grouping @pyret{values} into bins.
    Each element of @pyret{labels} is attached to the corresponding value in
    the bin. See more details at @(in-link "histogram-series").

    @examples{
a-series = from-list.labeled-histogram(
  range(1, 100).map(lam(x): "foo " + num-to-string(x) end),
  range(1, 100).map(lam(_): num-random(1000) end))
    }
  }

    @function["from-list.box-plot"
    #:contract (a-arrow (L-of (L-of N)) DataSeries)
    #:args '(("value-lists" #f))
    #:return (a-pred DataSeries (in-link "box-plot-series"))
  ]{
    Constructing a box-plot series from @pyret{value-lists}. 
    This series will contain two box-plots.

    @examples{
valuesA = range(1, 100).map(lam(_): num-random(1000) end)
valuesB = range(1, 100).map(lam(_): num-random(42) end)
a-series = from-list.box-plot([list: valuesA, valueB])
    }
  }

  @function["from-list.labeled-box-plot"
    #:contract (a-arrow (L-of S) (L-of (L-of N)) DataSeries)
    #:args '(("labels" #f) ("value-lists" #f))
    #:return (a-pred DataSeries (in-link "box-plot-series"))
  ]{
    Constructing a box-plot series from @pyret{value-lists}. 
    This series will contain two box-plots, labeled with strings
    from @pyret{labels}.

    @examples{
valuesA = range(1, 100).map(lam(_): num-random(1000) end)
valuesB = range(1, 100).map(lam(_): num-random(42) end)
labels = [list: "valuesA", "valuesB"]
a-series = from-list.box-plot(labels, [list: valuesA, valueB])
    }
  }

  @;############################################################################
  @section{DataSeries}

  @data-spec2["DataSeries" (list) (list
  @constructor-spec["DataSeries" "function-plot-series" opaque]
  @constructor-spec["DataSeries" "line-plot-series" opaque]
  @constructor-spec["DataSeries" "scatter-plot-series" opaque]
  @constructor-spec["DataSeries" "bar-chart-series" opaque]
  @constructor-spec["DataSeries" "pie-chart-series" opaque]
  @constructor-spec["DataSeries" "histogram-series" opaque]
  @constructor-spec["DataSeries" "box-plot-series" opaque]
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

  @method-doc["DataSeries" "function-plot-series" "color"]
  @method-doc["DataSeries" "function-plot-series" "legend"]

  @examples{
NUM_E = ~2.71828
f-series = from-list.function-plot(lam(x): 1 - num-expt(NUM_E, 0 - x) end)
  .color(C.orange)
  .legend("My legend")
render-chart(f-series).display()
  }
  @(in-image "function-plot")

  @;################################
  @subsection{Line Plot Series}

  @constructor-doc["DataSeries" "line-plot-series" opaque DataSeries]{
    A line plot series
  }

  @method-doc["DataSeries" "line-plot-series" "color"]
  @method-doc["DataSeries" "line-plot-series" "legend"]

  @examples{
a-series = from-list.line-plot(
  [list: 0,  1, 2,  3, 6, 7,  10, 13, 16, 20],
  [list: 18, 2, 28, 9, 7, 29, 25, 26, 29, 24])
  .color(C.orange)
  .legend("My legend")
render-chart(a-series).display()
  }
  @(in-image "line-plot")

  @;################################
  @subsection{Scatter Plot Series}

  @constructor-doc["DataSeries" "scatter-plot-series" opaque DataSeries]{
    A scatter plot series. If a data point has a label, then hovering over the
    point in the interactive dialog will show the label.
  }

  @method-doc["DataSeries" "scatter-plot-series" "color"]
  @method-doc["DataSeries" "scatter-plot-series" "legend"]
  @method-doc["DataSeries" "scatter-plot-series" "point-size"]

  @examples{
a-series = from-list.labeled-scatter-plot(
  [list: "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"],
  [list: 0,   1,   2,   3,   6,   7,   10, 13,   16,  20],
  [list: 18,  2,   28,  9,   7,   29,  25, 26,   29,  24])
  .color(C.orange)
  .legend("My legend")
render-chart(a-series).display()
  }
  @(in-image "scatter-plot")

  @;################################
  @subsection{Bar Chart Series}

  @constructor-doc["DataSeries" "bar-chart-series" opaque DataSeries]{
    A bar chart series. In a label, there could be several bars.
  }

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

  @;################################
  @subsection{Box-Plot Series}

  @constructor-doc["DataSeries" "box-plot-series" opaque DataSeries]{
    A box-plot series. Note: this series can contain multiple box-plots!
  }

  @method-doc["DataSeries" "box-plot-series" "horizontal"]
  @method-doc["DataSeries" "box-plot-series" "show-outliers"]

@examples{
a-series = from-list.box-plot(range(1, 100))
render-chart(a-series).display()
  }

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
    @item{@in-link{pie-chart-series} creates a @in-link{pie-chart-window}}
    @item{@in-link{histogram-series} creates a @in-link{histogram-chart-window}}
    @item{@in-link{box-plot-series} creates a @in-link{box-plot-chart-window}}
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
  @constructor-spec["ChartWindow" "box-plot-chart-window" opaque]
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

    @;################################
  @subsection{Box-Plot Chart Window}

  @constructor-doc["ChartWindow" "box-plot-chart-window" opaque ChartWindow]{
    A box-plot chart window.
  }
  @method-doc["ChartWindow" "box-plot-chart-window" "min"]
  @method-doc["ChartWindow" "box-plot-chart-window" "max"]
}
