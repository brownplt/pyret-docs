#lang scribble/manual

@(require (for-syntax syntax/parse)
          (for-syntax racket/base))

@(define cca (current-command-line-arguments))
@(define VERSION
  (if (> (vector-length cca) 0)
        (vector-ref cca 0)
        ""))

@(define-syntax (include-section/if-set stx)
  (syntax-parse stx
    [(_ envvar-stx:str file:str)
     (let* ((envvar (syntax->datum #'envvar-stx))
            (envvar (getenv envvar)))
       (if envvar
         #'(include-section file)
         #'(void)))]))

@title[#:version @VERSION]{Pyret}


@nested{This document has detailed information on the Pyret grammar and the
behavior of its expression forms and built-in libraries, along with many
examples and some longer descriptions of language design choices. If you want
to do something in a program and you can't find how in this document, feel free
to post a message on the
@link["https://groups.google.com/forum/#!forum/pyret-discuss" "Pyret discussion
list"], and we'll be happy to help.}

@nested{If you want to learn about (or teach!) programming and computer science
using Pyret, check out @link["http://papl.cs.brown.edu/2020/" "Programming and
Programming Languages (PAPL)"], which is a textbook on programming with all its
examples in Pyret.}

@nested{Previous release notes documents have useful information on major
updates over time.

@itemlist[
  @item{@hyperlink["https://www.pyret.org/release-notes/summer-2021.html"]{Summer 2021}}
  @item{@hyperlink["https://www.pyret.org/release-notes/summer-2020.html"]{Summer 2020}}
  @item{@hyperlink["https://groups.google.com/g/pyret-discuss/c/kUr3iIYsheE/m/Z7FTW9ZcEwAJ"]{Fall 2017}}
  @item{@hyperlink["https://groups.google.com/g/pyret-discuss/c/n4yAxubXHyY/m/EJr0yMlwAAAJ"]{Fall 2016}}
  @item{@hyperlink["https://groups.google.com/g/pyret-discuss/c/i1qMU_YP9Tw/m/j67PlQx0CQAJ"]{Summer 2016}}
  @item{@hyperlink["https://www.pyret.org/release-notes/v0.5.html"]{Summer 2014}}
]

}

@include-section["getting-started.scrbl"]

@include-section["language-concepts.scrbl"]

@include-section["libraries.scrbl"]

@include-section["style-guide.scrbl"]

@include-section["internal.scrbl"]

@include-section["glossary.scrbl"]
