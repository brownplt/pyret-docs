#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")

@(append-gen-docs
  `(module "fetch"
    (path "src/arr/trove/fetch.arr")
    (fun-spec (name "fetch") (arity 1))))

@docmodule["fetch"]{

@function["fetch"
  #:contract (a-arrow S (E-of S S))
  #:args '(("url" ""))
  #:return (E-of S S)
  ]{

  Fetches the content at the given @pyret{url} with HTTP GET, expecting that
  the result is @tt{text/plain}.

  If no errors occur, returns @pyret-id["left" "either"] with the returned
  string body. The user is expected to decompose this string
  using @pyret-id["string" "String"] or other functions.

  If any errors occur, returns @pyret-id["right" "either"] with that error as a string.

@examples[#:show-try-it #t]{
import fetch as F
import either as Ei


check:
  animals = F.fetch("https://raw.githubusercontent.com/brownplt/pyret-lang/refs/heads/horizon/tests/io-tests/tests/animals-ds-2024.csv")
  animals satisfies Ei.is-left
  string-contains(animals.v, "Name,Species,Sex,Age") is true
  
  bad-fetch = F.fetch("https://raw.githubusercontent.com/NO-SUCH-URL")
  bad-fetch satisfies Ei.is-right
end
}

}

}
