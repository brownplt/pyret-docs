#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt" scriblib/footnote (only-in scribble/manual link))

@(append-gen-docs
  '(module "strings"
    (path "src/js/base/runtime-anf.js")
    (data-spec
      (name "String")
      (variants)
      (shared))
    (fun-spec
      (name "string-equal")
      (arity 2)
      (args ("s1" "s2"))
      (doc ""))
    (fun-spec
      (name "string-contains")
      (arity 2)
      (args ("string-to-search" "string-to-find"))
      (doc ""))
    (fun-spec
      (name "string-append")
      (arity 2)
      (args ("front" "back"))
      (doc ""))
    (fun-spec
      (name "string-length")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-to-number")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-repeat")
      (arity 2)
      (args ("s" "n"))
      (doc ""))
    (fun-spec
      (name "string-substring")
      (arity 3)
      (args ("s" "start-index" "end-index"))
      (doc ""))
    (fun-spec
      (name "string-replace")
      (arity 3)
      (args ("original-string" "string-to-find" "replacement-string"))
      (doc ""))
    (fun-spec
      (name "string-split")
      (arity 2)
      (args ("original-string" "string-to-split-on"))
      (doc ""))
    (fun-spec
      (name "string-split-all")
      (arity 2)
      (args ("original-string" "string-to-split-on"))
      (doc ""))
    (fun-spec
      (name "string-char-at")
      (arity 2)
      (args ("s" "n"))
      (doc ""))
    (fun-spec
      (name "string-to-upper")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-toupper")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-to-lower")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-tolower")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-explode")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-index-of")
      (arity 2)
      (args ("original-string" "string-to-find"))
      (doc ""))
    (fun-spec
      (name "string-to-code-point")
      (arity 1)
      (args ("s"))
      (doc ""))
    (fun-spec
      (name "string-from-code-point")
      (arity 1)
      (args ("code"))
      (doc ""))
    (fun-spec
      (name "string-to-code-points")
      (arity 1)
      (args ("codes"))
      (doc ""))
    (fun-spec
      (name "string-from-code-points")
      (arity 1)
      (args ("codes"))
      (doc ""))
      ))

@docmodule["strings" #:noimport #t #:friendly-title "Strings"]{

@type-spec["String" (list)]{

The type of string values.}
                                                               
A @pyret{String} is a fixed-length array of characters.  This includes not only letters in
the Latin alphabet and numerals, but any Unicode character, including languages
using non-Latin characters, such as Arabic, Russian or Chinese, as well as emoji
defined in the Unicode specification.

@(image "src/builtin/valid-string.png")

@margin-note{If you click on printed strings in the interactive window,
the display will toggle between the character itself and the relevant
Unicode escape code or codes.}

@(image "src/builtin/codes.png")

Internally, a Pyret @pyret{String} is implemented as a JavaScript
@tt{JSString}.  See the @seclink["runtime"] for more context.

@margin-note{One implication of how JavaScript handles Unicode characters is
that characters that are identified by a Unicode code point greater than
65535 are sometimes treated as two characters by Pyret, as noted below.}


@section{String Functions}

  @function["string-equal" #:contract (a-arrow S S B) #:return B]

Returns @pyret{true} if the two strings are equal.
  
@examples{
check:
  string-equal("abc", "abc") is true
  "abc" is%(string-equal) "abc"
  "abc" == "abc" is true
  string-equal("ab", "abc") is false
  string-equal("abc     ", "abc") is false
end
}

  @function["string-contains" #:contract (a-arrow S S B) #:return B]

Returns @pyret{true} if @pyret{string-to-find} is contained in
@pyret{string-to-search}.  Returns @pyret{true} if an empty string is passed as
@pyret{string-to-find}.
  
@examples{
check:
  string-contains("Ahoy, world!", "world") is true
  string-contains("Ahoy, World!", "world") is false
  string-contains("world", "Ahoy world") is false
  string-contains("same string", "same string") is true
  string-contains("", "") is true
  string-contains("any string", "") is true
end
}

  @function["string-append" #:contract (a-arrow S S S) #:return S]

Returns a @pyret{String} where @pyret{back} is added to the right of
@pyret{front}.
  
@examples{
check:
  string-append("a", "b") is "ab"
  string-append("same", "same") is "samesame"
  string-append("", "") is ""
  string-append("", "a") is "a"
  string-append("a", "") is "a"
end
}

  @function["string-length" #:contract (a-arrow S N) #:return N]

Returns the number of characters in the string.

@margin-note{@pyret{string-length} reports a count of @pyret{2}
for code points over 65535.}

@examples{
check:
  string-length("") is 0
  string-length("    ") is 4
  string-length("four") is 4
  string-length("🏏") is 2
end
}

  @function["string-to-number" #:contract (a-arrow S N) #:return (O-of N)]

Converts the argument string to a number, returning @pyret-id["none" "option"]
if it is not a valid numeric string, and @pyret-id["some" "option"] number if it is.

@pyret-id{string-to-number} is strict about its inputs, and recognizes exactly
the same numbers that Pyret itself does: no surrounding whitespace, extra
punctuation, or trailing characters are allowed.

@examples{
check:
  string-to-number("100") is some(100)
  string-to-number("not-a-number") is none
  string-to-number(" 100") is none
  string-to-number("100abc") is none
  string-to-number("1,000") is none
  string-to-number("1-800-555-1212") is none
end
}

  @function["string-repeat" #:contract (a-arrow S N S) #:return S]

@examples{
check:
  string-repeat("a", 5) is "aaaaa"
  string-repeat("", 1000000) is ""
  string-repeat("word ", 3) is "word word word "
  string-repeat("long string", 0) is ""
end
}

  @function["string-substring" #:contract (a-arrow S N N S) #:return S]

Returns a new string created from the characters of the input string, starting
from @pyret{start-index} (inclusive) and ending at @pyret{end-index} (exclusive).
Raises an exception if @pyret{start-index} is greater than @pyret{end-index}, if @pyret{start-index}
is greater than the length of the string, or if @pyret{end-index} is less than 0.

The returned string always has length @pyret{end-index} - @pyret{start-index}.

@margin-note{@pyret{String} indexes are counted starting from zero for the
first character.}

@examples{
check:
  string-substring("just the first", 0, 1) is "j"
  string-substring("same index", 4, 4) is ""
  
  tws = "length is 12"
  string-substring(tws, 4, 6) is "th"
  string-substring(tws, string-length(tws) - 1, string-length(tws)) is "2"
  string-substring(tws, 6, 4) raises "index"
  string-substring(tws, 6, 13) raises "index"
  string-substring(tws, 13, 6) raises "index"
  string-substring(tws, -1, 10) raises "index"
end
}

  @function["string-index-of" #:contract (a-arrow S S N) #:return N]

  Returns the index from the beginning of the string where
  @pyret{string-to-find} @emph{first} appears, or @pyret{-1} if the string
  isn't found.

@examples{
check:
  string-index-of("Pyret", "P") is 0
  string-index-of("012🤑45", "🤑") is 3
  string-index-of("🤔🤔🤔", "🤒") is -1
end
}
  
  @function["string-replace" #:contract (a-arrow S S S S) #:return S]

Returns a string where each instance of @pyret{string-to-find} in the
@pyret{original-string} is replaced by @pyret{replacement-string}.

If the string to find is empty @pyret{""}, the @pyret{replacement-string}
will be added between characters but not at the beginning or end of the
string.
  
@examples{
check:
  string-replace("spaces to hyphens", " ", "-") is "spaces-to-hyphens"
  string-replace("remove: the: colons", ":", "") is "remove the colons"
  string-replace("😊😊🤕😊", "🤕", "😊") is "😊😊😊😊"
  string-replace("rinky dinky", "inky", "azzle") is "razzle dazzle"
  string-replace("a string", "not found", "not replaced") is "a string"
  string-replace("", "", "c") is ""
  string-replace("aaa", "", "b") is "ababa"
end
}

  @function["string-split" #:contract (a-arrow S S (L-of S)) #:return (L-of S)]

  Searches for @pyret{string-to-split-on} in @pyret{original-string}.  If it is not found,
  returns a @pyret-id["List" "lists"] containing @pyret{original-string} as its
  single element.

  If it is found, it returns a two-element @pyret-id["List" "lists"], whose
  first element is the portion of the string before @emph{first} occurence of
  @pyret{string-to-split-on}.  The second element contains the portion of the string
  after.  The @pyret{string-to-split-on} is @bold{not} included in either string.  The
  string before and the string after might be empty.

  For splitting beyond the first occurence of the string, see
  @pyret-id["string-split-all"].

@examples{
check:
  string-split("string", "not found") is [list: "string"]
  string-split("string", "g") is [list: "strin", ""]
  string-split("string", "") is [list: "", "string"]
  string-split("a-b-c", "-") is [list: "a", "b-c"]
end
}

  @function["string-split-all" #:contract (a-arrow S S) #:return (L-of S)]

  Searches for @pyret{string-to-split-on} in @pyret{original-string}.  If it is not found,
  returns a @pyret-id["List" "lists"] containing @pyret{original-string} as its
  single element.

  If it is found, it returns a @pyret-id["List" "lists"], whose elements are
  the portions of the string that appear in between occurences of
  @pyret{string-to-split-on}.  A match at the beginning or end of the string will add
  an empty string to the beginning or end of the list, respectively.  The empty
  string matches in between every pair of characters.

@examples{
check:
  string-split-all("string", "not found") is [list: "string"]
  string-split-all("a-b-c", "-") is [list: "a", "b", "c"]
  string-split-all("split on spaces", " ") is [list: "split", "on", "spaces"]
  string-split-all("explode", "") is [list: "e", "x", "p", "l", "o", "d", "e"]
  string-split-all("bananarama", "na") is [list: "ba", "", "rama"]
  string-split-all("bananarama", "a") is [list: "b", "n", "n", "r", "m", ""]
end
}
  @function["string-explode" #:contract (a-arrow S (L-of S)) #:return (L-of S)]

  A shorthand for @pyret{string-split-all(s, "")}.

  @function["string-char-at" #:contract (a-arrow S N S) #:return S]

Returns a @pyret{String} containing the character at the string index @pyret{n}
from @pyret{String} @pyret{n}.

@examples{
check:
  string-char-at("abc", 1) is "b"
  string-char-at("a", 0) is "a"
end
}

  @function["string-toupper" #:contract (a-arrow S S) #:return S]

  The same as @pyret{string-to-upper}.

  @function["string-to-upper" #:contract (a-arrow S S) #:return S]

@margin-note{Pyret uses JavaScript's built-in string operations, and so will
have the same behavior as @link["https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toUpperCase" "toUpperCase"].}
Convert a string to all uppercase characters.  Punctuation and other characters
without an uppercase equivalent are left alone.  Note that because of
characters like @pyret{ß}, the length of the input is not guaranteed to
match the length of the output.

@examples{
check:
  string-to-upper("a") is "A"
  string-to-upper("I'm not yelling!") is "I'M NOT YELLING!"
  string-to-upper("ß") is "SS"
  string-to-upper("λαμβδα") is "ΛΑΜΒΔΑ"
  string-to-upper("😊") is "😊"
  string-to-upper(" ﷵ‎") is " ﷵ‎"
end
}

When performing case-insensitive comparisons, it can be useful to convert both
strings to uppercase first:


@examples{
check:
  string-to-upper("E.E. Cummings") is string-to-upper("e.e. cummings")
end
}


  @function["string-tolower" #:contract (a-arrow S S) #:return S]

  The same as @pyret{string-to-lower}.

  @function["string-to-lower" #:contract (a-arrow S S) #:return S]

Converts a @pyret{String} to all lower case.
  
@examples{
check:
  string-to-lower("A") is "a"
  string-to-lower("I'M NOT YELLING!") is "i'm not yelling!"
  string-to-lower("SS") is "ss"
  string-to-lower("ΛΑΜΒΔΑ") is "λαμβδα"
end
}

  @function["string-to-code-point" #:contract (a-arrow S N) #:return N]

  @note{For strings
  that contain a single character whose code point is greater than
  @pyret{65535}, this function raises an error.
  To get multiple codes at once for a longer string (or a string with larger code points), use
  @pyret-id{string-to-code-points}.}

  Converts @pyret{s}, which must be a single-character @pyret{String}, to a character
  code -- a @pyret{Number} corresponding to its Unicode code point
  (@url["http://en.wikipedia.org/wiki/Code_point"]).
  

  @examples{
check:
  string-to-code-point("a") is 97
  string-to-code-point("\n") is 10
  string-to-code-point("λ") is 955
end
  }

  @function["string-to-code-points" #:contract (a-arrow S (L-of N)) #:return (L-of N)]

  Converts the string (of any length) to a list of code points.  Note that
  strings are encoded in such a way that some characters correspond to two code
  points (see the note in @pyret-id{string-to-code-point}).

@examples{
check:
  string-to-code-points("") is [list:]
  string-to-code-points("abc") is [list: 97, 98, 99]
  string-to-code-points("😊") is [list: 55357, 56842]
  string-to-code-points("𝄞") is [list: 55348, 56606] 
end
}

  @function["string-from-code-point" #:contract (a-arrow N S) #:return S]

  @note{Code points greater than 65535 are not supported.  You must encode
  higher code points with a @link["http://en.wikipedia.org/wiki/UTF-16"
  "surrogate pair"] in combination with
  @pyret-id{string-from-code-points} and @pyret-id{string-to-code-points}.}

  Converts the code point @pyret{code} to a Pyret string.

@examples{
check:
  string-from-code-point(97) is "a"
  string-from-code-point(10) is "\n"
  string-from-code-point(955) is "λ"
end
}

  @function["string-from-code-points" #:contract (a-arrow (L-of N) S) #:return S]

  Converts from a list of code points to a Pyret string.

@examples{
check:
  string-from-code-points([list:]) is ""
  string-from-code-points([list: 97, 98, 99]) is "abc"
  string-from-code-points([list: 55348, 56606]) is "𝄞"
end
}

}
