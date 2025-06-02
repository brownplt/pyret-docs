#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(append-gen-docs
  `(module "filesystem"
    (path "src/arr/trove/filesystem.arr")
    (fun-spec (name "read-file-string") (arity 1))
    (fun-spec (name "write-file-string") (arity 2))
    (fun-spec (name "stat") (arity 1))
    (fun-spec (name "resolve") (arity 1))
    (fun-spec (name "exists") (arity 1))
    (fun-spec (name "join") (arity 2))
    (fun-spec (name "create-dir") (arity 1))
    (fun-spec (name "basename") (arity 1))
    (fun-spec (name "dirname") (arity 1))
    (fun-spec (name "relative") (arity 2))
    (fun-spec (name "is-absolute") (arity 1))
    ))

@nested[#:style (make-style "script" (list (make-alt-tag "script") (make-attributes '((type . "module") (src . "filesystem.js")))))]

The @pyret{filesystem} library provides functions for reading and writing files,
as well as working with paths.

The examples on this page work against a small filesystem that is set up every
time the page loads. The filesystem contains the contents below, and the working
directory is @pyret{/}.

@nested[#:style (pre-style "fixed-width")]{
/hello.txt: "Hello, world!"
}

@docmodule["filesystem"]{

@function["read-file-string"
  #:contract (a-arrow S S)
  #:args '(("path" ""))
  ]

@examples[#:show-try-it #t]{
import filesystem as FS
check:
  FS.read-file-string("hello.txt") is "Hello, world!"
end
}

Reads the file at the given @pyret{path} and returns its contents as a
@pyret{String}. Always assumes UTF-8 encoding.

Reports an error if the file is not found or is not readable.

@function["write-file-string"
  #:contract (a-arrow S S No)
  #:args '(("path" "") ("contents" ""))
  ]

Writes the given @pyret{contents} the file at the given @pyret{path}.  Always
assumes UTF-8 encoding. If the file exists, it is overwritten, and if it does
not exist, it is created.

Reports an error if the path refers to a non-existent directory, or if the file
is present but not writable.

}