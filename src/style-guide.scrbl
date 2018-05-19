#lang scribble/base

@(define code tt)
@(define codedisp verbatim)

@title{Pyret Style Guide}
@author{Frank Goodman and Shriram Krishnamurthi}

Ahoy matey! Here be the style guide for Pyret. Follow me rules to find 
the hidden treasure, or walk the plank!

@(table-of-contents)

@section{General}

@subsection{Indentation}

You should indent your code blocks using two spaces (not tabs).

@subsection{Line Length}

Try to keep the total length of your lines under 80 characters.

For overly long lines, it's actually really hard to figure out where
to put in good line breaks. This is in every language. Look for
something that tries to match the logical structure of your program.
 
However, there's usually a better way to solve this problem: create
extra variables to name the intermediate pieces, and use those
names. E.g.: instead of worrying where to put in line breaks in
@codedisp{ 
fun f(x, y, z):
  g(some-very-long-thing(x * x, y + y), other-very-long-thing((x + y + z) / (2 * 3 * 4)))
end
} 
it might be better to write it as
@codedisp{
fun f(x, y, z):
  sensible-name-1 = some-very-long-thing(x * x, y + y)
  sensible-name-2 = other-very-long-thing((x + y + z) / (2 * 3 * 4))
  g(sensible-name-1, sensible-name-2)
end
} 
(and think about indenting/shortening those two new lines).

Not only does this shorten lines, it makes it clearer what all these
pieces are doing, helping a later reader (who may be yourself!).

@subsection{Variable Naming}

The programming language world rages about the use of @code{camelCase}
versus @code{under_scores} in variable names. Pyret's syntax supports
both, but we can do better.

In Pyret, you can use dashes (@code{-})
inside variable names.@margin-note*{This is sometimes called ``kebab
case'', but it would be more accurate to call it ``shish case''.}
Thus, you would write @code{camel-case} and
@code{under-scores}. Unlike underscores, dashes don't need a shift key
(or disappear when text is underlined by an environment). Unlike
camelcase, dashes don't create ambiguities (what if one of the words
is in all-caps?). Dashes are also humanizing: they make your program
look that little bit more like human prose.

Most languages can't support dashes because the dash also stands for
infix subtraction. In Pyret, subtraction must be surrounded by
space. Therefore, @code{camel-case} is a name whereas @code{camel -
case} is subtraction.

@subsubsection{Naming Constants}

You should name constants in all-capital letters unless an external
convention would dictate using some other capitalization for that
particular name.  For example,
@codedisp{
MY-COUNT = 100
e = 2.7182
}

@subsubsection{Reusing Variable Names}

Pyret is picky about letting you reuse variable names. This is to help
you avoid confusing two different variables that have the same name
and accidentally using the wrong one. Specifically, an inner scope
can't use a name that is already bound in an outer scope; but two
different inner scopes can each use the same name. For instance,
@codedisp{
fun f(x): x + 1 end
fun g(x): x + 2 end
}
is legal, but
@codedisp{
fun h(x):
  x = 4
  x + 1
end
}
is not.

@subsection{File Naming}

Use @code{.arr} as the extension for Pyret files.

@subsection[#:tag "eg-tests"]{Example and Tests}

We use the syntax of testing to represent two different tasks:
@emph{examples}, which help us explore a problem and take steps
towards deriving a solution, and @emph{tests}, which are designed to
find errors. These are subtly different.

We write (most) examples @emph{before} writing the corresponding
code. Therefore, it makes sense to put these examples in an
@code{examples} block:
@codedisp{
examples:
  f(10) is 25
  f(20) is-not 2000
end
}
The keyword @code{examples} is synonymous with @code{check}, so we
could as well have written @code{check} instead. However, by
convention we use @code{check} for tests rather than examples.

@section{Functions}

@subsection{Naming}

Give functions descriptive names. Do the same for arguments. That way,
a quick scan of a function's header will tell you what it does and
what the arguments are supposed to do.

@subsection{Documentation Strings}

Unless the name is self-evident, write a brief documentation string
for your function. For instance:
@codedisp{
fun insert(x, l):
  doc: "consumes sorted list l; returns it with x in the right place"
  ...
end
}
Try to write your documentation in functional form, i.e., describing
what the function consumes and what it returns after computation.

If your comment needs to span multiple lines, use three back-ticks---
@codedisp{
```
}
---to begin and end the string. For instance:
@codedisp{
fun f(x):
  doc: ```This is a
       multi-line
       comment here.```
  x + x
end
}
This is also how you write a multi-line string in Pyret.

@subsection{Annotations}

Wherever possible, annotate both argument and return values. For instance,
@codedisp{
fun str-len(str :: String) -> Number:
  # ...
end
}
Even though Pyret does not currently check parametric annotations, you
should still write them for their value as user documentation. Thus:
@codedisp{
fun length(lst :: List<Any>) -> Number:
  # ...
end
}
You can even write an arbitrary predicate when a built-in annotation
isn't expressive enough. For instance, suppose we want to write a
function that consumes only non-negative numbers. We can define the
predicate---
@codedisp{
fun non-negative(n :: Number) -> Boolean:
  n >= 0
end
}
and then use it as follows:
@codedisp{
fun sqrt(n :: Number%(non-negative)) -> Number:
  # ...
end
}

@subsection{Testing}

You should test every function you write for both general cases and edge cases.

As we have discussed earlier [@secref["eg-tests"]], you can write
these using @code{examples} and @code{check}. In addition, you can
also write examples and tests of functions as part of the function
declaration, using @code{where}:
@codedisp{
fun double(n :: Number) -> Number:
  n * 2
where:
  double(0) is 0
  double(5) is 10
  double(-5) is -10
  double(100) is 200
  double(-100) is -200
end
}
Usually, the examples you create to help you think through the problem
would go in an @code{examples} block, and a large suite of tests would
end up in a separate @code{check} block. In a @code{where} block, we
should have a small number of @emph{illustrative} examples that help a
reader to quickly grasp the essence of the function's behavior. Try to
keep the size of the @code{where} block small and manageable. In
particular, a large test suite---meant to cover lots of behaviors,
including potentially redundant ones, and to find bugs---should go in
a separate @code{check} block rather than cluttering up the function
definition's @code{where} region.

@section{Data}

@subsection{Definitions}

Wherever possible, provide annotations in Data definitions:

@codedisp{
data Animal:
  | snake(name :: String)
  | dillo(weight :: Number, living :: Boolean)
end
}

@subsection{Cases}

To branch on the variants of a datum, use @code{cases}:
@codedisp{
cases (Animal) a:
  | snake(s) => s == "Dewey"
  | dillo(w, l) => (w < 10) and l
end
}
Sometimes, you won't use all the parts of a datum. You can still name
an unused part, but it is suggestive to use @code{_} instead; this
indicates to the reader that that field won't be used in this
computation, so they can ignore it:
@codedisp{
cases (Animal) a:
  | snake(s) => ...
  | dillo(w, _) => ...
end
}
Note that @code{_} is different from identifier names like
@code{dummy} because you can't write
@codedisp{
cases (Animal) a:
  | snake(s) => ...
  | dillo(dummy, dummy) => ...
end
}
(you'll get an error because you're trying to bind @code{dummy}
twice), but you can write
@codedisp{
cases (Animal) a:
  | snake(s) => ...
  | dillo(_, _) => ...
end
}
and thus ignore multiple fields. 

Finally, if your conditional is not designed to handle a particular
kind of datum, signal an error:
@codedisp{
cases (Animal) a:
  | snake(s) => ...
  | dillo(_, _) => raise("Serpents only, please!")
end
}

@section{Naming Intermediate Expressions}

@subsection{Local Variables}

You are welcome to create local names for expressions. For instance,
instead of writing
@codedisp{
fun hypo-len(a, b):
  num-sqrt((a * a) + (b * b))
end
}
you are welcome to write
@codedisp{
fun hypo-len(a, b):
  a2 = a * a
  b2 = b * b
  sum-of-other-two-sides = a2 + b2
  num-sqrt(sum-of-other-two-sides)
end
}
Even though you shouldn't have multiple @emph{expressions} as a
function body, these local definitions are not expressions in their
own right, so this is perfectly legal code; the value of calling the
function is that produced by its expression (which, here, is
@code{num-sqrt(sum-of-other-two-sides)}).

@subsection{Beware of @code{var}!}

You might have noticed that Pyret lets you write @code{var} before
local names: for instance, you can write the previous example as
@codedisp{
fun hypo-len(a, b):
  var a2 = a * a
  var b2 = b * b
  var sum-of-other-two-sides = a2 + b2
  num-sqrt(sum-of-other-two-sides)
end
}
instead. In particular, if you have prior experience in a language
like JavaScript, you might think this is @emph{good} practice. It's
not: @emph{don't do this}! In Pyret, adding @code{var} turns each name
into a @emph{mutable variable}, i.e., one that you can modify using an
assignment statement. Therefore, do not use @code{var} unless you
absolutely mean to create a mutable variable.