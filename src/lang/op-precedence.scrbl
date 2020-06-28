#lang scribble/base

@(require "../../scribble-api.rkt")
@(append-gen-docs
  `(module "op-precedence" (path "src/js/base/runtime.js")))

@docmodule["op-precedence" #:noimport #t #:friendly-title "Combining Multiple Operators"]

Pyret has only one rule for using multiple operators in a single expression:
different operators must be explicitly grouped by parentheses, and evaluation
always proceeds from left to right.

Therefore, the following expressions are @bold{not} allowed:

@pyret-block[#:style "bad-ex"]{
1 + 1 - 1
1 + 1 > 1
1 + 1 == 2
(3 * 4 / 2)
(3 * 4) / 1 + 1
3 * (4 / 2) + 1
}

And will raise an error like: 

@(image "src/lang/binop-error.png")

Pyret disallows mixing operators without clearly defining the operator
precedence using parentheses.  Conversely, any number of identical operators
can be grouped without pairwise parentheses.  These expressions are all valid
in Pyret:

@pyret-block[#:style "good-ex"]{
1 + (1 - 1)
(1 + 1) > 1
1 + 1 + 1
1 - 1 - 1
(1 + 1) == 2
3 * (4 / 2)
(3 * (4 / 2))
(3 * 4) / (1 + 1)
(3 * (4 / 2)) + 1
}
                                                                        

@section{But why not use precedence?}

Pyret does not use implicit operator precedence or the order of operations that
you learned in math class.  ``Please Excuse My Dear Aunt Sally'' does not apply
here.@margin-note{Note for non-American readers: if you've never heard of dear
Aunt Sally, it's a
@hyperlink["https://en.wikipedia.org/wiki/Order_of_operations#Mnemonics"]{mnemonic}
often used to memorize a standard order-of-operations.}

Implicit operator precedence is a common source of errors among even
experienced developers, so getting in the habit of explicitly defining
precedence using parentheses is a good idea even when using languages
that support implicit precedence.

Pyret has many operators, besides just the arithmetic ones:
@seclink["s:binop-expr"]{comparison and logical operators},
@seclink["types-of-equality"]{equality operators},
@seclink["testing-operators"]{testing operators}, and others.  While it's
possible to memorize the precedence among just a few of these operations, it's
both tedious and unenlightening to memorize precedences among every possible
combination of operators.  Instead, parentheses make the programmer's intent
explicit.

To make life easier, as said above, Pyret allows you to group multiple uses of
the same operator without parentheses: instead of having to write
@pyret{(1 + (2 + 3)) + 4}, you can simply write @pyret{1 + 2 + 3 + 4}.  The
astute reader may immediately object that while this seems fine for addition,
it may be confusing for subtraction: after all, @pyret{1 - (2 - 3)} produces a
different result than @pyret{(1 - 2) - 3}, because subtraction is not
associative.  Even this is more subtle than it may seem at first:
@emph{roughnums} are not associative even for addition!
@pyret-block{
check:
  (~100000000000000 + ~-100000000000000) + ~0.0001 is-roughly ~0.0001
  ~100000000000000 + (~-100000000000000 + ~0.0001) is-roughly ~0
end
}

A similarly nuanced problem occurs with comparison operators: writing
@pyret{1 < 2 < 3} is @emph{legal}, but will produce an error at runtime,
because @pyret{true} cannot be compared to @pyret{3}.  Likewise,
@pyret{1 == 1 == 1} will produce @pyret{false}, because @pyret{1 == 1}
evaluates to @pyret{true}, which is not equal to @pyret{1}.  Some
other languages attempt to make these expressions ``work'' and evaluate to
true, but by doing so they've effectively created new operators that
take in @emph{three} arguments, since their behavior cannot be expressed in
terms of any pairwise usage of a binary operator.

Pyret takes the firm stance that since every operator has its own quirks, it
does not make sense to create a complex, hard-to-predict set of rules for how
different operators interact.  Instead, it uses just one single rule, with the
easy use of parentheses to resolve any unintended behaviors.
