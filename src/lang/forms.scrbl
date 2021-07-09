#lang scribble/base

@(require
  racket/list
  racket/file
  (only-in racket/string string-join)
  (only-in scribble/core make-style)
  (only-in scribble/html-properties attributes)
  "../../scribble-api.rkt"
  "../../ragged.rkt")
@(define (prod . word)
 (apply tt word))
@(define (file . name)
 (apply tt name))
@(define (in-code . code)
 (apply tt code))
@(define (justcode . stx)
 (nested #:style 'code-inset
  (verbatim (string-join stx ""))))


@title[#:tag "s:forms" #:style '(toc)]{Language Constructs}

This section contains information on the various language forms in Pyret, from
binary operators to data definitions to functions.  This is a more detailed
reference to the grammar of expressions and statements and their evaluation,
rather than to

@(table-of-contents)

@section[#:tag "s:literals"]{Primitives and Literals}

There are several different literal token types referred to in this
documentation.

@subsection{Names}

Names in Pyret match the following regular expression:

@justcode{
^[_a-zA-Z][_a-zA-Z0-9]*(?:-+[_a-zA-Z0-9]+)*
}

@margin-note{The convention in Pyret is that @pyret{kebab-case-names} are used
for names of values and fields, and @pyret{TitleCaseNames} are used for
annotations.} That is, they start with an alphabetical character or an
underscore, followed by any number of alphanumeric characters mixed with
underscores and hyphens, ending in a non-hyphen.  So, for example, the
following are valid names (though not necessarily good style):

@pyret-block[#:style "good-ex"]{
a
a1
a-1
abc
ABC
a----------b
a-_-_-_-__--b
a--_
_a
__
}


The following are not valid names:

@pyret-block[#:style "bad-ex"]{
_-
-_
a-
-a
-a-
-abc
a1-
a-1-
a_1-
α
1abc
$abc
}

@subsection{String Literals}

@bnf['Pyret]{
string-expr: STRING
}

Strings in Pyret come in several forms.  First, they can be enclosed in double
quotes:

@pyret-block[#:style "good-ex"]{
"a string"
"a string\" with escapes"
"'single quotes' are allowed unescaped or \' escaped"
}

They can also be enclosed in single quotes:

@pyret-block[#:style "good-ex"]{
'a string'
'a string\' with escapes'
'"double quotes" are allowed unescaped or \" escaped'
}

String literals with single or double quotes must terminate by the end of the
line:

@pyret-block[#:style "bad-ex"]{
"multi-line
strings not
allowed with double quotes"
}

Finally, multi-line string literals can be created by starting and ending them
with three backticks (@pyret{```}).  For example:

@pyret-block[#:style "good-ex"]{
```
This string
spans
multiple lines
```
}

Multi-line string literals strip all whitespace before the first non-whitespace
character and after the last non-whitespace character.  All whitespace at the
beginning of intermediate lines is preserved.

@subsection[#:tag "f:number_literals"]{Number Literals}

@bnf['Pyret]{
num-expr: NUMBER
}

Pyret has several types of number literals.  The most traditional allows for
decimal numbers, negation, and an exponent:

@justcode{
^[-+]?[0-9]+(?:\\.[0-9]+)?(?:[eE][-+]?[0-9]+)?
}

That is, an optional sign, then some number of digits, optionally followed by a
decimal point and more digits, optionally followed by an exponent.  These are
valid number literals:

@pyret-block[#:style "good-ex"]{
0.1
1
1e100
1.1e100
+1.1e100
-1.1e-100
1.1230e-0
10
19
19.0
}

Note that a number literal cannot start with a decimal point; some leading
digits are required.  These are not number literals:

@pyret-block[#:style "bad-ex"]{
.1
1.1.1
1.+1
0.1+100
}

This first kind of number literal represents an @emph{exact} number, or
@pyret-id["Exactnum" "numbers"].  Number literals can also be prefixed with a
tilde, to indicate that the number is an approximation, or a
@pyret-id["Roughnum" "numbers"].  So these are all valid rough number literals:

@pyret-block[#:style "good-ex"]{
~0.1
~1
~1e100
~1.1e100
~+1.1e100
~-1.1e-100
~1.1230e-0
~10
~19
~19.0
}

And these are not valid:

@pyret-block[#:style "bad-ex"]{
~.1
~1.1.1
~1.+1
~0.1+100
}

Finally, numbers can be written as exact ratios of whole numbers:

@justcode{
^[-+]?[0-9]+/[0-9]+
}

These numbers are interpreted as @pyret-id["Exactnum" "numbers"]s.  These are
valid rational literals:

@pyret-block[#:style "good-ex"]{
1/2
-1/2
+1/4
1234/9
0/1234
}

It is a syntax error to use zero as the denominator in a fraction literal.
These are not valid rational literals:


@pyret-block[#:style "bad-ex"]{
1+1/2
-1/0
1.1/9
1/-3
}

@subsection{Boolean Literals}

@bnf['Pyret]{
bool-expr: "true" | "false"
}

Boolean literals are the lowercase words @pyret{true} and @pyret{false}.

@section[#:tag "s:comments"]{Comments}
Pyret supports two forms of comments:
@itemlist[

@item{@emph{Single-line comments} begin with a @pyret{#} symbol and extend to
the end of the line:

@pyret-block{
# This is an example of a single-line, standalone comment
fun example(n):
  1 + n # This single-line comment starts after some code
end
}
}

@item{@emph{Block comments} begin with a @pyret{#|} symbol and end with a
matching @pyret[#:style "force-comment"]{|#}.

@pyret-block{
fun example(n):
  #|
     This comment can extend
     over multiple lines
  |#
  1 + n
end
}

While the text of a comment block contains everything between the @pyret{#|}
and @pyret[#:style "force-comment"]{|#} symbols, it is preferred to put them on
their own lines, so they are visually distinctive and can easily be added or
removed:

@pyret-block[#:style "good-ex"]{
#|
  prefer this
  style
|#
}

@pyret-block[#:style "ok-ex"]{
#| instead of
   this style |#
}

The one exception is when block comments are being used to comment out sections
of a single line of code:

@pyret-block[#:style "good-ex"]{
rectangle(30 #|width|#, 40 #|height|#, "solid", "red")
}

They can be nested within each other, so long as the delimiters are matched:

@pyret-block{
fun example(n):
  #| this is in a comment
     #| so is this
        and this
     |#
     and this
  |#
  1 + n
end
}

Within a block comment, single-line comments are ignored:
@pyret-block[#:style "ok-ex"]{
fun example(n):
  #| This is a block comment.
     Even though the next line starts a single-line comment
     # the block-comment ends here |#
  1 + n
end
}

(Naturally, this style isn't preferred, as it is easy to ignore the
end-of-comment marker when reading quickly!)

}
]
@section[#:tag "s:program"]{Programs}

Programs consist of a sequence of import or provide statements, followed by a
block:

@bnf['Pyret]{
PROVIDE: "provide"
STAR: "*"
END: "end"
PROVIDE-TYPES: "provide-types"
program: prelude block
prelude: [provide-stmt] [provide-types-stmt] import-stmt*
}

@section{Import Statements}

Import statements come in a few forms:

@bnf['Pyret]{
IMPORT: "import"
AS: "as"
PARENNOSPACE: "("
COMMA: ","
RPAREN: ")"
FROM: "from"
import-stmt: IMPORT import-source AS NAME
           | IMPORT NAME (COMMA NAME)* FROM import-source
import-source: import-special | import-name | import-string
import-special: NAME PARENNOSPACE STRING (COMMA STRING)* RPAREN
import-name: NAME
import-string: STRING
}

The form with @py-prod{import-name} looks for a file with that name in the
built-in libraries of Pyret, and it is an error if there is no such library.

Example:

@pyret-block{
  import equality as EQ
  check:
    f = lam(): "" end
    equal-always3(f, f) is EQ.Unknown
  end
}

@section{Provide Statements}

@bnf['Pyret]{
PROVIDE: "provide"
END: "end"
STAR: "*"
provide-stmt: PROVIDE stmt END | PROVIDE STAR
}

@bnf['Pyret]{
PROVIDE-TYPES: "provide-types"
STAR: "*"
provide-types-stmt: PROVIDE-TYPES record-ann | PROVIDE-TYPES STAR
}

@pyret{provide} and @pyret{provide-types} statements specify which
bindings and declarations in the
program are available to other Pyret programs via @pyret{import} statements. 

@pyret{provide} statements must be the first non-comment code in the
program or a syntax error will be raised.  @pyret{provide} statements have no
effect when the program is run as the top-level program.

When the program is in a file that is evaluated via @pyret{import},
the program is run, and then the @pyret{provide} statement is run in
top-level scope to determine the value bound to the identifier in the
@pyret{import} statement.

@margin-note{Any interactive windows spawned by code in the
@pyret{providing} program will appear when its code is @pyret{import}ed.}

In the first form, the @tt{stmt} internal to the provide is evaluated, and the
resulting value is provided.  This is usually done via an object literal, where
the key represents the binding passed to the external program and
the value after the colon is the local identifier.

@examples{
provide {
  x : x,
  draw-character : draw-character,
  external-funct-name : internal-funct-name
}
end
}

Types can only be @pyret{provide}d by @pyret{provide-types} statements.  If
types are included in a @pyret{provide} statement they are ignored.  In
practice, types shared via @pyret{provide-types} also need to share detector
functions to fully work as anticipated in @pyret{import}ing programs.

The second wildcard @bold{*} form is syntactic sugar for sharing
all top level bindings and declarations other than types
defined in the file.

To share all bindings and declarations in a file:

@examples{
provide *
provide-types *
}

@margin-note{While the wildcard form is somewhat simpler, specifying
which names are to be shared explicitly through the object literal
syntax can prevent namespace pollution, especially if you expect
programmers (students) to use @pyret{include} to add the
names directly to their top level namespace.}

Programmers working through @url{http://code.pyret.org} can @pyret{provide}
and @pyret{import} code via Google Drive sharing integrated into the
development environment.  

To allow other programs to @pyret{import} the @pyret{provide}d values
in a program, click the @bold{Publish} button at the top of the window
for the providing program and then the blue @bold{Publish} button on
the resulting dialog.

The published code can now be @pyret{import}ed using the provided
code:

@(image "src/lang/publish.png")

Any time you make changes to the providing program that you want to
be available to @pyret{import}ing programs, you must re-publish the
providing program, and reload any open instances of the
@pyret{import}ing programs.

@section{Bindings}

Many syntactic forms in Pyret need to designate names for values.  These are
uniformly represented as @py-prod{binding}s:

@bnf['Pyret]{
binding: name-binding | tuple-binding
name-binding: [SHADOW] NAME [COLONCOLON ann]
tuple-binding: LBRACE (binding SEMI)* binding [SEMI] RBRACE [AS name-binding]
SHADOW: "shadow"
COLONCOLON: "::"
SEMI: ";"
LBRACE: "{"
RBRACE: "}"
AS: "as"
}

@subsection{Name bindings}
The simplest form of binding is a @py-prod{name-binding}.  This form
simply associates a name with a given value:
@pyret-block[#:style "good-ex"]{
PI = ~3.141592
five = num-sqrt((3 * 3) + (4 * 4))
hw = string-append("Hello", " world")
}

@subsection[#:tag "s:annotated-binding"]{Annotated bindings}
Slightly more complicated, a name binding may also specify an
@seclink["s:annotations"]{annotation}, that will ensure that the
value being bound has the correct type:
@pyret-block[#:style "good-ex"]{
PI :: Number = ~3.141592
hw :: String = string-append("Hello", "world")

this-will-fail :: Boolean = 5
}
That last line will fail at runtime with an annotation error.

Note that the annotation always comes after the name, not the value; this is
not allowed, for instance:

@pyret-block[#:style "bad-ex"]{
PI = ~3.14 :: Number
}

@subsection[#:tag "s:shadowing"]{Shadowing}

Pyret does not permit a program to implicitly bind the same name
multiple times in the same scope, as this can be confusing or
ambiguous: which name was meant?

@pyret-block[#:style "bad-ex"]{
ans = 3 + 4
ans = true # did you mean to use a different name here?

ans # which one was meant?
}

Pyret will signal an error on the second binding of @pyret{ans} above, saying
that it @emph{shadows} the earlier definition.  The same rule applies to names
defined in nested scopes, like functions.  This program is disallowed by the
shadowing rule, as well:

@pyret-block[#:style "bad-ex"]{
ans = 3 + 4

fun oops(x):
  ans = x * 2  # Shadows the outer ans
  ans
end

fun another-oops(ans): # Also shadows the outer ans
  if ans: 3 else: 4 end
end
}

The general rule for shadowing is to look "upward and leftward",
i.e. looking outward from the current scope to any enclosing scopes,
to see if there are any existing bindings of the same name.

But sometimes, redefining the same name makes the most sense.  In this
case, a program can explicitly specify that it means to hide the outer
definition, using the @pyret{shadow} keyword:
@pyret-block[#:style "good-ex"]{
ans = 3 + 4
fun oops(x):
  shadow ans = x * 2 # <-------------------------+
  ans    # uses the ans defined the line above --+
end
fun another-oops(shadow ans):
  if ans: 3 else: 3 end # uses the function's parameter
end
}

@subsection{Tuple bindings}
Tuples are useful to package up several Pyret values into a single
value, which can then be passed around and manipulated as a single
entity.  But often, the most useful manipulation is to break the tuple
apart into its components.  While there are @py-prod{tuple-get}
expressions to access individual components, it's often easiest to
give all the components names.  We do this with a
@py-prod{tuple-binding}, which binds each component of a tuple to its
own name. The number of bindings must match the length of the given tuple:

@examples{
check:
  {x; y} = {1; 2}
  x is 1
  y is 2

  fun sum-two({k; v}, {a; b; c}):
    k + v + a + b + c
  end

  sum-two({10; 12}, {1; 4; 5}) is 32

  fun sum-vals(elts) block:
    var sum = 0
    for each({k; v} from elts):
      sum := sum + v
    end
    sum
  end

  elts = [list: {"a"; 5}, {"b"; 6}, {"c"; 7}]
  sum-vals(elts) is 18 
end
}

It is also possible to @emph{nest} tuple bindings, if the tuple being
bound has tuples nested inside it:

@examples{
check:
  {{w; x}; {y; z}} = {{~5; true}; {"hello"; 4}}
  w is-roughly ~5
  x is true
  y is "hello"
  z is 4
end
}

Nested bindings likewise must match the number of components in the
tuple being bound, and follow the same rules of shadowing as normal
name bindings.

With nested tuples, it is sometimes also useful to not only decompose
the nested tuples into their components, but to give a name to the
nested tuple itself:

@examples{
check:
  {{w; x} as wx; {y; z} as yz} as wxyz = {{~5; true}; {"hello"; 4}}
  w is-roughly ~5
  x is true
  y is "hello"
  z is 4
  wx is-roughly {~5; true}
  yz is {"hello"; 4}
  wxyz is {wx; yz}
end
}

As with any other name bindings, you can provide annotations on any of these
components.  The rule of annotations adjacent to names applies – the tuple
components and the @pyret{as} name can have annotations.  We demonstrate both
permitted styles of annotation below:

@pyret-block[#:style "good-ex"]{
check:
  {
    {w :: Number; x :: Boolean} as wx;
    {y; z} as yz :: {String; Number}
  } as wxyz = {{~5; true}; {"hello"; 4}}
  w is-roughly ~5
  x is true
  y is "hello"
  z is 4
  wx is-roughly {~5; true}
  yz is {"hello"; 4}
  wxyz is {wx; yz}
end
}

But this is not allowed, because the @pyret{{Number; Boolean}} annotation is
not adjacent to a name:

@pyret-block[#:style "bad-ex"]{
check:
  {{w; x} :: {Number; Boolean} as wx; yz} = {{~5; true}; {"hello"; 4}}
  w is ~5
  x is true
end
}

@section{Blocks}

A block's syntax is a list of statements:

@bnf['Pyret]{
block: stmt*
user-block-expr: BLOCK block END
BLOCK: "block:"
END: "end"
}

Blocks serve two roles in Pyret:

@itemlist[
  @item{Sequencing of operations}
  @item{Units of lexical scope}
]

The @py-prod{let-decl}, @py-prod{fun-decl},
@py-prod{data-decl}, and @py-prod{var-decl} forms
are handled specially and non-locally within blocks.  A detailed
description of scope will appear here soon.

Blocks evaluate each of their statements in order, and evaluate to the value of
the final statement in the block.

The @py-prod{user-block-expr} form @emph{additionally}
creates a scope for any names bound inside it.  That is, definitions
within such a block are visible only within that block:

@pyret-block{
x = 10
ans = block:
  y = 5 + x # x is visible here
  42 # value result of the block
end
z = y + ans # error: y is not in scope here
}

@subsection[#:tag "s:blocky-blocks"]{Block Shorthand}

Many expressions in Pyret include one or more blocks within them.  For
example, the body of a function is defined as a block.  Technically,
this means the following program is legal:

@pyret-block[#:style "bad-ex"]{
fun weather-reaction(forecast, temp):
  ask:
    | forecast == "sunny" then: "sunglasses"
    | forecast == "rainy" then: "umbrella"
    | otherwise: ""
  end
  ask:
    | temp > 85 then: "shorts"
    | temp > 50 then: "jeans"
    | temp > 0 then: "parka"
    | otherwise: "stay inside!"
  end
end
}

However, the program probably won't behave as expected: rather than
returning some combination of "sunglasses" and "shorts" for a warm,
sunny day, it will evaluate the first @tt{ask} expression,
@emph{discard the result}, and then evaluate the second @tt{ask}
expression and return its result.

Pyret will warn the programmer if it encounters programs like these,
and complain that the block contains multiple expressions.  Often
as in this case, it signals a real mistake, and the programmer ought
to revise the code to comprise a single expression --- say, by
concatenating the two results above.  Sometimes, though, multiple
expressions are deliberate:

@pyret-block[#:style "bad-ex"]{
if some-condition():
  temp = some-complicated-expression()
  print(temp) # make sure we got it right!
  do-something-with(temp)
else:
  do-something-else()
end
}

To tell Pyret that these multiple statements are intentional, we could
write an explicit @tt{block} form:

@pyret-block[#:style "ok-ex"]{
if some-condition():
  block:
    temp = some-complicated-expression()
    print(temp) # make sure we got it right!
    do-something-with(temp)
  end
else:
  do-something-else()
end
}

...but that is syntactically annoying for a straightforward situation!
Instead, Pyret allows for block @emph{shorthands}: writing @tt{block}
before the opening colon of a blocky expression signals that the
expression is deliberate.


@pyret-block[#:style "good-ex"]{
if some-condition() block:
  temp = some-complicated-expression()
  print(temp) # make sure we got it right!
  do-something-with(temp)
else:
  do-something-else()
end
}

The leading @tt{block} allows for multiple statements in @emph{all} of
the blocks of this expression.  Analogous markers exist for
@py-prod{ask-expr}, @py-prod{cases-expr}, @py-prod{fun-decl}, etc.

However, even this marker is sometimes too much.  Suppose we
eliminated the @tt{print} call in the example above:

@pyret-block{
if some-condition() block:
  temp = some-complicated-expression()
  do-something-with(temp)
else:
  do-something-else()
end
}

Why should this expression be penalized, but the equivalent one, where
we inline the definition of @tt{temp}, not be?  After all, this one is
clearer to read!  In fact, Pyret will @emph{not} complain about this
block containing multiple expressions.  Instead, Pyret will consider
the following to be valid "non-blocky" blocks:

@bnf['Pyret]{
non-blocky-block: stmt* template-expr stmt* | let-decl* expr | user-block-expr
}

Any sequence of let-bindings followed by exactly one expression is
fine, as is any block containing even a single template-expression, or
(obviously) an explicit @tt{block} expression.  All other blocks will
trigger the multiple-expressions warning and require either an
explicit block or a block-shorthand to fix.

@section[#:tag "s:declarations"]{Declarations}

There are a number of forms that can only appear as statements in @tt{block}s
(rather than anywhere an expression can appear).  Several of these are
@emph{declarations}, which define new names within their enclosing block.
@py-prod{data-decl} and @py-prod{contract} are exceptions, and can appear only at the top level.

@bnf['Pyret]{
stmt: let-decl | rec-decl | fun-decl | var-decl | type-stmt | newtype-stmt
    | data-decl | contract
}

@subsection[#:tag "s:let-decl"]{Let Declarations}

Let declarations are written with an equals sign:

@bnf['Pyret]{
EQUALS: "="
let-decl: binding EQUALS binop-expr
}

A let statement causes the name in the @tt{binding} to be put in scope in the
current block, and upon evaluation sets the value to be the result of
evaluating the @tt{binop-expr}.  The resulting binding cannot be changed via an
@py-prod{assign-stmt}, and cannot be shadowed by other bindings within the same or
nested scopes:

@pyret-block{
x = 5
x := 10
# Error: x is not assignable

}

@pyret-block{
x = 5
x = 10
# Error: x defined twice

}

@pyret-block{
x = 5
fun f():
  x = 10
  x
end
# Error: can't use the name x in two nested scopes

}

@pyret-block{
fun f():
  x = 10
  x
end
fun g():
  x = 22
  x
end
# Not an error: x is used in two scopes that are not nested
}

A binding also has a case with tuples, where several names can be given in a binding which can then be assigned to values in a tuple.

@pyret-block{
{x;y;z} = {"he" + "llo"; true; 42}
x = "hi"
#Error: x defined twice

}

@pyret-block{
{x;y;z} = {10; 12}
#Error: The number of names must match the length of the tuple

}

@subsection[#:tag "s:rec-decl"]{Recursive Let Declarations}
@bnf['Pyret]{
EQUALS: "="
REC: "rec"
rec-decl: REC binding EQUALS binop-expr
}

A recursive let-binding is just like a normal let-binding, except that the name
being defined is in scope in the definition itself, rather than only after it.
That is:

@pyret-block[#:style "bad-ex"]{
countdown-bad = lam(n):
  if n == 0: true
  else: countdown-bad(n - 1) # countdown-bad is not in scope
  end
end
# countdown-bad is in scope here
}
@pyret-block[#:style "good-ex"]{
rec countdown-good =
  # countdown-good is in scope here, because of the 'rec'
  lam(n):
    if n == 0: true
    else: countdown-good(n - 1) # so this call is fine
    end
  end
# countdown-good is in scope here
}
@subsection[#:tag "s:fun-decl"]{Function Declaration Expressions}

Function declarations have a number of pieces:

@bnf['Pyret]{
FUN: "fun"
COLON: ":"
END: "end"
LANGLE: "<"
RANGLE: ">"
COMMA: ","
LPAREN: "("
THINARROW: "->"
DOC: "doc:"
WHERE: "where:"
BLOCK: "block"
fun-decl: FUN NAME fun-header [BLOCK] COLON doc-string block where-clause END
fun-header: ty-params args return-ann
ty-params:
  [LANGLE list-ty-param* NAME RANGLE]
list-ty-param: NAME COMMA
args: LPAREN [list-arg-elt* binding] RPAREN
list-arg-elt: binding COMMA
return-ann: [THINARROW ann]
doc-string: [DOC STRING]
where-clause: [WHERE block]
}

Function declarations are statements used to define functions with a given
name, parameters and signature, optional documentation, body, and optional tests.
For example, the following code:

@pyret-block{
fun is-even(n):
  num-modulo(n, 2) == 0
end
}

defines a minimal function, with just its name, parameter names, and body.  A
more complete example:

@pyret-block{
fun fact(n :: NumNonNegative) -> Number:
  doc: "Returns n! = 1 * 2 * 3 ... * n"
  if n == 0: 1
  else:      n * fact(n - 1)
  end
where:
  fact(1) is 1
  fact(5) is 120
end
}

defines a recursive function with a fully-annotated signature (the types of its
parameter and return value are specified), documents the purpose of the
function with a doc-string, and includes a where-block definine some simple
tests of the function.

Function declarations are statements that can only appear either at the top
level of a file, or within a block scope.  (This is commonly used for defining
local helper functions within another one.)

@subsubsection{Scope}
Once defined, the name of the function is visible for the remainder of the
scope in which it is defined.  Additionall, the function is in scope within its
own body, to enable recursive functions like @pyret{fact} above:

@pyret-block{
fun outer-function(a, b, c):
  ...
  # outer-function is in scope here
  # as are parameters a, b, and c
  ...
  fun inner-helper(d, e, f):
    ...
    # inner-helper is in scope here,
    # as are parameters d, e, and f
    # and also outer-helper, a, b and c
    ...
  end
  ...
  # outer-function, a, b, and c are in scope here,
  # and so is inner-helper, but *not* d, e or f
  ...
end
}

As with all Pyret identifiers, these function and parameter names cannot be
mutated, and they cannot be redefined while in scope unless they are explicitly
@pyret{shadow}ed.

@subsubsection{Where blocks}
If a function defines a @pyret{where:} block, it can incorporate unit tests
directly inline with its definition.  This helps to document the code in
terms of executable examples.  Additionally, whenever the function declaration
is executed, the tests will be executed as well.  This helps ensure that the
code and tests don't fall out of synch with each other.  (The clarification
about "whenever the declaration is executed" allows writing tests for nested
functions that might rely on the parameters of their containing function: in
the example above, @pyret{inner-helper} might have a test case that relied on
the parameters @pyret{a}, @pyret{b} or @pyret{c} from the surrounding call to
@pyret{outer-function}.) See the documentation for
@seclink["testing-blocks"]{@pyret{check:} and @pyret{where:} blocks} for more
details. 

@subsubsection{Syntactic sugar}
Function declarations are not a primitive concept in the language.  Instead,
they can be thought of as an idiomatic declaration of a recursively-scoped let
binding to a lambda expression.  That is, the following two definitions are
equivalent: 
@pyret-block{
fun fact(n):
  if n == 1: 1 else: n * fact(n - 1) end
end
}
@pyret-block{
rec fact = lam(n):
  if n == 1: 1 else n * fact(n - 1) end
end
}

See the @seclink["s:lam-expr"]{documentation} for more information about
@py-prod{lam-expr}s, and also see @py-prod{rec-decl}s above for more
information about recursive bindings.

@subsection[#:tag "s:data-decl"]{Data Declarations}

Data declarations define a number of related functions for creating and
manipulating a data type.  Their grammar is:

@bnf['Pyret]{
COLON: ":"
END: "end"
DATA: "data"
PIPE: "|"
LPAREN: "("
RPAREN: ")"
data-decl: DATA NAME ty-params COLON
    data-variant*
    data-sharing
    where-clause
  END
data-variant: PIPE NAME variant-members data-with | PIPE NAME data-with
variant-members: LPAREN [list-variant-member* variant-member] RPAREN
COMMA: ","
REF: "ref"
list-variant-member: variant-member COMMA
variant-member: [REF] binding
WITH: "with:"
data-with: [WITH fields]
SHARING: "sharing:"
data-sharing: [SHARING fields]
}


A @py-prod{data-decl} causes a number of new names to be bound in the scope of the
block it is defined in:

@itemlist[
  @item{The @tt{NAME} of the data definition}
  @item{@tt{NAME}, for each variant of the data definition}
  @item{@tt{is-NAME}, for the data definition and each variant of
the data definition}
]

For example, in this data definition:

@pyret-block{
data BTree:
  | node(value :: Number, left :: BTree, right :: BTree)
  | leaf(value :: Number)
end
}

These names are defined, with the given types:

@pyret-block{
is-BTree :: (Any -> Bool)
node :: (Number, BTree, BTree -> BTree)
is-node :: (Any -> Bool)
leaf :: (Number -> BTree)
is-leaf :: (Any -> Bool)
}

We call @tt{node} and @tt{leaf} the @emph{constructors} of @tt{BTree}, and they
construct values with the named fields.  They will refuse to create the value
if fields that don't match the annotations are given.  As with all annotations,
they are optional.  The constructed values can have their fields accessed with
@seclink["s:dot-expr" "dot expressions"].

The function @tt{is-BTree} is a @emph{detector} for values created from this data
definition.  @tt{is-BTree} returns @pyret{true} when provided values
created by @tt{node} or @tt{leaf}, but no others.  @tt{BTree} can be
used as an annotation to check for values created by the constructors of
@tt{BTree}.

The functions @tt{is-node} and @tt{is-leaf} are detectors for the values
created by the individual constructors: @tt{is-node} will only return @pyret{true}
for values created by calling @tt{node}, and @tt{is-leaf} correspondingly for
@tt{leaf}.

Here is a longer example of the behavior of detectors, field access, and
constructors:

@pyret-block{
data BTree:
  | node(value :: Number, left :: BTree, right :: BTree)
  | leaf(value :: Number)
where:
  a-btree = node(1, leaf(2), node(3, leaf(4), leaf(5)))

  is-BTree(a-btree) is true
  is-BTree("not-a-tree") is false
  is-BTree(leaf(5)) is true
  is-leaf(leaf(5)) is true
  is-leaf(a-btree) is false
  is-leaf("not-a-tree") is false
  is-node(leaf(5)) is false
  is-node(a-btree) is true
  is-node("not-a-tree") is false

  a-btree.value is 1
  a-btree.left.value is 2
  a-btree.right.value is 3
  a-btree.right.left.value is 4
  a-btree.right.right.value is 5

end
}

A data definition can also define, for each instance as well as for the data
definition as a whole, a set of methods.  This is done with the keywords
@tt{with:} and @tt{sharing:}.  Methods defined on a variant via @tt{with:} will
only be defined for instances of that variant, while methods defined on the
union of all the variants with @tt{sharing:} are defined on all instances.  For
example:

@pyret-block{
data BTree:
  | node(value :: Number, left :: BTree, right :: BTree) with:
    method size(self): 1 + self.left.size() + self.right.size() end
  | leaf(value :: Number) with:
    method size(self): 1 end,
    method increment(self): leaf(self.value + 1) end
sharing:
  method values-equal(self, other):
    self.value == other.value
  end
where:
  a-btree = node(1, leaf(2), node(3, leaf(4), leaf(2)))
  a-btree.values-equal(leaf(1)) is true
  leaf(1).values-equal(a-btree) is true
  a-btree.size() is 5
  leaf(0).size() is 1
  leaf(1).increment() is leaf(2)
  a-btree.increment() # raises error: field increment not found.
end
}

When you have a single kind of datum in a data definition, instead of
writing:

@pyret-block{
data Point:
  | pt(x, y)
end
}

You can drop the | and simply write:

@pyret-block{
data Point: pt(x, y) end
}

@subsection[#:tag "s:var-decl"]{Variable Declarations}

Variable declarations look like @seclink["s:let-decl" "let bindings"], but
with an extra @tt{var} keyword in the beginning:

@bnf['Pyret]{
             VAR: "var"
             EQUALS: "="
var-decl: VAR binding EQUALS expr
}

A @tt{var} expression creates a new @emph{assignable variable} in the current
scope, initialized to the value of the expression on the right of the @tt{=}.
It can be accessed simply by using the variable name, which will always
evaluate to the last-assigned value of the variable.  @seclink["s:assign-stmt"
"Assignment statements"] can be used to update the value stored in an
assignable variable.

If the @tt{binding} contains an annotation, the initial value is checked
against the annotation, and all @seclink["s:assign-stmt" "assignment
statements"] to the variable check the annotation on the new value before
updating.



@subsection[#:tag "s:type-decl"]{Type Declarations}
Pyret provides two means of defining new type names.  
@bnf['Pyret]{
TYPE: "type"
EQUALS: "="
type-stmt: TYPE type-decl
type-decl: NAME ty-params EQUALS ann
}

A @py-prod{type-stmt} declares an alias to an existing type.  This allows for
creating convenient names for types, especially when type parameters are
involved.
@examples{
type Predicate<a> = (a -> Boolean)
# Now we can use this alias to make the signatures for other functions more readable:
fun filter<a>(pred :: Predicate<a>, elts :: List<a>) -> List<a>: ... end

# We can specialize types, too:
type NumList = List<Number>
type StrPred = Predicate<String>
}


@subsection[#:tag "s:newtype-decl"]{Newtype Declarations}
By contrast, sometimes we need to declare brand-new types, that are not easily
describable using @py-prod{data-decl} or other existing types.  (For one common
example, we might want to build an object-oriented type that encapsulates
details of its internals.)  To do that we need to specify both a @emph{static name} to
use as annotations to describe our data, and a @emph{dynamic brand} to mark the
data and ensure that we can recognize it again when we see it.
@bnf['Pyret]{
NEWTYPE: "newtype"
AS: "as"
newtype-stmt: newtype-decl
newtype-decl: NEWTYPE NAME AS NAME
}
When we write
@examples{
newtype MytypeBrander as MyType
}
we define both of these components.  See @secref{brands} for more information
about branders.

@section[#:tag "s:contracts"]{Contracts}


As part of its support for the systematic design of functions, Pyret allows
developers to specify an annotation for a name, before that name is defined.
The general grammar for standalone contracts is:

For example,

@pyret-block[#:style "good-ex"]{
the-answer :: Number
the-answer = 42

double :: String -> String
fun double(s): s + s end

vals-to-string :: <T, S> (S, T -> String)
fun vals-to-string(val1, val2):
  to-string(val1) + ", " + to-string(val2)
end
}

In all of these cases, the definition itself (of @pyret{the-answer},
@pyret{double}, and @pyret{vals-to-string}) is preceded by a @emph{contract}
statement, asserting the signature of the definition to follow.  Pyret treats
these contracts specially, and weaves them in to the definitions: the previous
examples are equivalent to

@pyret-block[#:style "good-ex"]{
the-answer :: Number = 42

fun double(s :: String) -> String: s + s end

fun vals-to-string<T,S>(val1 :: T, val2 :: S) -> String:
  to-string(val1) + ", " + to-string(val2)
end
}

The grammar for these contracts looks nearly identical to that of
@py-prod{name-binding}s.  Function annotations are given a slightly more
relaxed treatment: the outermost set of parentheses are optional.

@bnf['Pyret]{
COMMA: ","
THINARROW: "->"
COLONCOLON: "::"
LPAREN: "("
RPAREN: ")"
contract: NAME COLONCOLON ty-params ann | NAME COLONCOLON ty-params contract-arrow-ann
contract-arrow-ann: (ann COMMA)* ann THINARROW ann 
              | LPAREN (NAME COLONCOLON ann COMMA)* NAME COLONCOLON ann RPAREN THINARROW ann
}

When weaving function annotations onto functions, Pyret enforces a few
restrictions:
@itemlist[
@item{For a standalone function, the contract must immediately precede the
function definition, or must immediately precede an
@seclink["testing-blocks"]{@pyret{examples} or @pyret{check} block} that
immediately precedes the function definition.  (Whitespace or comments are not
important; extraneous definitions are.)

@pyret-block[#:style "good-ex"]{
is-even :: Number -> Boolean

check:
  is-even(2) is true
end

fun is-even(n): num-modulo(n, 2) == 0 end
}
@pyret-block[#:style "bad-ex"]{
is-even :: Number -> Boolean

something-irrelevant = 12345

fun is-even(n): num-modulo(n, 2) == 0 end
}
}
@item{For mutually recursive functions, the contracts must be adjacent to the
functions, and must precede them.
@pyret-block[#:style "good-ex"]{
# Contracts
is-even :: Number -> Boolean
is-odd :: Number -> Boolean
# Implementations
fun is-even(n): if n == 0: true else: is-odd(n - 1) end end
fun is-odd(n): if n == 0: false else: is-even(n - 1) end end
}
@pyret-block[#:style "good-ex"]{
# Is even?
is-even :: Number -> Boolean
fun is-even(n): if n == 0: true else: is-odd(n - 1) end end
# Is odd?
is-odd :: Number -> Boolean
fun is-odd(n): if n == 0: false else: is-even(n - 1) end end
}
@pyret-block[#:style "bad-ex"]{
is-odd :: Number -> Boolean
fun is-even(n): if n == 0: true else: is-odd(n - 1) end end
is-even :: Number -> Boolean  ## Does not precede definition of is-even
fun is-odd(n): if n == 0: false else: is-even(n - 1) end end
}
}
@item{If a contract specifies argument names, then the names must match those
used by the function.
@pyret-block[#:style "good-ex"]{
is-even :: (n :: Number) -> Boolean
fun is-even(n): num-modulo(n, 2) == 0 end
}
@pyret-block[#:style "bad-ex"]{
is-even :: (x :: Number) -> Boolean # name does not match
fun is-even(n): ... end
}
}
@item{If a contract is used for a function, then the function must not itself
be annotated.
@pyret-block[#:style "good-ex"]{
is-even :: (n :: Number) -> Boolean
fun is-even(n): num-modulo(n, 2) == 0 end
}
@pyret-block[#:style "bad-ex"]{
is-even :: (n :: Number) -> Boolean # Redundant argument annotation
fun is-even(n :: Number): ... end
}
@pyret-block[#:style "bad-ex"]{
is-even :: (n :: Number) -> Boolean # Redundant return annotation
fun is-even(n) -> Boolean: ... end
}
}
]

Note that using a contract on a function is @emph{more expressive} than using
an annotated binding for a lambda.  @secref["s:annotated-binding"] do not
enforce all the components of an @seclink["s:arrow-ann"]{arrow annotation}; they
merely ensure that the value being bound is in fact a function.  By contrast,
function contracts ensure the arguments and return values are annotated and
checked.

@section{Statements}

There are just a few forms that can only appear as statements in @tt{block}s
that aren't declarations:

@bnf['Pyret]{
stmt: when-stmt | assign-stmt | binop-expr
}

@subsection[#:tag "s:when-stmt"]{When Statements}

A when expression has a single test condition with a corresponding
block.

@bnf['Pyret]{
WHEN: "when"
COLON: ":"
END: "end"
BLOCK: "block"
when-stmt: WHEN binop-expr [BLOCK] COLON block END
}

For example:

@pyret-block{
when x == 42:
  print("answer")
end
}

If the test condition is true, the block is evaluated. If the
test condition is false, nothing is done, and @pyret{nothing} is returned.

@subsection[#:tag "s:assign-stmt"]{Assignment Statements}

Assignment statements have a name on the left, and an expression on the right
of @tt{:=}:

@bnf['Pyret]{
             COLON-EQUALS: ":="
assign-stmt: NAME COLON-EQUALS binop-expr
}

If @tt{NAME} is not declared in the same or an outer scope of the assignment
expression with a @tt{var} declaration, the program fails with a static error.

At runtime, an assignment expression changes the value of the assignable
variable @tt{NAME} to the result of the right-hand side expression.

@subsection{Binop Expression “Statements”}

The @py-prod{binop-expr} production is included in @py-prod{stmt} because any
expression can appear where a statement can (subject to restrictions from
well-formedness checking).
@;TODO: Link to well-formedness once section is written

@section{Expressions}

The following are all the expression forms of Pyret:

@bnf['Pyret]{
expr: paren-expr | id-expr | prim-expr
    | lam-expr | method-expr | app-expr
    | obj-expr | dot-expr | extend-expr
    | tuple-expr | tuple-get
    | template-expr
    | get-bang-expr | update-expr
    | if-expr | ask-expr | cases-expr
    | for-expr
    | user-block-expr | inst-expr
    | construct-expr
    | multi-let-expr | letrec-expr
    | type-let-expr
    | construct-expr
    | table-expr
    | table-select
    | table-sieve
    | table-order
    | table-extract
    | table-transform
    | table-extend
    | load-table-expr
    | reactor-expr
paren-expr: LPAREN binop-expr RPAREN
id-expr: NAME
prim-expr: NUMBER | RATIONAL | BOOLEAN | STRING
LPAREN: "("
RPAREN: ")"
}

@subsection[#:tag "s:lam-expr"]{Lambda Expressions}

The grammar for a lambda expression is:

@bnf['Pyret]{
             LAM: "lam"
             COLON: ":"
             END: "end"
             BLOCK: "block"
lam-expr: LAM fun-header [BLOCK] COLON
    doc-string
    block
    where-clause
  END
LANGLE: "<"
RANGLE: ">"
COMMA: ","
LAPREN: "("
RPAREN: ")"
THINARROW: "->"
DOC: "doc:"
}

A lambda expression creates a function value that can be applied with
@seclink["s:app-expr" "application expressions"].  The arguments in @tt{args}
are bound to their arguments as immutable identifiers as in a
@seclink["s:let-decl" "let expression"].

@examples{
check:
  f = lam(x, y): x - y end
  f(5, 3) is 2
end

check: 
  f = lam({x;y}): x - y end
  f({5;3}) is 2
end
}

These identifiers follow the same rules of no shadowing and no assignment.

@examples{
x = 12
f = lam(x): x end  # ERROR: x shadows a previous definition
g = lam(y):
  y := 10   # ERROR: y is not a variable and cannot be assigned
  y + 1
end
}

If the arguments have @seclink["s:annotations" "annotations"] associated with
them, they are checked before the body of the function starts evaluating, in
order from left to right.  If an annotation fails, an exception is thrown.

@pyret-block{
add1 = lam(x :: Number):
  x + 1
end
add1("not-a-number")
# Error: expected a Number and got "not-a-number"
}

A lambda expression can have a @emph{return} annotation as well, which is
checked before evaluating to the final value:


@examples{
add1 = lam(x) -> Number:
  tostring(x) + "1"
end
add1(5)
# Error: expected a Number and got "51"
}

Lambda expressions remember, or close over, the values of other identifiers
that are in scope when they are defined.  So, for example:

@examples{
check:
  x = 10
  f = lam(y): y + x end
  f(5) is 15
end
}

@subsection[#:tag "s:curly-lam-expr"]{Curly-Brace Lambda Shorthand}

Lambda expressions can also be written with a curly-brace shorthand:

@bnf['Pyret]{
             LBRACE: "{"
             COLON: ":"
             RBRACE: "}"
             BLOCK: "block"
curly-lam-expr: LBRACE fun-header [BLOCK] COLON
    doc-string
    block
    where-clause
  RBRACE
LANGLE: "<"
RANGLE: ">"
COMMA: ","
LAPREN: "("
RPAREN: ")"
THINARROW: "->"
DOC: "doc:"
}

@examples{
check:
  x = 10
  f = {(y :: Number) -> Number: x + y}
  f(5) is 15
end
}

@subsection[#:tag "s:method-expr"]{Anonymous Method Expressions}

An anonymous method expression looks much like an anonymous function (defined
with @pyret{lam}):

@bnf['Pyret]{
METHOD: "method"
BLOCK: "block"
COLON: ":"
END: "end"
method-expr: METHOD fun-header [BLOCK] COLON doc-string block where-clause END
}

All the same rules for bindings, including annotations and shadowing, apply the
same to @py-prod{method-expr}s as they do to @py-prod{lam-expr}s.

It is a well-formedness error for a method to have no arguments.

At runtime, a @py-prod{method-expr} evaluates to a method value.  Method values
cannot be applied directly:

@examples{
check:
  m = method(self): self end
  m(5) raises "non-function"
end
}

Instead, methods must be included as object fields, where they can then be
bound and invoked.  A method value can be used in multiple objects:

@examples{
check:
  m = method(self): self.x end
  o = { a-method-name: m, x: 20 }
  o2 = { a-method-name: m, x: 30 }
  o.a-method-name() is 20
  o2.a-method-name() is 30
end
}

@subsection[#:tag "s:app-expr"]{Application Expressions}

Function application expressions have the following grammar:

@bnf['Pyret]{
             LPAREN: "("
             RPAREN: ")"
             COMMA: ","
app-expr: expr app-args
app-args: LPAREN [app-arg-elt* binop-expr] RPAREN
app-arg-elt: binop-expr COMMA
}

An application expression is an expression followed by a comma-separated list
of arguments enclosed in parentheses.  It first evaluates the arguments in
left-to-right order, then evaluates the function position.  If the function
position is a function value, the number of provided arguments is checked
against the number of arguments that the function expects.  If they match, the
arguments names are bound to the provided values.  If they don't, an exception
is thrown.

Note that there is @emph{no space} allowed before the opening parenthesis of
the application.  If you make a mistake, Pyret will complain:

@pyret-block{
f(1) # This is the function application expression f(1)
f (1) # This is the id-expr f, followed by the paren-expr (1)
# The second form yields a well-formedness error that there
# are two expressions on the same line
}

@subsection[#:tag "s:curried-apply-expr"]{Curried Application Expressions}

Suppose a function is defined with multiple arguments:

@pyret-block{
fun f(v, w, x, y, z): ... end
}

Sometimes, it is particularly convenient to define a new function that
calls @tt{f} with some arguments pre-specified:

@pyret-block{
call-f-with-123 = lam(y, z): f(1, 2, 3, y, z) end
}

Pyret provides syntactic sugar to make writing such helper functions
easier:

@pyret-block{
call-f-with-123 = f(1, 2, 3, _, _) # same as the fun expression above
}

Specifically, when Pyret code contains a function application some of
whose arguments are underscores, it constructs an lambda expression
with the same number of arguments as there were underscores in the
original expression, whose body is simply the original function
application, with the underscores replaced by the names of the
arguments to the anonymous function.

This syntactic sugar also works
with operators.  For example, the following are two ways to sum a list
of numbers:

@pyret-block{
[list: 1, 2, 3, 4].foldl(lam(a, b): a + b end, 0)

[list: 1, 2, 3, 4].foldl(_ + _, 0)
}

Likewise, the following are two ways to compare two lists for
equality:

@pyret-block{
list.map_2(lam(x, y): x == y end, first-list, second-list)

list.map_2(_ == _, first-list, second-list)
}

Note that there are some limitations to this syntactic sugar.  You
cannot use it with the @tt{is} or @tt{raises} expressions in
check blocks, since both test expressions and expected
outcomes are known when writing tests.  Also, note that the sugar is
applied only to one function application at a time.  As a result, the
following code:

@pyret-block{
_ + _ + _
}

desugars to

@pyret-block{
lam(z):
  (lam(x, y): x + y end) + z
end
}

which is probably not what was intended.  You can still write the
intended expression manually:

@pyret-block{
lam(x, y, z): x + y + z end
}

Pyret just does not provide syntactic sugar to help in this case
(or other more complicated ones).

@subsection[#:tag "s:cannonball-expr"]{Chaining Application}

@bnf['Pyret]{
CARET: "^"
chain-app-expr: binop-expr CARET binop-expr
}

The expression @pyret{e1 ^ e2} is equivalent to @pyret{e2(e1)}.  It's just
another way of writing a function application to a single argument.

Sometimes, composing functions doesn't produce readable code.  For example, if
say we have a @pyret{Tree} datatype, and we have an @pyret{add} operation on
it, defined via a function.  To build up a tree with a series of adds, we'd
write something like:

@pyret-block{
t = add(add(add(add(empty-tree, 1), 2), 3), 4)
}

Or maybe

@pyret-block{
t1 = add(empty-tree, 1)
t2 = add(t1, 2)
t3 = add(t2, 3)
t  = add(t3, 4)
}

If @pyret{add} were a method, we could write:

@pyret-block{
t = empty-tree.add(1).add(2).add(3).add(4)
}

which would be more readable, but since @pyret{add} is a function, this doesn't
work.

In this case, we can write instead:

@pyret-block{
t = empty-tree ^ add(_, 1) ^ add(_, 2) ^ add(_, 3)
}

This uses @seclink["s:curried-apply-expr" "curried application"] to create a
single argument function, and chaining application to apply it.  This can be
more readable across several lines of initialization as well, when compared to
composing “inside-out” or using several intermediate names:

@pyret-block{
t = empty-tree
  ^ add(_, 1)
  ^ add(_, 2)
  ^ add(_, 3)
  # and so on
}




@subsection[#:tag "s:inst-expr"]{Instantiation Expressions}
Functions may be defined with parametric signatures.  Calling those functions
does not require specifying the type parameter, but supplying it might aid in
readability, or may aid the static type checker.  You can supply the type
arguments just between the function name and the left-paren of the function
call.  Spaces are not permitted before the left-angle bracket or after the
right-angle bracket

@bnf['Pyret]{
LANGLE: "<"
RANGLE: ">"
COMMA: ","
inst-expr: expr LANGLE ann (COMMA ann)* RANGLE
}

@examples{
fun is-even(n :: Number) -> Boolean: num-modulo(n, 2) == 0 end
check:
  map<Number, Boolean>(is-even, [list: 1, 2, 3]) is [list: false, true, false]
end
}



@subsection[#:tag "s:binop-expr"]{Binary Operators}

There are a number of binary operators in Pyret.  A binary operator expression
is a series of expressions joined by binary operators. An expression itself
is also a binary operator expression.

@bnf['Pyret]{
binop-expr: expr (BINOP expr)*
}

Pyret supports the following operations, shown by example:
@pyret-block{
examples:
  1 + 1  is 2
  1 - 1  is 0
  2 * 4  is 8
  6 / 3  is 2
  1 < 2  is true
  1 <= 1 is true
  1 > 1  is false
  1 >= 1 is true
  1 == 1 is true
  true and true is true
  false or true is true
  not(false) is true
end
}

@margin-note{There are additional equality operators in Pyret, which also call methods, but are
somewhat more complex.  They are documented in detail in @seclink["equality"].}
The arithmetic and comparison operators examine their arguments.  For primtive
numbers and strings, the operation happens internally to Pyret.  If the
arguments are objects, however, the operators are syntactic sugar for a particular
method call, as follows:

@tabular[#:sep @hspace[2]
  (list
    (list @tt{left + right} @tt{left._plus(right)})
    (list @tt{left - right} @tt{left._minus(right)})
    (list @tt{left * right} @tt{left._times(right)})
    (list @tt{left / right} @tt{left._divide(right)})
    (list @tt{left <= right} @tt{left._lessequal(right)})
    (list @tt{left < right} @tt{left._lessthan(right)})
    (list @tt{left >= right} @tt{left._greaterequal(right)})
    (list @tt{left > right} @tt{left._greaterthan(right)}))
]

Logical operators do not have a corresponding method call, since they only
apply to primitive boolean values.

@subsection[#:tag "s:tuple-expr"]{Tuple Expressions}

Tuples are an immutable, fixed-length collection of expressions indexed by non-negative integers:

@bnf['Pyret]{
tuple-expr: "{" tuple-fields "}"
tuple-fields: binop-expr (";" binop-expr)* [";"]
}

A semicolon-separated sequence of fields enclosed in @tt{{}} creates a tuple. 

@subsection[#:tag "s:tuple-get-expr"]{Tuple Access Expressions}

@bnf['Pyret]{
tuple-get: expr "." "{" NUMBER "}"
}

A tuple-get expression evaluates the @tt{expr} to a value @tt{val}, and then
does one of three things:

@margin-note{A static well-formedness error is raised if the index is
negative}
@itemlist[
  @item{Raises an exception, if @tt{expr} is not a tuple}

  @item{Raises an exception, if @tt{NUMBER} is equal to or greater than the length of the given tuple}

  @item{Evaluates the expression, returning the @tt{val} at the given index.  The first index is @pyret{0}}
]

For example:

@pyret-block[#:style "good-ex"]{
check:
  t = {"a";"b";true}
  t.{0} is "a"
  t.{1} is "b"
  t.{2} is true
end
}


Note that the index is restricted @emph{syntactically} to being a number.  So this program is a parse error:

@pyret-block[#:style "bad-ex"]{
t = {"a";"b";"c"}
t.{1 + 1}
}

This restriction ensures that tuple access is typable.



@subsection[#:tag "s:obj-expr"]{Object Expressions}

Object expressions map field names to values:

@bnf['Pyret]{
             LBRACE: "{"
             RBRACE: "}"
obj-expr: LBRACE fields RBRACE | LBRACE RBRACE
COMMA: ","
COLON: ":"
fields: list-field* field [COMMA]
list-field: field COMMA
END: "end"
METHOD: "method"
BLOCK: "block"
field: key COLON binop-expr
     | METHOD key fun-header [BLOCK] COLON doc-string block where-clause END
key: NAME
}

A comma-separated sequence of fields enclosed in @tt{{}} creates an object; we
refer to the expression as an @emph{object literal}.  There are two types of
fields: @emph{data} fields and @emph{method} fields.  A data field in an object
literal simply creates a field with that name on the resulting object, with its
value equal to the right-hand side of the field. A method field

@justcode{
"method" key fun-header ":" doc-string block where-clause "end"
}

is syntactic sugar for:

@justcode{
key ":" "method" fun-header ":" doc-string block where-clause "end"
}

That is, it's just special syntax for a data field that contains a method
value.

The fields are evaluated in the order they appear.  If the same field appears
more than once, it is a compile-time error.

@subsection[#:tag "s:dot-expr"]{Dot Expressions}

A dot expression is any expression, followed by a dot and name:

@bnf['Pyret]{
             DOT: "."
dot-expr: expr DOT NAME
}

A dot expression evaluates the @tt{expr} to a value @tt{val}, and then does one
of three things:

@itemlist[
  @item{Raises an exception, if @tt{NAME} is not a field of @tt{expr}}

  @item{Evaluates to the value stored in @tt{NAME}, if @tt{NAME} is present and
  not a method}

  @item{

    If the @tt{NAME} field is a method value, evaluates to a function that is
    the @emph{method binding} of the method value to @tt{val}.  For a method

    @pyret-block{
      m = method(self, x): body end
    }

    The @emph{method binding} of @tt{m} to a value @tt{v} is equivalent to:

    @pyret-block{
      (lam(self): lam(x): body end end)(v)
    }

    What this detail means is that you can look up a method and it
    automatically closes over the value on the left-hand side of the dot.  This
    bound method can be freely used as a function.

    For example:

    @pyret-block{
      o = { method m(self, x): self.y + x end, y: 22 }
      check:
        the-m-method-closed-over-o = o.m
        the-m-method-closed-over-o(5) is 27
      end
    }
  }
]

@subsection[#:tag "s:extend-expr"]{Extend Expressions}

The extend expression consists of an base expression and a list of fields to
extend it with:

@bnf['Pyret]{
             DOT: "."
             LBRACE: "{"
             RBRACE: "}"
extend-expr: expr DOT LBRACE fields RBRACE
}

The extend expression first evaluates @tt{expr} to a value @tt{val}, and then
creates a new object with all the fields of @tt{val} and @tt{fields}.  If a
field is present in both, the new field is used.

Examples:

@pyret-block{
check:
  o = {x : "original-x", y: "original-y"}
  o2 = o.{x : "new-x", z : "new-z"}
  o2.x is "new-x"
  o2.y is "original-y"
  o2.z is "new-z"
end
}

@subsection[#:tag "s:if-expr"]{If Expressions}

An if expression has a number of test conditions and an optional else case.

@bnf['Pyret]{
             IF: "if"
             COLON: ":"
             ELSECOLON: "else:"
             ELSEIF: "else if"
             END: "end"
             BLOCK: "block"
if-expr: IF binop-expr [BLOCK] COLON block else-if* [ELSECOLON block] END
else-if: ELSEIF binop-expr COLON block
}

For example, this if expression has an "else:"

@pyret-block{
if x == 0:
  1
else if x > 0:
  x
else:
  x * -1
end
}

This one does not:

@pyret-block{
if x == 0:
  1
else if x > 0:
  x
end
}

Both are valid.  The conditions are tried in order, and the block corresponding
to the first one to return @pyret{true} is evaluated.  If no condition matches,
the else branch is evaluated if present.  If no condition matches and no else
branch is present, an error is thrown.  If a condition evaluates to a value
other than @pyret{true} or @pyret{false}, a runtime error is thrown.

@subsection[#:tag "s:ask-expr"]{Ask Expressions}

An @pyret{ask} expression is a different way of writing an @pyret{if}
expression that can be easier to read in some cases.

@bnf['Pyret]{
             ASKCOLON: "ask"
             BLOCK: "block"
             COLON: ":"
             BAR: "|"
             OTHERWISECOLON: "otherwise:"
             THENCOLON: "then:"
             END: "end"
ask-expr: ASK [BLOCK] COLON ask-branch* [BAR OTHERWISECOLON block] END
ask-branch: BAR binop-expr THENCOLON block
}

This ask expression:

@pyret-block{
ask:
  | x == 0 then: 1
  | x > 0 then: x
  | otherwise: x * -1
end
}

is equivalent to

@pyret-block{
if x == 0:
  1
else if x > 0:
  x
else:
  x * -1
end
}

Similar to @pyret{if}, if an @pyret{otherwise:} branch isn't specified and no
branch matches, a runtime error results.

@subsection[#:tag "s:cases-expr"]{Cases Expressions}

A cases expression consists of a datatype (in parentheses), an expression to
inspect (before the colon), and a number of branches.  It is intended to be
used in a structure parallel to a data definition.

@bnf['Pyret]{
             CASES: "cases"
             LPAREN: "("
             RPAREN: ")"
             COLON: ":"
             BAR: "|"
             ELSE: "else"
             THICKARROW: "=>"
             END: "end"
             BLOCK: "block"
cases-expr: CASES LPAREN ann RPAREN expr [BLOCK] COLON
    cases-branch*
    [BAR ELSE THICKARROW block]
  END
cases-branch: BAR NAME [args] THICKARROW block
}

The @pyret{check-ann} must be a type, like @pyret-id["List" "lists"].  Then
@pyret{expr} is evaluated and checked against the given annotation.  If
it has the right type, the cases are then checked.

Cases should use the names of the variants of the given data type as the
@tt{NAME}s of each branch.  In the branch that matches, the fields of the
variant are bound, in order, to the provided @tt{args}, and the right-hand side
of the @tt{=>} is evaluated in that extended environment.  An exception results
if the wrong number of arguments are given.

An optional @tt{else} clause can be provided, which is evaluated if no cases
match.  If no @tt{else} clause is provided, a runtime error results.

For example, some cases expression on lists looks like:

@pyret-block{
check:
  result = cases(List) [list: 1,2,3]:
    | empty => "empty"
    | link(f, r) => "link"
  end
  result is "link"

  result2 = cases(List) [list: 1,2,3]:
    | empty => "empty"
    | else => "else"
  end
  result2 is else

  result3 = cases(List) empty:
    | empty => "empty"
    | else => "else"
  end
  result3 is "empty"
end
}

If a field of the variant is a tuple, it can also be bound using a tuple binding.

For example, a cases expression on a list with tuples looks like:

@examples{
check:
  result4 = cases(List) [list: {"a"; 1}, {"b"; 2}, {"c"; 3}]:
    | empty => "empty"
    | link({x;y}, r) => x
    | else => "else"
  end
  
  result4 is "a"
end
}

@subsection[#:tag "s:for-expr"]{For Expressions}

For expressions consist of the @tt{for} keyword, followed by a list of
@tt{binding from expr} clauses in parentheses, followed by a block:

@bnf['Pyret]{
             FOR: "for"
             PARENNOSPACE: "("
             RPAREN: ")"
             COLON: ":"
             END: "end"
             BLOCK: "block"
for-expr: FOR expr PARENNOSPACE [for-bind-elt* for-bind] RPAREN return-ann [BLOCK] COLON
  block
END
COMMA: ","
for-bind-elt: for-bind COMMA
FROM: "from"
for-bind: binding FROM binop-expr
}

The for expression is just syntactic sugar for a
@seclink["s:lam-expr"]{@tt{lam-expr}} and a @seclink["s:app-expr"]{@tt{app-expr}}.  An expression

@pyret-block{
for fexpr(arg1 :: ann1 from expr1, ...) -> ann-return:
  block
end
}

is equivalent to:

@pyret-block{
fexpr(lam(arg1 :: ann1, ...) -> ann-return: block end, expr1, ...)
}

Using a @tt{for-expr} can be a more natural way to call, for example, list
iteration functions because it puts the identifier of the function and the
value it draws from closer to one another.  Use of @tt{for-expr} is a matter of
style; here is an example that compares @tt{fold} with and without @tt{for}:

@pyret-block{
for fold(sum from 0, number from [list: 1,2,3,4]):
  sum + number
end

fold(lam(sum, number): sum + number end, 0, [list: 1,2,3,4])
}

@subsection[#:tag "s:template-expr"]{Template (...) Expressions}

A template expression is three dots in a row:

@bnf['Pyret]{
DOTS: "..."
template-expr: DOTS
}

It is useful for a placeholder for other expressions in code-in-progress.  When
it is evaluated, it raises a runtime exception that indicates the expression it
is standing in for isn't yet implemented:

@examples{
fun list-sum(l :: List<Number>) -> Number:
  cases(List<Number>) l:
    | empty => 0
    | link(first, rest) => first + ...
  end
end
check:
  list-sum(empty) is 0
  list-sum(link(1, empty)) raises "template-not-finished"
end
}

This is handy for starting a function (especially one with many cases) with
some tests written and others to be completed.

@margin-note{These other positions for @tt{...} may be included in the future.}
The @tt{...} expression can only appear where @emph{expressions} can appear.
So it is not allowed in binding positions or annotation positions.  These are
not allowed:

@examples{
fun f(...): # parse error
  "todo"
end
x :: ... = 5 # parse error
}

Because templates are by definition unfinished, the presence of a
template expression in a block exempts that block from
@seclink["s:blocky-blocks"]{explicit-blockiness checking}.

@subsection[#:tag "s:table-exprs"]{Tables}

Tables precise syntax is documented here.  For helper functions and data
structures, see @secref["s:tables"].

Table expressions consist of a list of column names followed by one or more
rows of data:

@bnf['Pyret]{
TABLE: "table:"
ROW: "row:"
COLONCOLON: "::"
COMMA: ","
END: "end"
table-expr: TABLE table-headers table-rows END
table-headers: [table-header COMMA]* table-header
table-header: NAME [COLONCOLON ann]
table-rows: table-row* table-row
table-row: ROW [binop-expr COMMA]* binop-expr
}

@bnf['Pyret]{
TABLE-SELECT: "select"
COMMA: ","
END: "end"
FROM: "from"
table-select: TABLE-SELECT NAME (COMMA NAME)* FROM expr END
}

@bnf['Pyret]{
TABLE-FILTER: "sieve"
COLON: ":"
COMMA: ","
END: "end"
FROM: "from"
USING: "using"
table-sieve: TABLE-FILTER expr [USING binding (COMMA binding)*] COLON binop-expr END
}


@subsubsection[#:tag "s:tables:order"]{Sorting Table Rows}
@bnf['Pyret]{
TABLE-ORDER: "order"
ASCENDING: "ascending"
DESCENDING: "descending"
COLON: ":"
COMMA: ","
END: "end"
table-order: TABLE-ORDER expr COLON column-order END
column-order: NAME ((ASCENDING | DESCENDING))
}

@subsubsection[#:tag "s:tables:transform"]{Transforming Table Rows}
@bnf['Pyret]{
TABLE-TRANSFORM: "transform"
USING: "using"
COLON: ":"
COMMA: ","
END: "end"
table-transform: TABLE-TRANSFORM expr [USING binding (COMMA binding)*] COLON transform-fields END
transform-fields: transform-field (COMMA transform-field)* [COMMA]
transform-field: key COLON binop-expr
}

@subsubsection[#:tag "s:tables:extract"]{Extracting Table Columns}
@bnf['Pyret]{
TABLE-EXTRACT: "extract"
COLON: ":"
COMMA: ","
END: "end"
FROM: "from"
table-extract: TABLE-EXTRACT NAME FROM expr END
}

@subsubsection[#:tag "s:tables:extend"]{Adding Table Columns}
@bnf['Pyret]{
TABLE-EXTEND: "extend"
USING: "using"
COLON: ":"
COLONCOLON: "::"
COMMA: ","
END: "end"
OF: "of"
table-extend: TABLE-EXTEND expr [USING binding (COMMA binding)*] COLON [table-extend-field COMMA]* table-extend-field END
table-extend-field: key [COLONCOLON ann] COLON binop-expr
                  | key [COLONCOLON ann] COLON expr OF NAME
}


@subsection[#:tag "s:table-loading"]{Table Loading Expressions}

A table loading expression constructs a table using a data source and
zero or more data sanitizers:
@bnf['Pyret]{
LOAD-TABLE: "load-table"
COLON: ":"
END: "end"
SOURCECOLON: "source:"
SANITIZE: "sanitize"
USING: "using"
load-table-expr: LOAD-TABLE COLON table-headers [load-table-specs] END
load-table-specs: load-table-spec* load-table-spec
load-table-spec: SOURCECOLON expr
               | SANITIZE NAME USING expr
}

@subsection[#:tag "s:reactor-expr"]{Reactor Expressions}

@bnf['Pyret]{
REACTOR: "reactor"
COLON: ":"
INIT: "init"
END: "end"
reactor-expr: REACTOR COLON
  INIT ":" expr
  [ "," option-name ":" expr ]*
END
option-name:
    "on-tick"
  | "on-mouse"
  | "on-key"
  | "to-draw"
  | "stop-when"
  | "title"
  | "close-when-stop"
  | "seconds-per-tick"
}

Reactors are described in detail in @secref["s:reactors"].

@subsection[#:tag "s:reference-fields"]{Mutable fields}
Pyret allows creating data definitions whose fields are mutable.  Accordingly,
it provides syntax for accessing and modifying those fields.
@bnf['Pyret]{
BANG: "!"
LBRACE: "{"
RBRACE: "}"
get-bang-expr: expr BANG NAME
update-expr: expr BANG LBRACE fields RBRACE
}

By analogy with how @py-prod{dot-expr} accesses normal fields,
@py-prod{get-bang-expr} accesses mutable fields --- but more emphatically so,
because mutable fields, by their nature, might change.  Dot-access to mutable
fields also works, but does not return the field's value: it returns the
reference itself, which is a Pyret value that's mostly inert and difficult to
work with outside the context of its host object.

@examples{
data MutX:
  | mut-x(ref x, y)
end

ex1 = mut-x(1, 2)

check:
  ex1!x is 1      # this access the value inside the reference
  ex1.x is-not 1  # this does not
end
}

To update a reference value, we use syntax similar to @py-prod{extend-expr},
likewise made more emphatic:

@examples{
ex1!{x: 42}
check:
  ex1!x is 42
end
}






@subsection[#:tag "s:construct-expr"]{Construction expressions}
Individual Pyret data values are syntactically simple to construct: they look
similar to function calls.  But arbitrarily-sized data is not as obvious.  For
instance, we could write
@examples{
link(1, link(2, link(3, link(4, empty))))
}
to construct a 4-element list of numbers, but this gets tiresome quite
quickly.  Many languages provide built-in syntactic support for constructing
lists, but in Pyret we want all data types to be treated equally.  Accordingly,
we can write the above example as
@examples{
[list: 1, 2, 3, 4]
}
where @emph{@pyret{list} is not a syntactic keyword} in the language.  Instead,
this is one example of a @emph{construction expression}, whose syntax is simply
@bnf['Pyret]{
LBRACK: "["
RBRACK: "]"
COLON: ":"
COMMA: ","
construct-expr: LBRACK binop-expr COLON construct-args RBRACK
construct-args: [binop-expr (COMMA binop-expr)*]
}

Pyret defines several of these constructors for you: lists, sets, arrays, and
string-dictionaries all have the same syntax.


The expression before the initial colon is a Pyret object that has a particular
set of methods available.  Users can define their own constructors as well.
@pyret-block{
type Constructor<A> = {
  make0 :: ( -> A),
  make1 :: (Any -> A),
  make2 :: (Any, Any -> A),
  make3 :: (Any, Any, Any -> A),
  make4 :: (Any, Any, Any, Any -> A),
  make5 :: (Any, Any, Any, Any, Any -> A)
  make  :: (RawArray<Any> -> A),
}
}
When Pyret encounters a construction expression, it will call the
appropriately-numbered method on the constructor objects, depending on the
number of arguments it received.

@examples{
weird :: Constructor<String> = {
  make0: lam(): "nothing at all" end,
  make1: lam(a): "just " + tostring(a) end,
  make2: lam(a, b): tostring(a) + " and " + tostring(b) end,
  make3: lam(a, b, c): "several things" end,
  make4: lam(a, b, c, d): "four things" end,
  make5: lam(a, b, c, d, e): "five things" end,
  make : lam(args): "too many things" end
}
check:
  [weird: ] is "nothing at all"
  [weird: true] is "just true"
  [weird: 5, 6.24] is "5 and 6.24"
  [weird: true, false, 5] is "several things"
  [weird: 1, 2, 3, 4] is "four things"
  [weird: 1, 1, 1, 1, 1] is "five things"
  [weird: "a", "b", "c", true, false, 5] is "too many things"
end
}


@subsection[#:tag "s:binding-expressions"]{Expression forms of bindings}
Every definition is Pyret is visible until the end of its scope, which is
usually the nearest enclosing block.  To limit that scope, you can wrap
definitions in explicit @py-prod{user-block-expr}s, but this is sometimes awkward to
read.  Pyret allows for three additional forms that combine bindings with
expression blocks in a manner that is sometimes more legible:

@bnf['Pyret]{
LET: "let"
LETREC: "letrec"
TYPE-LET: "type-let"
COMMA: ","
BLOCK: "block"
COLON: ":"
END: "end"
EQUALS: "="
NEWTYPE: "newtype"
AS: "as"
multi-let-expr: LET let-or-var (COMMA let-or-var)* [BLOCK] COLON block END
let-or-var: let-decl | var-decl
letrec-expr: LETREC let-decl (COMMA let-decl)* [BLOCK] COLON block END
type-let-expr: TYPE-LET type-let-or-newtype (COMMA type-let-or-newtype)* [BLOCK] COLON END
type-let-or-newtype: type-decl | newtype-decl
}

These define their bindings only for the scope of the following block.  A
@py-prod{multi-let-expr} defines a sequence of either let- or
variable-bindings, each of which are in scope for subsequent ones.  A
@py-prod{letrec-expr} defines a set of mutually-recursive let-bindings that may
refer to each other in a well-formed way (i.e., no definition may rely on other
definitions before they've been fully evaluated).  These are akin to the
@py-prod{let-decl} and @py-prod{var-decl} forms seen earlier, but with more
explicitly-visible scoping rules.

Finally, @py-prod{type-let-expr} defines local type aliases or new types, akin
to @py-prod{type-stmt}.



@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




@section[#:tag "s:annotations"]{Annotations}

@bnf['Pyret]{
ann: name-ann | dot-ann
   | app-ann | arrow-ann | pred-ann
   | tuple-ann | record-ann
}

Annotations in Pyret express intended types values will have at runtime.
They appear next to identifiers anywhere a @tt{binding} is specified in the
grammar, and if an annotation is present adjacent to an identifier, the program
is compiled to raise an error if the value bound to that identifier would
behave in a way that violates the annotation.  The annotation provides a
@emph{guarantee} that either the value will behave in a particular way, or the
program will raise an exception. In addition, annotations can be checked
by Pyret's @seclink["type-check"]{type checker} to ensure that all values
have the expected types and are used correctly.

@subsection[#:tag "s:name-ann"]{Name Annotations}


@bnf['Pyret]{
DOT: "."
name-ann: NAME
dot-ann: NAME DOT NAME
          }
Some annotations are simply names.  For example, a
@seclink["s:data-decl"]{@tt{data declaration}} binds the name of the
declaration as a value suitable for use as a name annotation.  There are
built-in name annotations, too:

@justcode{
Any
Number
String
Boolean
}

Each of these names represents a particular type of runtime value, and using
them in annotation position will check each time the identifier is bound that
the value is of the right type.

@pyret-block{
x :: Number = "not-a-number"
# Error: expected Number and got "not-a-number"
}

@tt{Any} is an annotation that allows any value to be used.  It's semantically
equivalent to not putting an annotation on an identifier, but it allows a
program to clearly signal that no restrictions are intended for the identifier
it annotates.

Dot-annotations allow for importing types from modules:
@pyret-block{
import equality as EQ
eq-reqult :: EQ.EqualityResult = equal-always3(5, 6)
}

@subsection[#:tag "s:app-ann"]{Parametric Annotations}
@bnf['Pyret]{
LANGLE: "<"
RANGLE: ">"
COMMA: ","
app-ann: name-ann  LANGLE comma-anns RANGLE
| dot-ann LANGLE comma-anns RANGLE
comma-anns: ann (COMMA ann)*
}

Many data definitions are parametric, meaning they can contain any
uniform type of data, such as lists of numbers.  Accordingly, while
the following annotation isn't quite wrong, it is incomplete:
@pyret-block[#:style "ok-ex"]{
list-of-nums :: List = [list: 1, 2, 3]
}

To properly express the constraint on the contents, we need to
specialize the list annotation:
@pyret-block[#:style "good-ex"]{
list-of-nums :: List<Number> = [list: 1, 2, 3]
}

Note that this annotation will @emph{not dynamically check} that every
item in the list is in fact a @tt{Number} --- that would be infeasibly
expensive.  However, the @seclink["type-check"]{static type checker}
will make use of this information more fully.

@subsection[#:tag "s:arrow-ann"]{Arrow Annotations}

An arrow annotation is used to describe the behavior of functions.  It consists
of a list of comma-separated argument types followed by an ASCII arrow and
return type.  Optionally, the annotation can specify argument names as well:

@bnf['Pyret]{
             LPAREN: "("
             RPAREN: ")"
             THINARROW: "->"
             COMMA: ","
             COLONCOLON: "::"
arrow-ann: LPAREN (ann COMMA)* ann THINARROW ann RPAREN
     | LPAREN LPAREN (NAME COLONCOLON ann COMMA)* NAME COLONCOLON ann RPAREN THINARROW ann RPAREN
}

When an arrow annotation appears in a binding, that binding position simply
checks that the value is a function.  To enforce a more detailed check, use @seclink["s:contracts"].

@subsection[#:tag "s:pred-ann"]{Predicate Annotations}
A predicate annotation is used to @emph{refine} the annotations
describing the a value.  

@bnf['Pyret]{
             PERCENT: "%"
             LPAREN: "("
             RPAREN: ")"
pred-ann: ann PERCENT LPAREN NAME RPAREN
          }


For example, a function might only work on non-empty lists.  We might
write this as

@pyret-block[#:style "good-ex"]{
fun do-something-with<a>(non-empty-list :: List<a>%(is-link)) -> a: ... end
}

If we want to write customized predicates, we can easily do so.  Those
predicates must be defined @emph{before} being used in an annotation
position, and must be refered to by name.

@subsection[#:tag "s:tuple-ann"]{Tuple Annotations}
Annotating a tuple is syntactically very similar to writing a tuple value:

@bnf['Pyret]{
LBRACE: "{"
RBRACE: "}"
SEMI: ";"
tuple-ann: LBRACE ann (SEMI ann)* [SEMI] RBRACE
}

Each component is itself an annotation.

For example we could write
@examples{
num-bool :: {Number; Boolean} = {3; true}
num-bool--string-list :: {{Number; Boolean}; {String; List<Any>}} = {{3; true}; {"hi"; empty}}
}

@subsection[#:tag "s:record-ann"]{Record Annotations}
Annotating a record is syntactically very similar to writing a record value,
but where the single-colon separators between field names and their values have
been replaced with the double-colon of all annotations:

@bnf['Pyret]{
LBRACE: "{"
RBRACE: "}"
COMMA: ","
COLONCOLON: "::"
record-ann: LBRACE ann-field (COMMA ann-field)* RBRACE
ann-field: NAME COLONCOLON ann
}

As with object literals, the order of fields does not matter.  For example,
@examples{
my-obj :: {n :: Number, s :: String, b :: Boolean} = {s: "Hello", b: true, n: 42}
}
