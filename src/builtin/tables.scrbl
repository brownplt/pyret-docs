#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(append-gen-docs
  '(module "tables"
    (path "src/js/base/runtime-anf.js")
    (fun-spec
      (name "difference-from"))
    (fun-spec
      (name "running-fold"))
    (fun-spec
      (name "running-reduce"))
    (data-spec
      (name "Table")
      (variants)
      (shared))
    (data-spec
      (name "Reducer")
      (type-vars ("Acc" "InVal" "OutVal"))
      (variants ("reducer"))
      (shared (
        (method-spec (name "reduce"))
        (method-spec (name "one")))))))

@(define (Red-of acc in result) (a-app (a-id "Reducer" (xref "tables" "Reducer")) acc in result))
@(define (red-method name #:args args #:return ret #:contract contract)
  (method-doc "Reducer" "reducer" name #:alt-docstrings "" #:args args #:return ret #:contract contract))
@(define Red-params (list "Acc" "InVal" "OutVal"))

@docmodule["tables" #:noimport #t #:friendly-title "Tables"]{

There are many examples of tables in computing, with
spreadsheets being the most obvious.
                                                             
A @pyret{Table} is made up of @bold{rows} and @bold{columns}. All rows have
 the same number of columns, in the same order. Each column has a name.
 Each column may also be assigned a type via an annotation; if so, all
 entries in a column will then be checked against the annotation.

@margin-note{Note that as of June 2017, the @pyret{tables} implementation in
is rather minimal.  It meets the basic requirements of the curricula that
use it, but lacks many features that one might reasonably expect from a
complete table library.

Additionally, after the first year of using @pyret{tables}, the Pyret team
is considering a new table design and interface that will make it easier
to add features in the future, but in the meantime puts small changes
to the current design on hold.

Tabular data is here to stay in Pyret and Pyret-related curricula, so
count on further development of @pyret{tables}.}
  
  @section[#:tag "s:tables"]{Creating Tables}

A simple @pyret{Table} can be directly created with a @pyret{table:}
expression, which lists any number of
columns, with optional annotations, and then any number of rows.  For example,
this expression creates a table with three columns, @pyret{name}, @pyret{age},
and @pyret{favorite-color}, and three rows:

  @examples{
my-table = table: name :: String, age :: Number, favorite-color :: String
  row: "Bob", 12, "blue"
  row: "Alice", 17, "green"
  row: "Eve", 13, "red"
end
  }

Entering the name of a table in the interactions window after running the program
or using the @pyret{print} function will display a formatted version of the table.

@(image "src/builtin/table-print.png")
  
@margin-note{Note that @pyret{my-table} is referred to in many of the
following examples.}

  @section[#:tag "s:tables:loading"]{Loading Tables}

Pyret supports loading spreadsheets from Google Sheets and
interpreting them as Pyret tables.

Currently no public interface for creating additional sources
beyond Google Sheets is supported.

You can import most relevant file types, including .xlsx,
into Google Sheets, and then into Pyret, so you should be able to
get almost any tabular data into Pyret with a little effort.

@margin-note{In Google Sheets, you create a file, referred to as a
"spreadsheet" that contains one or more grids called
"sheets."  Excel refers to the file as a "workbook" and each
grid as a "worksheet."  We will follow Google Sheets'
nomenclature.}

Pyret assumes each sheet contains only one table of neatly formatted
data, without skipping columns or extra comments other than an
optional single header row at the top.

As a simple and consistent example, let's say we wanted to import the
@tt{my-table} data from a spreadsheet.

@(image "src/builtin/gsheet-1.png")

To import this data into a Pyret program, you need to get the
spreadsheet's
unique Google ID.  The easiest way to do this is to click
on the blue @tt{Share} button in the upper right.

@(image "src/builtin/gsheet-2.png")

If you don't
want to share your spreadsheet with anyone else, click
@tt{Advanced} in the lower right of the @tt{Share with others}
dialog, then copy the @tt{Link to share}, highlighted in orange below,
and paste it into your Pyret definitions area (or another editor).

@(image "src/builtin/gsheet-3.png")

The URL will look something like

@tt{https://docs.google.com/spreadsheets/d/1BAexzf08Q5o8bXb_k8PwuE3tMKezxRfbKBKT-4L6UzI/edit?usp=sharing}

The Google ID is the part between @tt{/d/} and @tt{/edit...}, in this case:

@tt{1BAexzf08Q5o8bXb_k8PwuE3tMKezxRfbKBKT-4L6UzI}

@margin-note{If you do want to share the spreadsheet with others, click
on the blue @tt{Share} button as above, and then click
@tt{Get sharable link}, choose the appropriate level of
sharing, and copy the URL to get the Google ID as above.}

Now you can load the spreadsheet into your Pyret program:

@examples{
import gdrive-sheets as GS

imported-my-table = 
  GS.load-spreadsheet("1BAexzf08Q5o8bXb_k8PwuE3tMKezxRfbKBKT-4L6UzI")
}

You can use @pyret{include} instead of @pyret{import as...} to cut down on
some typing by omitting the @tt{GS.} before the @pyret{tables} module
functions.

@examples{
include gdrive-sheets

imported-my-table = 
  load-spreadsheet("1BAexzf08Q5o8bXb_k8PwuE3tMKezxRfbKBKT-4L6UzI")
}
@margin-note{We'll use
@pyret{import} and the prefix @tt{GS.} in the following examples.  If you
use @pyret{include}, omit @tt{GS.} where used below.}

When data is loaded into a table, we recommend using @italic{sanitizers} 
to properly load each entry of the table as the correct Pyret type.  The
supported sanitizers are imported from the @pyret{data-source} module.

The sanitizers currently provided by Pyret are:

@itemlist[@item{@bold{string-sanitizer} tries to convert anything to a @pyret{String}}
@item{@bold{num-sanitizer} tries to convert  numbers, strings and booleans to @pyret{Number}s}
@item{@bold{bool-sanitizer} tries to convert numbers, strings and booleans to @pyret{Boolean}s} 
@item{@bold{strict-num-sanitizer} tries to convert numbers and strings (not booleans) to @pyret{Number}s}
@item{@bold{strings-only} converts only strings to @pyret{String}s}
@item{@bold{numbers-only} converts only numbers to @pyret{Number}s}
@item{@bold{booleans-only} converts only booleans to @pyret{Booleans}s}
@item{@bold{empty-only} converts only empty cells to @pyret{none}s}]

@margin-note{While the @tt{data-source} library provides sanitizers which should cover
most use cases, there may be times when one would like to create a custom
data sanitizer. To do so, one must simply create a function which conforms
to the @pyret{Sanitizer<A,B>} type in the @tt{data-source} module.}

Use the @pyret{load-table:} expression to create a table from an
imported sheet.

Each spreadsheet file contains multiple, named sheets, displayed
as tabs across the bottom of the Sheets user interface.  When you start
working with the data in an imported spreadsheet, you need to indentify
which sheet you are using as the data source.

The @pyret{source:} expression should be followed by the imported spreadsheet,
calling the @pyret{.sheet-by-name()} method with two arguments, the sheet name and
a boolean flag indicating whether or not there is a header row in the sheet
that should be ignored.  In our example above,  @tt{imported-my-table} contains
one sheet, called @tt{3-rows},
and there is a header row that should be ignored by the importer, so the
@pyret{source:} expression would be written as illustrated below.

@examples{
import gdrive-sheets as GS
import data-source as DS

imported-my-table = 
  GS.load-spreadsheet("1BAexzf08Q5o8bXb_k8PwuE3tMKezxRfbKBKT-4L6UzI")

my-table = load-table: name :: String, age :: Number, favorite-color :: String
  source: imported-my-table.sheet-by-name("3-rows", true)
  sanitize name using DS.string-sanitizer
  sanitize age using DS.strict-num-sanitizer
  sanitize favorite-color using DS.string-sanitizer
end
}

In general, it is @italic{safest} to sanitize @italic{every} input column, since it
is the only way to guarantee that the data source will not guess the column's
type incorrectly.

Note that Google Sheets, and other spreadsheets, themselves 
assign or infer types to data in a way that often is not apparent to the user
and is a common source of errors when exporting from or between spreadsheet
applications.

  @section[#:tag "s:tables:select"]{Selecting Columns}

The @pyret{select} expression can be used to create a new table from a subset
of the columns of an existing one.  For example, we can get just the names
and ages from @pyret{my-table} above:

@examples{
names-and-ages = select name, age from my-table end
check:
  names-and-ages is table: name, age
    row: "Bob", 12
    row: "Alice", 17
    row: "Eve", 13
  end
end
}

  @section{Filtering Tables}

The @pyret{sieve} mechanism allows for filtering out rows of tables based
on some criteria. The @pyret{using} keyword specifies which columns may be
used in the body of the @pyret{sieve} expression.

For instance, we can find the individuals in @pyret{my-table} who are old
enough to drive in the United States.

@pyret-block[#:style "good-ex"]{
can-drive = sieve my-table using age:
  age >= 16
end
check:
  can-drive is table: name, age, favorite-color
    row: "Alice", 17, "green"
  end
end
}

Note that the @pyret{sieve} block must explicitly list the columns used to
filter out values with @tt{using}.  The following would signal an undefined
name error for @pyret{age}, because names being used in the expression body
must be listed:

@pyret-block[#:style "bad-ex"]{
can-drive = sieve my-table using name:
  # age is not visible inside of this expression
  age >= 16
end
}

  @section{Ordering Tables}

To arrange the rows of a table in some particular order, use an @pyret{order}
expression.  This can be done with any column whose
type supports the use of @pyret{<} and @pyret{>}, including @pyret{String}s. 

@examples{
name-ordered = order my-table:
  name ascending
end
check:
  name-ordered is table: name, age, favorite-color
    row: "Alice", 17, "green"
    row: "Bob", 12, "blue"
    row: "Eve", 13, "red"
  end
end
}

  @section{Transforming Tables}

The @pyret{transform} expression allows the changing of columns within a
table, similar to the @pyret{map} function over lists (and, just like
@pyret{map}, @pyret{transform} expressions do not mutate the table, but
instead return a new one).

Suppose we find out that @pyret{my-table} is wrong and everyone is actually
a year older than it says they are. We can fix our data as follows:
@pyret-block{
age-fixed = transform my-table using age:
  age: age + 1
end
check:
  age-fixed is table: name, age, favorite-color
    row: "Bob", 13, "blue"
    row: "Alice", 18, "green"
    row: "Eve", 14, "red"
  end
end
}


@section{Extracting Columns from Tables}

A large number of Pyret modules work on @seclink{lists} instead of tables, so it
may be desired to pull the contents of one column of a table as a list to
use it elsewhere. The @pyret{extract} mechanism allows this ability, and
serves as the primary link between processing tabular data and non-tabular
Pyret functions.

Suppose, for example, we wanted just the names of each person in
@pyret{my-table}. We could pull those names out as follows:
@pyret-block{
name-list = extract name from my-table end
check:
  name-list is [list: "Bob", "Alice", "Eve"]
end
}

@section{Extending Tables}

"Extending" a table means to create a new table with an additional,
calculated column. There are two types of extensions which can be
made to tables: mapping extensions and reducing extensions.

@subsection{Mapping extensions}

A mapping column is one whose contents are calculated from other
columns only in the row it is being added to.  This is analogous
to the map function for @seclink{lists}.

In a mapping expression, the body of the expression defines the name of
the new column or columns followed by an expression which calculates
the new value to be placed in each row of the new column.

One example of this is a column which tells
whether the @pyret{age} field of a given row in @pyret{my-table} indicates
that the person in that row is old enough drive in the United States or not,
that is, whether that person is at least 16:
@examples{
can-drive-col = extend my-table using age:
  can-drive: age >= 16
end
check:
  can-drive-col is table: name, age, can-drive
    row: "Bob", 12, false
    row: "Alice", 17, true
    row: "Eve", 13, false
  end
end
}

Another example creates a new table including baseball players'
calculated batting average and slugging percentage in extended
columns:

@examples{
batting = table: batter :: String, 
  at-bats :: Number, singles :: Number, doubles :: Number, 
  triples :: Number, home-runs :: Number
  row: "Julia", 20, 4, 2, 0, 0
  row: "Vivian", 25, 6, 1, 1, 1
  row: "Eddie", 28, 5, 2, 0, 2
end
batting-avg-and-slugging = extend batting 
  using at-bats, singles, doubles, triples, home-runs:
  batting-average: (singles + doubles + triples + home-runs) / at-bats,
  slugging-percentage: (singles + (doubles * 2) + 
    (triples * 3) + (home-runs * 4)) / at-bats
end
}

@(image "src/builtin/baseball.png")

@margin-note{As in @seclink["s:tables:transform"]{@pyret{transform}},
you must specify which columns will be used to calculate the
value in the 
@pyret{extend} expression using the @pyret{using} keyword.}


@subsection{Reducers}

A "reducing" column is one whose information is computed from the
row it is being added to @italic{and one or more of the rows above}
that row.  This is
analogous to the @pyret{fold} function for @seclink{lists}.

The simplest examples of reducing use reducers built into Pyret.

FOr each reducer below, you will need to specify
a name for the new column and which existing column new value
will be based on.  You will also need to
@pyret{import} or @pyret{include} @pyret{tables}.

@value["running-sum" (Red-of N N N)]

Creates a new column where in each row,
the running sum will be the added
value of the cell in the selected column plus all the cells
@italic{above} the cell in the same column.

@examples{
import tables as T
dem-primary-delegates = table: state :: String, clinton :: Number, 
  sanders :: Number
  row: "Iowa", 29, 21
  row: "New Hampshire", 15, 16
  row: "Nevada", 27, 16
  row: "South Carolina", 44, 14
end
running-total-delegates = extend dem-primary-delegates 
  using clinton, sanders:
  total-clinton: T.running-sum of clinton,
  total-sanders: T.running-sum of sanders
end
print(running-total-delegates)
}

@(image "src/builtin/primaries.png")

@value["difference" (Red-of N N N)]{

The @pyret{difference} extender creates a new column 
containing the difference between the value in
the current row (of the selected column) minus the value in @italic{only}
the row directly above.  In the first row, the value is unchanged.
Since there's no value before the first row, Pyret behaves as if it were zero.

@margin-note{Both @pyret{difference} and @pyret{difference-from} do
@italic{not} calculate a running difference, only the difference between
the selected row and the single row above.}

@examples{
import tables as T
test-scores = table: year :: Number, 
  math-score :: Number, reading-score :: Number
  row: 2014, 87, 89
  row: 2015, 98, 93
  row: 2016, 79, 83
  row: 2017, 85, 90
end
changes-by-year = extend test-scores using math-score, reading-score:
  math-change-from-previous: T.difference of math-score,
  reading-change-from-previous: T.difference of reading-score
end
}
@(image "src/builtin/difference-table.png")                           
}

@function["difference-from"
  #:contract (a-arrow N (Red-of N N N))
  #:args '(("start-value" #f))
  #:return (Red-of N N N)]{

Like @pyret{difference}, except the starting value is specified, instead
of defaulting to 0.

@examples{
# calculates velocity of a dropping ball
ball-info = table: pos-y
  row: 25
  row: 24
  row: 21
  row: 16
  row: 0
end
with-velocity = extend ball-info using pos-y:
  vel-y: T.difference-from(25) of pos-y
end
check:
  with-velocity is table: pos-y, vel-y
    row: 25, 0
    row: 24, -1
    row: 21, -3
    row: 16, -5
    row: 0, -16
  end
end
}

}

@value["running-mean" (Red-of N N N)]

Creates a new column  where the
value in each row is equal to the
mean of @italic{all} values in the designated column in the current row and
above.

@examples{
import tables as T
my-grades = table: score :: Number
  row: 87
  row: 91
  row: 98
  row: 82 
end
with-running-mean = extend my-grades
  using score:
  mean: T.running-mean of score
end
check:
  with-running-mean is table: score, mean
    row: 87, 87
    row: 91, 89
    row: 98, 92
    row: 82, 89.5
  end
end
}

@value["running-max" (Red-of N N N)]
@value["running-min" (Red-of N N N)]

Creates a new column that contains the maximum
or minimum value in the selected column in the current row or
above.

@examples{
some-numbers = table: n :: Number
  row: 4
  row: 9
  row: 3
  row: 1
  row: 10
end
with-min-max = extend some-numbers using n:
  max: T.running-max of n,
  min: T.running-min of n
end
check:
  with-min-max is table: n, max, min
    row: 4, 4, 4
    row: 9, 9, 4
    row: 3, 9, 3
    row: 1, 9, 1
    row: 10, 10, 1
  end
end
}


@function["running-fold"
  #:contract (a-arrow "Result" (a-arrow "Result" "Col" "Result") (Red-of "Result" "Col" "Result"))
  #:args '(("start-value" #f) ("combiner" #f))
  #:return (Red-of "Result" "Col" "Result")]{}

@function["running-reduce"
  #:contract (a-arrow (a-arrow "Col" "Col" "Col") (Red-of "Col" "Col" "Col"))
  #:args '(("combiner" #f))
  #:return (Red-of "Col" "Col" "Col")]
                                            
@pyret{running-fold} and @pyret{running-reduce} allow you
to specify a function used to calculate
the value in the new column, based on a running calculation of all the
values in the selected column in the current row and above.

The difference between @pyret{running-fold} and @pyret{running-reduce} is
that @pyret{running-fold} requires an explicit @tt{start-value}.
                                            
@examples{
import tables as T
count-if-driver = T.running-fold(0,
  lam(sum, col): if col >= 16: 1 + sum else: sum end end)
t = table: name, age
  row: "Bob", 17
  row: "Mary", 22
  row: "Jane", 6
  row: "Jim", 15
  row: "Barbara", 30
end
with-driver-count = extend t using age:
  total-drivers: count-if-driver of age
end
check:
  with-driver-count is table: name, age, total-drivers
    row: "Bob", 17, 1
    row: "Mary", 22, 2
    row: "Jane", 6, 2
    row: "Jim", 15, 2
    row: "Barbara", 30, 3
  end
end

checks = table: check-number :: Number, withdrawal :: Number
  row: 001, 50
  row: 002, 100
  row: 003, 500
end
with-checking-balance = extend checks using withdrawal:
  current-balance: T.running-fold(1000,
    lam(total, col): total - col end) of withdrawal
end
check:
  with-checking-balance is table: check-number, withdrawal, current-balance
    row: 001, 50, 950 
    row: 002, 100, 850
    row: 003, 500, 350
  end
end

}

While the reducers found in the @tt{tables} module should cover most all
use cases, there may be times when one would like to create a reducer of their
own. To do so, one must construct an object of the following type:                                          

@type-spec["Reducer" (list "Acc" "InVal" "OutVal")]
@red-method["one"
  #:contract (a-arrow (apply Red-of Red-params) "InVal" (a-tuple "Acc" "OutVal"))
  #:args '(("self" #f) ("value-from-column" #f))
  #:return (a-tuple "Acc" "OutVal")]
@red-method["reduce"
  #:contract (a-arrow (apply Red-of Red-params) "Acc" "InVal" (a-tuple "Acc" "OutVal"))
  #:args '(("self" #f) ("accumulator" #f) ("value-from-column" #f))
  #:return (a-tuple "Acc" "OutVal")]


Reducers are essentially descriptions of folds (in the list @pyret{fold}
sense) over table columns. The way reducers are called by the language
runtime is as follows: the value(s) from the first row are passed to the
reducer's @pyret{.one} method, which should return a tuple containing both
any accumulated information needed for the fold and the value which should
be placed in the new column in that row. The remaining rows are then
sequentially populated using the reducer's @pyret{.reduce} method, which is
identical to the @pyret{.one} method except that it receives an additional
argument which is the previously mentioned accumulated information from the
previous row.

To illustrate, a @pyret{running-mean} reducer which is equivalent to the
one provided by the @tt{tables} module could be implemented as follows:
@examples{
import tables as T
running-mean :: T.Reducer<{Number; Number}, Number, Number> = {
  one: lam(n): {{n; 1}; n} end,
  reduce: lam({sum; count}, n):
    { {sum + n; count + 1}; (sum + n) / (count + 1) }
  end
}
}



  @section[#:tag "s:tables:comparing"]{Comparing Tables}

The order of both rows and columns are part of a table value.  To be considered
equal, tables need to have all the same rows and columns, with the rows and
columns appearing in the same order.





}