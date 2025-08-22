#lang scribble/base

@(require "../../scribble-api.rkt")
@(append-gen-docs
  `(module "modules" (path #f)
    (form-spec (name "<id-import>"))
    (form-spec (name "file"))
    (form-spec (name "js-file"))
    (form-spec (name "url"))
    (form-spec (name "url-file"))
    (form-spec (name "my-gdrive"))
    (form-spec (name "shared-gdrive"))))

@docmodule["modules" #:noimport #t #:friendly-title "Modules"]{

As programs get larger, it becomes intractable to manage the entirety of a
program in a single file: we often want to separate programs into independent
pieces.  Doing so has a number of benefits, giving us the abilities to:

@itemlist[

@item{provide library code to students (unseen to them).}

@item{logically separate responsibilities of a program into different files
to make it easier for programmers to understand the code's layout.}

@item{provide a boundary over which it's relatively simple to substitute one
implementation of a library for another.}

@item{provide a boundary where the two sides may be implemented in different
languages, but can still share values.}

@item{provide only a subset of defined names to a different part of a
program.}

@item{manage names when the same (good) names may be in use in different
parts of the same program.}

@item{support incremental compilation.}

]

Not all of these require a module system, but a module system can help with all
of them, and these use cases (and others) motivate Pyret's.

This section describes the components of Pyret's module system and how to use
it.

@section[#:tag "s:modules:quick-start"]{Quick Start}

The shortest way to get started using the module system is to understand three
key ideas:

@itemlist[
@item{How to @emph{provide} names from a module}
@item{How to tell Pyret to @emph{locate} one module from a different module}
@item{How to @emph{include} names from a located module}
]

Here's a simple example that demonstrates all three.

In a file called @tt{list-helpers.arr}:

@pyret-block{
provide: * end

concat :: <A> List<A>, List<A> -> List<A>
fun concat(l1, l2):
  l.append(l1, l2)
end
}

In a file in the same directory called @tt{list-user.arr}:

@pyret-block{
include file("list-helpers.arr")

check:
  concat([list: 1, 2], [list: 3, 4]) is [list: 1, 2, 3, 4]
end
}

The @pyret{provide: * end} declaration tells Pyret to make @emph{all} the names of
functions and values defined in the @tt{list-helpers.arr} module available to
any module that imports it. The @pyret{include file("list-helper.arr")}
declaration tells Pyret to find the module at the path given in quotes, and
then make all the names it provides available in the top-level of the module
the @pyret{include} appears in.

In general, @pyret{include} and @pyret{provide: * end} are handy ways to provide a
collection of definitions to another context across modules.

Note that @pyret{provide: * end} only provides @emph{values}.  If you want to
provide @emph{type definitions}, then you may use a related declaration:

In a file called @tt{mypos-provider.arr}:

@pyret-block{
provide:
  *,       # This line provides `pos2d`, `pos3d`, `is-pos2d` and `is-pos3d`
  type *   # This line provides the type named `MyPos`
end

data MyPos:
  | pos2d(x, y)
  | pos3d(x, y, z)
end

favorite-spot = pos3d(3, 4, 5)
}

In a file in the same directory called @tt{mypos-user.arr}:

@pyret-block{
include file("mypos-provider.arr")

cases(MyPos) favorite-spot:
  | pos2d(x, y) => "Two dimensions"
  | pos3d(x, y, z) => "Three dimensions"
end
}

The @pyret{type *} declaration is needed for the @pyret{cases}
expression to recognize the name @pyret{MyPos} as a type name.

@section[#:tag "s:modules:finding-modules"]{Finding Modules}

Each @pyret{import} or @pyret{include} statement indicates a @deftech{dependency}
of the current module on some other module.  The syntax of each @pyret{import} and
@pyret{include} statement tells Pyret how to find the module.

There are currently five types of @tech{dependencies} supported, though the
compiler can be configured to support some, all, or other types of
@tech{dependency}; for example, the @seclink[(xref "modules" "my-gdrive")]{@pyret{gdrive} dependencies} (below) only
work in @url{code.pyret.org}, where it is assumed the user is authenticated to
Google Drive.

The meaning of the currently supported forms are:

@form["<id-import>" "<id-of-builtin>"]{
@pyret-block[#:style "good-ex"]{include string-dict}
Imports the given builtin module. Many built-in modules are documented in this
documentation.
}

@form["file" "file(<path>)"]{
@pyret-block[#:style "good-ex"]{include file("path/to/a/file.arr")}
Find the module at the given @pyret{path}. If @pyret{path} is relative, it is
interpreted relative to the module the import statement appears in.
}

@form["js-file" "js-file(<path>)"]{
@pyret-block[#:style "good-ex"]{include js-file("path/to/a/file.arr.js")}
Like @pyret{file}, but expects the contents of the file to contain a
definition in @seclink["s:single-module" "JavaScript module format"].
}

@form["my-gdrive" "my-gdrive(<name>)"]{
@pyret-block[#:style "good-ex"]{include my-gdrive("stored-in-gdrive.arr")}
Looks for a Pyret file with the given filename in the user's
@tt{code.pyret.org/} directory in the root of Google Drive.
}

@form["shared-gdrive" "shared-gdrive(<name>, <id>)"]{
@pyret-block[#:style "good-ex"]{include shared-gdrive("public-in-gdrive.arr", "ABCDEF12345")}
Looks for a Pyret file with the given id in Google Drive. The file must have
the sharing settings set to “Public on the Web”. The name must match the actual
name of the underlying file. These dependencies can be most easily generated by
using the “Publish” menu from @tt{code.pyret.org}
}

@form["url" "url(<url>)"]{
@pyret-block[#:style "good-ex"]{import url("https://raw.githubusercontent.com/brownplt/pyret-lang/refs/heads/horizon/tests/io-tests/tests/library-code.arr") as L}
Look for a Pyret file at the given URL. For loading files from URLs in the
browser (e.g. on code.pyret.org), the server must support
@hyperlink["https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS#simple_requests"]{simple
CORS}. From the command-line, any publicly available URL that serves Pyret code
in a text/plain response is an appropriate target.

Browsers, code.pyret.org, and command-line Pyret @emph{may} cache the result of
fetching a @tt{url} import in memory or on disk. As a result, @tt{url}
imports are @emph{not} recommended for resources that may frequently update
during development: use @pyret{url-file} for this. These are intended as easy-to-use import links for
starter code or library code for students who will likely not need to see or
change the code at the link.
}

@form["url-file" "url-file(<url>, <rel-path>)"]{
@pyret-block[#:style "good-ex"]{import url("https://raw.githubusercontent.com/brownplt/pyret-lang/refs/heads/horizon/tests/io-tests/tests/", "library-code.arr") as L}

If a file is present at the given @tt{<rel-path>}, the import acts just like a
@tt{file} import with the given @tt{<rel-path>} as the path. If no file is
present at this path, the import acts just like a @tt{url} import with the
concatenation of @tt{<url>} and @tt{<rel-path>} as the URL.

The intended use of @tt{url-file} is for developing starter code and library
code that students will access through URLs, while allowing the assignment
author to have a quick development process. Edits to the corresponding file
will be immediately seen on the next run when @tt{local-only} or
@tt{local-if-present} is set, avoiding the need to continuously publish in
order to see updates. In addition, in contrast to using plain @tt{file}
imports, the existing version of the program can be directly published without
needing to, for example, change all @tt{file} imports to @tt{url} imports.


The default behavior can be overridden with options:

@itemlist[
@item{@tt{remote-only}: The import acts just like a @tt{url} import with the concatenation of @tt{<url>} and @tt{<rel-path>} as the URL.}
@item{@tt{local-only}: The import acts just like a @tt{file} import with the given @tt{<rel-path>} as the path.}
@item{@tt{local-if-present}: }
]

At the command-line, the @tt{--url-file-mode} option can be one of these, and in
the Visual Studio Code Extension, this option can be set from the Pyret settings
menu.

}
@section{Detailed Control of Names}

In larger programs, or in more sophisticated libraries for students, it is
often useful to have quite precise control over which names are provided and
included across module boundaries. A programmer may want to provide only a
subset of the names defined in a module to maintain an abstraction, or to avoid
cluttering namespaces with definitions intended only for use internal to a
module.

To this end, Pyret supports several forms for controlling names of various
kinds:

@itemlist[
@item{@seclink["s:modules:import"]{Importing another module and referring
to it by name}.  This approach for name control is simple but syntactically
heavyweight on the importing side.}
@item{@seclink["s:modules:provide-fewer"]{More precisely exporting only a
subset of the values defined in a module}}
@item{@seclink["s:modules:provide-other"]{Providing other kinds of
definitions besides values}}
@item{@seclink["s:modules:provide-fewer"]{More precisely importing only a
subset of the values provided by a module}}
@item{@seclink["s:modules:provide-other"]{Importing other kinds of
definitions besides values}}
]

@section[#:tag "s:modules:import"]{@pyret{import} and Module Identifiers}

In @secref["s:modules:quick-start"] we showed @pyret{provide: * end} and
@pyret{include} @techlink[#:key "dependency"]{@emph{<dependency>}} as a quick
way to get names from one module to another. This is convenient and often a
good choice. However, there are situations where this is inadequate. For
example, what if we wish to use functions from two different list-helper
libraries, but some of the names overlap?

Consider:

@pyret-block{
# list-helpers.arr
provide: * end
fun concat(l1, l2): l1.append(l2) end
fun every-other(l): ... end
}

@pyret-block{
# list-helpers2.arr
provide: * end
concat :: <A> List<List<A>> -> List<A>
fun concat(list-of-lists):
  for fold(acc from empty, l from list-of-lists): acc.append(l) end
end
fun is-odd-length(l): ... end
}

@pyret-block{
# in a separate file
include file("list-helpers.arr")
include file("list-helpers2.arr")

concat(???)
}

In this example, the name @pyret{concat} could have one of two
meanings. Since this is ambiguous, this program results in an error that
reports the conflict between names.

Neither of the list-helpers modules is @emph{wrong}: they each define a
function named @pyret{concat} that is internally consistent within each helper
module.  Instead, the client module that uses both helpers
simply needs more control in order to use the right behavior from each. One way
to get this control is to use @pyret{import}, rather than @pyret{include},
which allows the programmer to give a name to the imported module. This name
can then be used with @pyret{.} to refer to the names within the imported
module.


@pyret-block{
import file("list-helpers.arr") as LH1
import file("list-helpers2.arr") as LH2

check:
  LH1.concat([list: 1, 2], [list: 3, 4]) is [list: 1, 2, 3, 4]
  LH2.concat([list: [list: 1, 2], [list: 3]]) is [list: 1, 2, 3]
end
}

Using @pyret{import} to define a module identifier is a simple way to unambiguously
refer to individual modules' exported names, and avoids conflicting names. It
is always a straightforward way to resolve these ambiguities.

Using @pyret{import} and module ids comes with some downsides:
@itemlist[
@item{It introduces verbosity, by forcing programmers to type @pyret{LH1.}
every time they want to use a name from that module.}
@item{In teaching settings, it forces teachers to
introduce the syntactic form @pyret{a.b} before it's strictly necessary, causing a
needless curricular dependency.}
]

For situations where these issues become too onerous, Pyret provides more ways
to control names.

@section[#:tag "s:modules:provide-fewer"]{Providing Fewer (and More) Names}

It is not required that a module provide @emph{all} of its defined names. To
provide fewer names than @pyret{provide: * end}, a module can use one or more
@deftech{provide blocks}. The overall set of features allowed is quite broad, and
simple examples follow:

@bnf['PyretModules]{
COLON: ":"
STAR: "*"
AS: "as"
PARENSPACE: "("
RPAREN: ")"
COMMA: ","
TYPE: "type"
DATA: "data"
MODULE: "module"
DOT: "."
HIDING: "hiding"
END: "end"
PROVIDECOLON: "provide:"
PROVIDE: "provide"
FROM: "from"
provide-block: PROVIDECOLON [provide-spec (COMMA provide-spec)* [COMMA]] END | ...

provide-spec: provide-value-spec | ...

name-spec: STAR [hiding-spec] | module-ref | module-ref AS NAME

provide-value-spec: name-spec

hiding-spec: HIDING PARENSPACE [(NAME COMMA)* NAME] RPAREN

module-ref: (NAME DOT)* NAME
}

A @tech{provide block} contains one or more @deftech{provide specifications}
indicating what to names supply, and any module may specify zero or more
provide blocks as needed.  For now we focus on just one category of
provide specifications, which provide names of values (functions, variables, etc.).

@itemlist[
@item{A module might provide all of its values:

@pyret-block{
provide:
  *
end
}

}

@item{A module might define several names of values, and only provide a few:

@pyret-block{
# A module that includes this one will only see concat and is-odd-length, and
# won't see concat-helper because it is not provided
provide:
  concat,
  is-odd-length
end

fun concat-helper(element, lst): ... end
fun concat(list1, list2): ... end
fun is-odd-length(l): ... end
}
}

@item{A module might provide all of its values and exclude a few:

@pyret-block{
# This module provides the same exports as the one above
provide:
  * hiding (concat-helper)
end

fun concat-helper(element, lst): ... end
fun concat(list1, list2): ... end
fun is-odd-length(l): ... end
}
}

@item{A module might rename some of the values it exports:

@pyret-block{
# This module provides two names: is-odd-length and append
provide:
  * hiding (concat-helper, concat),
  concat as append
end

fun concat-helper(element, lst): ... end
fun concat(list1, list2): ... end
fun is-odd-length(l): ... end
}
}
]

@subsection{Re-exporting values}
A module can also re-export values that it imported, and it can do so using
module ids:

@bnf['PyretModules]{
PROVIDE: "provide"
FROM: "from"
END: "end"
COLON: ":"
COMMA: ","
provide-block: ... | PROVIDE FROM module-ref COLON [provide-spec (COMMA provide-spec)* [COMMA]] END
}

For example, this module exports both one name it defines, and all the names
from @pyret{string-dict}:

@pyret-block{
import string-dict as SD
provide from SD: * end
provide: my-string-dict-helper end
fun my-string-dict-helper(): ... end
}


Combining provides from multiple modules can be an effective way to put
together a library for students. For example, an introductory course in data
science may benefit from a helper library that gives access to the image,
chart, and table libraries:

@pyret-block{
import tables as T
import chart as C
import image as I
provide from T: * end
provide from C: * end
provide from I: * end
}

A student library that @pyret{include}s this module would have access to all of
the names from these three modules.

@section[#:tag "s:modules:provide-other"]{Providing more than just values}

Modules can give names to other things besides values: they may define new
types or new datatypes, or they may import another module and give it a name.
The syntax above can be used to provide them as well.

@subsection{Types}
@bnf['PyretModules]{
COLON: ":"
STAR: "*"
AS: "as"
PARENSPACE: "("
RPAREN: ")"
COMMA: ","
TYPE: "type"
DATA: "data"
MODULE: "module"
DOT: "."
HIDING: "hiding"
END: "end"
PROVIDECOLON: "provide:"
PROVIDE: "provide"
FROM: "from"

provide-spec: ... | provide-type-spec | ...
provide-type-spec: TYPE name-spec
}

Providing a @seclink["s:type-decl"]{type definition} is analogous to providing a
value definition:

@pyret-block{
# A module that includes this one will see the name NumPair as a type
provide:
  type NumPair
end

type NumPair = {Number; Number}
}

Just as with @prod-link['PyretModules]{provide-value-spec} above, a
@prod-link['PyretModules]{provide-type-spec} can use @pyret{type *} as shorthand to
supply all of its types, optionally @pyret{hiding} some of them, or renaming
some types.
@subsection{Modules}

@bnf['PyretModules]{
COLON: ":"
STAR: "*"
AS: "as"
PARENSPACE: "("
RPAREN: ")"
COMMA: ","
TYPE: "type"
DATA: "data"
MODULE: "module"
DOT: "."
HIDING: "hiding"
END: "end"
PROVIDECOLON: "provide:"
PROVIDE: "provide"
FROM: "from"

provide-spec: ... | provide-module-spec | ...
provide-module-spec: MODULE name-spec
}

Providing a module id is also quite similar

@pyret-block{
# A module that includes this one will see the name SD as a module id,
# just as if it had written `import string-dict as SD` itself.
provide:
  module SD
end

import string-dict as SD
}
The ability to re-provide imported modules is useful for large programs, where
a single file can conveniently give access to all the submodules of the program.


@subsection{Data definitions}
@bnf['PyretModules]{
COLON: ":"
STAR: "*"
AS: "as"
PARENSPACE: "("
RPAREN: ")"
COMMA: ","
TYPE: "type"
DATA: "data"
MODULE: "module"
DOT: "."
HIDING: "hiding"
END: "end"
PROVIDECOLON: "provide:"
PROVIDE: "provide"
FROM: "from"

provide-spec: ... | provide-data-spec
provide-data-spec: DATA data-name-spec [hiding-spec]
data-name-spec: STAR | module-ref
}

Providing a @seclink["s:data-decl"]{data definition} is more sophisticated,
since data definitions implicitly define types and values.  The following two
programs are equivalent in meaning:

@pyret-block{
provide:
  data MyPosn
end

data MyPosn:
  | pos2d(x, y)
  | pos3d(x, y, z)
end
}

means the same thing as the much longer

@pyret-block{
provide:
  # constructors
  pos2d, pos3d,
  # type tester
  is-MyPosn,
  # variant testers
  is-pos2d, is-pos3d,
  # the type declaration itself
  type MyPosn
end

data MyPosn:
  | pos2d(x, y)
  | pos3d(x, y, z)
end
}

Similarly to how we could hide some names before, providing data definitions
also permits hiding names:

@pyret-block{
provide:
  data MyPosn hiding (pos2d, pos3d)
end

data MyPosn:
  | pos2d(x, y)
  | pos3d(x, y, z)
end
}

will not provide the constructors for this data definition.  Clients will
therefore not be able to construct new values of this data type, but they will
still be able to manipulate any values they do receive.  This can be useful in
combination with providing @emph{other} functions that do construct these
values.  For instance, the following program will only allow clients to
construct points with positive coordinates, by combining providing data, hiding
some elements of it, and providing other values and renaming them:

@pyret-block{
provide:
  data MyPosn hiding (pos2d, pos3d)
  smart-pos2d as pos2d,
  smart-pos3d as pos3d
end

data MyPosn:
  | pos2d(x, y)
  | pos3d(x, y, z)
end

fun smart-pos2d(x, y):
  pos2d(num-max(x, 0), num-max(y, 0))
end
fun smart-pos3d(x, y, z):
  pos2d(num-max(x, 0), num-max(y, 0), num-max(z, 0))
end
}

Clients of this module will see the "smart" versions of these functions with
the same names as the constructors, and will therefore never be able to
construct invalid values.

As with values and types, a module may use @pyret{data *} as a shorthand to
export all the data definitions it contains.  @bold{Note} that trying to write
@pyret{data D1 as D2} is not allowed syntax. You could export with a different
name for the type alias (e.g. @pyret{type D1 as D2}) if you want to refer to
one type with a different name in another context.

@section[#:tag "s:modules:include-fewer"]{Including Fewer (and More) Names}

There are forms for @pyret{include} with the same structure as @pyret{provide}
for including particular names from other modules. All @pyret{include} forms
take a @emph{module id} and a list of specifications of names to include.
(That module id must first have been @pyret{import}ed and given a name.)

@bnf['PyretModules]{
COLON: ":"
STAR: "*"
AS: "as"
LPAREN: "("
RPAREN: ")"
COMMA: ","
TYPE: "type"
DATA: "data"
MODULE: "module"
DOT: "."
HIDING: "hiding"
END: "end"
INCLUDECOLON: "include:"
INCLUDE: "include"
IMPORT: "import"
FROM: "from"

import-stmt: INCLUDE import-source
           | INCLUDE FROM module-ref COLON [include-spec (COMMA include-spec)* [COMMA]] END
           | IMPORT import-source AS NAME
           | IMPORT NAME (COMMA NAME)*  FROM import-source
import-source: import-special | import-name
import-special: NAME LPAREN STRING (COMMA STRING)* RPAREN
import-name: NAME

include-spec: include-name-spec | include-type-spec | include-data-spec | include-module-spec

include-name-spec: name-spec
include-type-spec: TYPE name-spec
include-data-spec: DATA data-name-spec [hiding-spec]
include-module-spec: MODULE name-spec

}

Some examples:

@pyret-block{
# This program puts just two names from the builtin string-dict module into
# scope.
import string-dict as SD
include from SD:
  mutable-string-dict,
  make-mutable-string-dict
end
}

@pyret-block{
# This program imports and renames two values from the string-dict module
import string-dict as SD
include from SD:
  mutable-string-dict as dict,
  make-mutable-string-dict as make-dict
end
}

@pyret-block{
# This program includes all the value names from the string-dict module
import string-dict as SD
include from SD: * end
}

It is an error to include the same name with different meanings. For example,
we could not include the @pyret{map} function from the @pyret{lists} library
@emph{and} import the @pyret{string-dict} constructor as @pyret{map}:

@pyret-block[#:style "bad-ex"]{
import lists as L
import string-dict as SD
include from L: map end
include from SD: mutable-string-dict as map end
}

However, it is @emph{not} an error to include the same name multiple times if
it has the same meaning:

@pyret-block[#:style "good-ex"]{
# in "student-helpers.arr"
provide from L: map, filter, fold end
import lists as L

# in "student-code.arr"
include file("student-helpers.arr")
import lists as L
include from L: map end
# map included again here, but it's OK because the other map is the same
}


@section[#:tag "s:modules:import-other"]{Importing more than just values}

Just as we can provide types, data definitions, and module ids, so too we can
import them or include them from other modules.  The syntax is
analogous to the providing syntax: a client module may write

@pyret-block{
import string-dict as SD
include from SD:
  *         # includes all values defined in the string-dict module
  type *    # includes all types defined in the string-dict module
  data *    # includes all data definitions from the string-dict module
  module *  # includes any modules provided by the string-dict module
end
}






@;{
@subsection{Inlcuding data definitions as types}

There is a subtle nuance regarding including data definitions.  Data
definitions provide values and type annotations that can be used at runtime,
but they also provide static information about their variants that can be used
by the @seclink["type-check"]{type checker}.  This static information is only
available when using @prod-link['PyretModules]{include-data-spec}s, rather than
@prod-link['PyretModules]{include-type-spec}s.  Specifically, given a library
file

@pyret-block{
provide:
  data *
end

data MyPos:
  | pos2d(x, y)
  | pos3d(x, y, z)
end
}

the following file will not pass the static type checker, because @pyret{MyPos}
is not known to be a data definition:

@pyret-block[#:style "bad-ex"]{
import file("mypos-provider.arr") as P
include from P:
  *,
  type *
end

cases(MyPos) pos2d(3, 4):
  | pos2d(x, y) => ...
  | pos3d(x, y, z) => ...
end
}

However, the following example works just fine:

@pyret-block[#:style "good-ex"]{
import file("mypos-provider.arr") as P
include from P:
  *,
  data *
end

cases(MyPos) pos2d(3, 4):
  | pos2d(x, y) => ...
  | pos3d(x, y, z) => ...
end
}

Note that both examples will run fine when @emph{not} using the type-checker at all.
}

@section{Converting between shorthand and expanded syntax}

Pyret used to have, and supports for backwards compatibility, a few other
syntaxes for modules. The short guide below shows how to convert from this old
syntax to the new. Of the old syntax, we only recommend the continued use of
@pyret{include <some-module>}, which is a convenient first line of many
student-facing starter files.

@tabular[#:sep (hspace 4)
 (list
  (list "Shorthand syntax" "Expanded form")
  (list @pyret-block{provide *}
        @pyret-block{
        provide:
          *
        end})
  (list @pyret-block{provide-types *}
        @pyret-block{
        provide:
          type *
        end})
  (list @pyret-block{include <some-module>}
        @pyret-block{
        import <some-module> as <some-name>
        include from <some-name>:
          *,
          type *,
          data *,
          module *
        end})
  (list @pyret-block{import name1, ... from <some-module>}
        @pyret-block{
        import <some-module> as <some-name>
        include from <some-name>:
          name1, ...
        end}))]


}
