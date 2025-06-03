#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")
@(require (only-in scribble/manual link))

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

@margin-note{These are selections from @link["https://www.cs.yale.edu/homes/perlis-alan/quotes.html" "Alan Perlis's Epigrams on Programming"]}
The examples on this page work against a small filesystem that is set up every
time the page loads. The filesystem contains the contents below, and the working
directory is @pyret{/}.

@nested[#:style (pre-style "fixed-width")]{
    /
    ├── hello.txt         "Hello, world!"
    ├── data/
    │   ├── words         "apple\nbanana\ncherry"
    │   ├── numbers.txt   "1\n2\n3\n4\n5"
    │   └── story.txt     "A long time ago in a galaxy far, far away..."
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
  words = FS.read-file-string("data/words")
  string-split-all(words, "\n") is [list: "apple", "banana", "cherry"]

  FS.read-file-string("does-not-exist") raises "No such file or directory"
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

@examples[#:show-try-it #t]{
import filesystem as FS
check:
  FS.read-file-string("goodbye.txt") raises "No such file or directory"
  FS.write-file-string("goodbye.txt", "Until next time!")
  FS.read-file-string("goodbye.txt") is "Until next time!"
  FS.write-file-string("goodbye.txt", "See ya!")
  FS.read-file-string("goodbye.txt") is "See ya!"
end
}

@function["stat"
  #:contract (a-arrow S (a-record `((mtime ,N) (ctime ,N) (size ,N))))
  #:args '(("path" ""))
  ]

@margin-note{There is also an optional field called @pyret{native} that may have
additional information sometimes, depending on the platform. The three fields
listed are guaranteed to be present across all platforms.}
Returns an object with statistics about the file: its modified time
(@pyret{mtime}), its creation time (@pyret{ctime}), and its size in bytes
(@pyret{size}).

@examples[#:show-try-it #t]{
import filesystem as FS
check:
  test-start-time = time-now() # gives the current time in milliseconds
  FS.write-file-string("fresh-file.txt", "Brand new!")
  stats = FS.stat("fresh-file.txt")

  spy: stats end

  stats.size is string-length("Brand new!")

  # these tests are just indicating that the file was created and modified after
  # the test started
  stats.mtime is%(_ >= _) test-start-time
  stats.ctime is%(_ >= _) test-start-time
end

}

}