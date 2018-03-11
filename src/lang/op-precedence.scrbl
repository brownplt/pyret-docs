#lang scribble/base

@(require "../../scribble-api.rkt")
@(append-gen-docs
  `(module "op-precedence" (path "src/js/base/runtime.js")))

@docmodule["op-precedence" #:noimport #t #:friendly-title "Operator Precedence"]

Pyret does not use implicit operator precedence or the order of operations that
you learned in math class.  ``Please Excuse My Dear Aunt Sally'' does not apply
here.@margin-note{Note for non-American readers: if you've never heard of dear
Aunt Sally, it's a
@hyperlink["https://en.wikipedia.org/wiki/Order_of_operations#Mnemonics"]{mnemonic}
often used to memorize a standard order-of-operations.}

Pyret disallows mixing operators without clearly defining the
operator precedence using parentheses.  This includes all @secref["s:binop-expr"].

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

Conversely, these expressions are all valid in Pyret:

@margin-note{Any number of identical operators can be grouped without pairwise
parentheses.}

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

Implicit operator precedence is a common source of errors among even
experienced developers, so getting in the habit of explicitly defining
precedence using parentheses is a good idea even when using languages
that support implicit precedence.
                                                                        
