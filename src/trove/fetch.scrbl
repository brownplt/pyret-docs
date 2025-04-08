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
  the result is @tt{text/plain}. If any errors occur, returns @pyret{right}
  with that error.  If no errors occur, returns @pyret{left} with the returned
  string body.

@examples{
include fetch
check:
  animals-data = fetch("https://raw.githubusercontent.com/brownplt/pyret-lang/refs/heads/horizon/tests/io-tests/tests/animals-ds-2024.csv")
  spy: animals-data end
  string-contains(animals-data.v, "Name,Species,Sex,Age (years)") is true
end

}

}


}
