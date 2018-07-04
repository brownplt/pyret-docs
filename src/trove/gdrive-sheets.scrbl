#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(append-gen-docs
  `(module "gdrive-sheets"
    (path "src/js/trove/gdrive-sheets.js")
    (fun-spec (name "create-spreadsheet") (arity 1))
    (fun-spec (name "my-spreadsheet") (arity 1))
    (fun-spec (name "load-spreadsheet") (arity 1))
    (fun-spec (name "open-sheet") (arity 3))
    (fun-spec (name "open-sheet-by-index") (arity 3))
    (data-spec
      (name "Spreadsheet")
      (type-vars)
      (variants)
      (shared (
        (method-spec (name "sheet-list"))
        (method-spec (name "sheet-by-name"))
        (method-spec (name "sheet-by-index"))
        (method-spec (name "delete-sheet-by-name"))
        (method-spec (name "delete-sheet-by-index"))
        (method-spec (name "add-sheet"))
        )))
    (data-spec
      (name "Worksheet")
      (type-vars)
      (variants)
      (shared ()))
  ))

@(define (ss-method name #:args args #:return ret #:contract contract)
  (method-doc "Spreadsheet" #f name #:alt-docstrings "" #:args args #:return ret #:contract contract))
@(define (ws-method name #:args args #:return ret #:contract contract)
  (method-doc "Worksheet" #f name #:alt-docstrings "" #:args args #:return ret #:contract contract))
@(define SS (a-id "Spreadsheet" (xref "gdrive-sheets" "Spreadsheet")))
@(define WS (a-id "Worksheet" (xref "gdrive-sheets" "Worksheet")))

@docmodule["gdrive-sheets"]{
@section{The Spreadsheet Type}
@type-spec["Spreadsheet" '()]{
@pyret-id{Spreadsheet}s represent a connection to a Google Sheets document.
These spreadsheets are primarily used to create a @pyret{Table},
using the @seclink["s:tables:loading"]{@pyret{load-table:} syntax} and the
@pyret-method["Spreadsheet" "sheet-by-name"] method below.  However, the
spreadsheet values themselves can be useful to @emph{create or modify} Google
Sheets documents, as well.
}
@section{The Worksheet Type}
@type-spec["Worksheet" '()]{
@pyret-id{Worksheet}s represent individual worksheets within a Google Sheets
document.  Nothing can be done directly with worksheets in Pyret, except to
load them into tables.
}

@section{Spreadsheet Functions}
@function["create-spreadsheet"
  #:contract (a-arrow S SS)
  #:args '(("name" ""))
  #:return SS
  ]{
  Creates a new Google Sheets document with the given name, in the currently
  logged-in user's Google Documents account.  The newly created file will not
  yet have any worksheets in it.
  }

@function["my-spreadsheet"
  #:contract (a-arrow S SS)
  #:args '(("name" ""))
  #:return SS
  ]{
  Accesses a private Google Sheets file and produces a @pyret-id{Spreadsheet}.
  If the file is ever shared, change code that uses this function to instead
  call @pyret-id{load-spreadsheet} below.
  }

@function["load-spreadsheet"
  #:contract (a-arrow S SS)
  #:args '(("id" ""))
  #:return SS
  ]{
  Accesses a publicly shared Google sheets file and produces a
  @pyret-id{Spreadsheet}.  This function is more commonly used than
  @pyret-id{my-spreadsheet}.
  }

@function["open-sheet"
  #:contract (a-arrow SS S B WS)
  #:args '(("spreadsheet" "") ("name" "") ("skipHeaders" ""))
  #:return WS
  ]{
  Obtains the @pyret-id{Worksheet} of the given name from the given
  @pyret-id{Spreadsheet}.  Since worksheets commonly contain a @emph{header row}
  with names describing the contents of each column, the last parameter tells
  Pyret whether to ignore the first row when extracted the data from the
  worksheet into a table.  This function is a shortcut for using
  @pyret-id{load-spreadsheet} followed by the @pyret-method["Spreadsheet"
  "sheet-by-name"] method.  See @secref["s:tables:loading"] for more information.
  }

@function["open-sheet-by-index"
  #:contract (a-arrow SS N B WS)
  #:args '(("spreadsheet" "") ("index" "") ("skipHeaders" ""))
  #:return WS
  ]{
  Much like @pyret-id{open-sheet}, except it selects the worksheet by its index
  within the file, with 0 being the first worksheet in the file.  This function
  is a shortcut for using @pyret-id{load-spreadsheet} followed by the
  @pyret-method["Spreadsheet" "sheet-by-index"] method.
  }

@section{Spreadsheet Methods}
@ss-method["sheet-list"
  #:contract (a-arrow SS (L-of S))
  #:args (list (list "self" #f))
  #:return (L-of S)
]
XXX: This is not a method.  Contains the list of worksheet names in this
@pyret-id{Spreadsheet},  in order from left to right.  The names in this list
can be used with @pyret-method["Spreadsheet" "sheet-by-name"], and the indices
of names in this list can be used with @pyret-method["Spreadsheet" "sheet-by-index"].

@ss-method["sheet-by-name"
  #:contract (a-arrow SS S B WS)
  #:args '(("self" #f) ("name" "") ("skipHeaders" ""))
  #:return WS
]
Obtains a @pyret-id{Worksheet} of the given name from the given worksheet.  The
@pyret{skipHeaders} argument specifies whether to ignore the first row of the
sheet when extracting its contents as a table (i.e. to treat the first row as a
header row rather than a data row).

@ss-method["sheet-by-index"
  #:contract (a-arrow SS N B WS)
  #:args '(("self" #f) ("index" "") ("skipHeaders" ""))
  #:return WS
]
Obtains a @pyret-id{Worksheet} of the given index (counting from 0) from the
given worksheet.  The @pyret{skipHeaders} argument specifies whether to ignore
the first row of the sheet when extracting its contents as a table (i.e. to
treat the first row as a header row rather than a data row).

@ss-method["delete-sheet-by-name"
  #:contract (a-arrow SS N No)
  #:args '(("self" #f) ("name" ""))
  #:return No
]
Deletes the worksheet of the given name from the Google Sheets document
corresponding to this @pyret-id{Spreadsheet}.

@ss-method["delete-sheet-by-index"
  #:contract (a-arrow SS N No)
  #:args '(("self" #f) ("index" ""))
  #:return No
]
Deletes the worksheet of the given index from the Google Sheets document
corresponding to this @pyret-id{Spreadsheet}.

@ss-method["add-sheet"
  #:contract (a-arrow SS S WS)
  #:args '(("self" #f) ("name" ""))
  #:return WS
]
Creates and inserts a new @pyret-id{Worksheet} into the Google Sheets document
corresponding to this @pyret-id{Spreadsheet}.


}
