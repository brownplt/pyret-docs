#lang scribble/base

@(require
  racket/list
  racket/file
  (only-in racket/string string-join)
  (only-in scribble/core make-style)
  (only-in scribble/html-properties attributes)
  "../../scribble-api.rkt"
  "../../ragged.rkt")

@title[#:tag "s:spies"]{Spies}

Spies are used for convenient display of values for print-style debugging. See
@secref["s:spies:rationale"] for why this is particularly useful in Pyret.

@section{Examples}

The shortest use of a @tt{spy} statement is to print the value of a name:

@pyret-block{
x = 10
spy: x end
}

This will produce a message like:

@margin-note{The filename will be the name of the file containing the @tt{spy}
statement, not @tt{spies.arr} as shown here}
@verbatim{
Spying (at file:///spies.arr:2:0-2:10)
  x: 10
}

On code.pyret.org, you'll see output like:

@image[#:scale 0.3 "src/lang/simple-spy.png"]

Both of these outputs indicate that the name was @tt{x} and the value was
@tt{10}. In the text output, the line and column information is printed (this
happened at line 2). In the visual output, the @tt{x} is underlined – clicking
it will scroll the editor to the line of the spy statement and highlight the
corresponding use of @tt{x}.

A @tt{spy} statement can contain more than one name, and will print out all their
values:

@pyret-block{
x = 10
y = [list: 1, 2, 3]
spy: x, y end
}

@verbatim{
Spying (at file:///spies.arr:3:0-3:13)
  x: 10
  y: [list: 1, 2, 3]
}


A spy statement can also contain a message. This can be helpful for
distinguishing between spy statements without looking at their corresponding
line numbers:

@pyret-block{
fun square(x):
  spy "in square": x end
  x * x
end

fun cube(x):
  spy "in cube": x end
  x * x * x
end

square(x)
cube(x)
square(x)
}

Will produce:

@verbatim{
Spying "in square" (at file:///spies.arr:2:2-2:24)
  x: 3
Spying "in cube" (at file:///spies.arr:7:2-7:22)
  x: 2
Spying "in square" (at file:///spies.arr:2:2-2:24)
  x: 2
}


If we want to @tt{spy} on an expression, rather than just names, we can give
the expression a name within the @tt{spy} statement:

@pyret-block{
fun reverse(lst, sofar):
  spy "lengths":
    lst-length: lst.length(),
    sofar-length: sofar.length(),
    sum: lst.length() + sofar.length()
  end
  cases(List<A>) lst:
    | empty => sofar
    | link(first, rest) =>
      reverse(rest, link(first, sofar))
  end
end

check:
  reverse([list: "a", "b", "c"], empty) is [list: "c", "b", "a"]
end

}

This produces:

@verbatim{
Spying "lengths" (at file:///spies.arr:2:2-6:5)
  lst-length: 3
  sofar-length: 0
  sum: 3
Spying "lengths" (at file://spies.arr:2:2-6:5)
  lst-length: 2
  sofar-length: 1
  sum: 3
Spying "lengths" (at file:///spies.arr:2:2-6:5)
  lst-length: 1
  sofar-length: 2
  sum: 3
Spying "lengths" (at file:///spies.arr:2:2-6:5)
  lst-length: 0
  sofar-length: 3
  sum: 3
}


@section{Minor Notes and Corner Cases}

Both types of spy fields can be used in a single spy statement:

@pyret-block{
x = 10
spy:
  x,
  y: 20
end
}

Note that each value that is spied upon is required to have a name. That is,
it's an error to write:

@pyret-block[#:style "bad-ex"]{
spy:
  2 + 2
end
}


@section{Grammar}

The grammar of @tt{spy} statements is:

@bnf['Pyret]{
SPY: "spy"
END: "end"
COLON: ":"
COMMA: ","
spy-stmt: SPY [expr] COLON spy-body END
spy-body: spy-field [COMMA spy-field]*
spy-field: NAME | NAME COLON binop-expr
}


@section[#:tag "s:spies:rationale"]{Rationale}

Often, when debugging or explaining a program, it's useful to display values
during execution. It's common to do this with functions like @pyret-id["print"
"<global>"]. However, both in general, and specifically in Pyret, using a
regular function call for debug printing leaves something to be desired. For
example, just printing doesn't track the line and column something was printed
at, and when the value of an identifier is printed, its name is lost in the
ouput, forcing the programmer to add extra string output describing the value.
More annoyingly in Pyret, since we often add print statements to
already-existing code, it becomes a nuisance to add @secref["s:blocky-blocks"]
just to get a debugging print.

For example, consider the @tt{reverse} example from above:

@pyret-block{
fun reverse(lst, sofar):
  cases(List<A>) lst:
    | empty => sofar
    | link(first, rest) =>
      reverse(rest, link(first, sofar))
  end
end
}

We might try to add uses of @pyret-id["print" "<global>"] to do what the spy
statement did:

@pyret-block[#:style "bad-ex"]{
fun reverse(lst, sofar):
  print(lst.length())
  print(sofar.length())
  print(lst.length() + sofar.length())
  cases(List<A>) lst:
    | empty => sofar
    | link(first, rest) =>
      reverse(rest, link(first, sofar))
  end
end
}

This has a few problems. First, because Pyret restricts function bodies to have
no more than one expression unless @secref["s:blocky-blocks"] is used, this is
an immediate syntax error. We could change the first line to include
@tt{block:} to let Pyret know we want to allow multiple statements.

@pyret-block{
fun reverse(lst, sofar) block:
}

Second, the uses of @pyret-id["print" "<global>"] lack context. With this
version, we'd simply see sequences of numbers print out, and it would be
difficult to discern which came from which print statement, or what the values
meant. We could add more string information into the output to label the
outputs, which leads to clunky string concatenation expressions like

@pyret-block{
print("lst-length: " + to-string(lst.length()))
}

This ends up being onerous and error prone. In addition, for rich values like
tables and images, the string representation isn't as useful as the rich
rendering that Pyret provides in an interface like code.pyret.org.

The @tt{spy} statement is designed to make it natural and useful to add printed
observations to the program, supporting and enhancing the practice of
“printf-debugging”.

