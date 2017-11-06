#lang scribble/base
@(require "../../scribble-api.rkt" "../abbrevs.rkt")
@(require (only-in scribble/core delayed-block))

@(define (SD-of typ) (a-app (a-id "StringDict" (xref "string-dict" "StringDict")) typ))
@(define (MSD-of typ) (a-app (a-id "MutableStringDict" (xref "string-dict" "MutableStringDict")) typ))

@(define (sd-method name #:args args #:return ret #:contract contract)
  (method-doc "StringDict" "string-dict" name #:alt-docstrings "" #:args args #:return ret #:contract contract))
@(define (msd-method name #:args args #:return ret #:contract contract)
  (method-doc "MutableStringDict" "string-dict" name #:alt-docstrings "" #:args args #:return ret #:contract contract))

@(append-gen-docs
  `(module "string-dict"
    (path "src/js/base/runtime-anf.js")
    (fun-spec (name "make-mutable-string-dict"))
    (fun-spec (name "make-string-dict"))
    (fun-spec (name "string-dict"))
    (fun-spec (name "mutable-string-dict"))
    (data-spec
      (name "StringDict")
      (type-vars (a-id "a"))
      (variants ("string-dict"))
      (shared (
        (method-spec (name "set"))
        (method-spec (name "get"))
        (method-spec (name "get-value"))
        (method-spec (name "remove"))
        (method-spec (name "keys"))
        (method-spec (name "has-key"))
        (method-spec (name "count"))
        (method-spec (name "unfreeze"))
        (method-spec (name "merge"))
        (method-spec (name "keys-list"))
        (method-spec (name "map-keys"))
        (method-spec (name "fold-keys"))
        (method-spec (name "each-key"))
        )))
    (data-spec
      (name "MutableStringDict")
      (type-vars (a-id "a"))
      (variants ("mutable-string-dict"))
      (shared (
        (method-spec (name "set-now"))
        (method-spec (name "get-now"))
        (method-spec (name "get-value-now"))
        (method-spec (name "remove-now"))
        (method-spec (name "keys-now"))
        (method-spec (name "has-key-now"))
        (method-spec (name "count-now"))
        (method-spec (name "freeze"))
        (method-spec (name "seal"))
        (method-spec (name "merge-now"))
        (method-spec (name "keys-list-now"))
        (method-spec (name "map-keys-now"))
        (method-spec (name "fold-keys-now"))
        (method-spec (name "each-key-now"))
        )))
  ))

@docmodule["string-dict"]{

@ignore[(list "string-dict" "make-string-dict"
"mutable-string-dict" "make-mutable-string-dict")]

@section{The StringDict Type}

@type-spec["StringDict" (list "a")]

There are no variants for @pyret-id{StringDict}s, and programs cannot use
@pyret{cases} statements with @pyret-id{StringDict}s.  Instead, they can be
created with the constructors below, and manipulated with the methods and
functions below.

@pyret-id{StringDict}s keep track of a mapping from @pyret-id["String"
"strings"]s to any Pyret value. A @pyret-id{StringDict} is
immutable, i.e., a mapping cannot be changed; however, a new
@pyret-id{StringDict} can be fashioned from an existing
@pyret-id{StringDict} with a new, omitted, or changed mapping.

A @pyret{StringDict} can unfrozen, i.e.,  used as the basis for
@pyret{MutableStringDict}, which does allow modification (see
below).

@section{StringDict Constructor}

@collection-doc["string-dict" #:contract `(a-arrow ("key" ,S) ("elt" "a") ,(SD-of "a"))]

Creates a string-dict with the given @pyret{elt}s.

@examples{
  sd1 = [string-dict: "a", 5, "b", 10]
}

@section{StringDict Methods}

@sd-method["get"
  #:contract (a-arrow (SD-of "a") S (O-of "a"))
  #:args (list (list "self" #f) (list "key" #f))
  #:return (O-of "a")
]

Returns @pyret-id["none" "option"] if the key is not in the dictionary, and a
@pyret-id["some" "option"] containing the value the key maps to
if the key is in the dictionary.

@examples{
check:
  [string-dict: "a", 5].get("a") is some(5)
  [string-dict: "a", 5].get("b") is none
end
}

@sd-method["get-value"
  #:contract (a-arrow (SD-of "a") S "a")
  #:args (list (list "self" #f) (list "key" #f))
  #:return "a"
]

Returns the value that @pyret{key} maps to if it is present, and throws an
exception otherwise.

@examples{
check:
  [string-dict: "a", 5].get-value("a") is 5
  [string-dict: "a", 5].get-value("b") raises "Key b not found"
end
}

@sd-method["set"
  #:contract (a-arrow (SD-of "a") S "a" (SD-of "a"))
  #:args (list (list "self" #f) (list "key" #f) (list "value" #f))
  #:return (SD-of "a")
]

Returns a new string-dict that maps @pyret{key} to @pyret{value}
and is otherwise similar to the original string-dict.

@examples{
check:
  sd1 = [string-dict: "a", 5, "b", 10]
  sd1.get-value("a") is 5
  sd1.get-value("b") is 10
  sd2 = sd1.set("a", 15)
  sd2.get-value("a") is 15
  sd2.get-value("b") is 10
end
}

@sd-method["has-key"
  #:contract (a-arrow (SD-of "a") S B)
  #:args (list (list "self" #f) (list "key" #f))
  #:return B
]

Returns @pyret{true} if @pyret{key} is in the string-dict; @pyret{false} if not.

@examples{
check:
  sd1 = [string-dict: "a", 5]
  sd1.has-key("a") is true
  sd1.has-key("b") is false
end
}

@sd-method["keys"
  #:contract (a-arrow (SD-of "a") (S-of S))
  #:args (list (list "self" #f))
  #:return (S-of S)
]

Returns the set of keys in the string-dict.

@examples{
check:
  sd1 = [string-dict: "a", 5, "b", 10]
  sd1.keys() is [tree-set: "a", "b"]
  sd1.keys() is [tree-set: "b", "a"]
end
}

@sd-method["remove"
  #:contract (a-arrow (SD-of "a") S (SD-of "a"))
  #:args (list (list "self" #f) (list "key" #f))
  #:return (SD-of "a")
]

Returns a new string-dict that doesn't have the argument key but
is otherwise similar to the original string-dict.

@examples{
check:
  sd1 = [string-dict: "a", 5, "b", 10]
  sd1.has-key("a") is true
  sd1.has-key("b") is true
  sd2 = sd1.remove("b")
  sd2.has-key("a") is true
  sd2.has-key("b") is false
end
}

@sd-method["count"
  #:contract (a-arrow (SD-of "a") N)
  #:args (list (list "self" #f))
  #:return N
]

Returns the number of keys in the string-dict.

@examples{
check:
  sd1 = [string-dict: "a", 5, "b", 10]
  sd1.count() is 2
  sd2 = sd1.set("c", 15)
  sd2.count() is 3
  sd3 = sd1.remove("a")
  sd3.count() is 1
end
}

@sd-method["unfreeze"
  #:contract (a-arrow (SD-of "a") (MSD-of "a"))
  #:args (list (list "self" #f))
  #:return (MSD-of "a")
]

Returns a mutable string-dict that has the same keys and values
as the original string-dict.

@examples{
check:
  sd1 = [string-dict: "a", 5, "b", 10]
  msd1 = sd1.unfreeze()
  msd1.set-now("a", 0)
  msd1.get-value-now("a") is 0
end
}

@sd-method["merge"
  #:contract (a-arrow (SD-of "a") (SD-of "a") (SD-of "a"))
  #:args (list (list "self" #f) (list "other" #f))
  #:return (SD-of "a")
]

Returns a new immutable string-dict that has the keys of both the original
string-dict and the @pyret{other} string-dict. If a key in the resulting
string-dict occurs in only one of the input string-dicts, its value is taken
from that string-dict. If the key occurs in both input string-dicts, its value
is taken from the @pyret{other} string-dict.

@examples{
check:
  sd1 = [string-dict: "a", 5, "c", 4]
  sd2 = [string-dict: "a", 10, "b", 6]
  sd3 = sd1.merge(sd2)
  sd3 is [string-dict: "a", 10, "b", 6, "c", 4]
  sd4 = sd2.merge(sd1)
  sd4 is [string-dict: "a", 5, "b", 6, "c", 4]
  # sd3 is different from sd4
  sd3 is-not sd4
  # merging the same dict a second time has no additional effect
  sd2.merge(sd1).merge(sd1) is sd2.merge(sd1)
end
}

@sd-method["keys-list"
  #:contract (a-arrow (SD-of "a") (L-of S))
  #:args (list (list "self" #f))
  #:return (L-of S)
]

Returns the list of keys in the immutable string-dict, in some unspecified order.

@examples{
check:
  sd2 = [string-dict: "a", 10, "b", 6]
  sd2.keys-list().sort() is [list: "a", "b"]
end
}

@sd-method["map-keys"
  #:contract (a-arrow (SD-of "a") (a-arrow "a" "b") (L-of "b"))
  #:args (list (list "self" #f) (list "f" #f))
  #:return (L-of "b")
]

Applies the function @pyret{f} to each key in the immutable string-dict, and
returns a list of the returned values in some unspecified order.

@examples{
check:
  sd2 = [string-dict: "a", 10, "b", 6]
  sd2.map-keys(lam(x): string-append(x, x) end) is%(lam(lft, rt): rt.member(lft) end)
    [list: [list: "aa", "bb"], [list: "bb", "aa"]]
end
}

@sd-method["fold-keys"
  #:contract (a-arrow (SD-of "a") (a-arrow S "b") "b")
  #:args (list (list "self" #f) (list "f" #f) (list "init" #f))
  #:return "b"
]

Returns the result of folding the function @pyret{f} across the keys in the
immutable string-dict, in some unspecified order, starting with @pyret{init} as
the base value.

@examples{
check:
  sd2 = [string-dict: "a", 10, "b", 6]
  sd2.fold-keys(lam(x, acc): acc + string-length(x) end, 0) is 2
end
}

@sd-method["each-key"
  #:contract (a-arrow (SD-of "a") (a-arrow S No) No)
  #:args (list (list "self" #f) (list "f" #f))
  #:return No
]

Calls the function @pyret{f} on each key in the immutable string-dict,
returning nothing. Use @pyret{each-key} instead of @pyret{map-keys}
when the function @pyret{f} is used only for its side-effects.

@examples{
var numkeys = 0

check:
  sd2 = [string-dict: "a", 10, "b", 6]
  sd2.each-key(lam(x): numkeys := numkeys + 1 end) is nothing
  numkeys is 2
end
}

@section{The MutableStringDict Type}

@type-spec["MutableStringDict" (list "a")]

There are no variants for @pyret-id{MutableStringDict}s, and
programs cannot use @pyret{cases} statements with
@pyret-id{MutableStringDict}s. Instead, they can be created with
the constructors below, and manipulated with the methods and
functions below.

@pyret-id{MutableStringDict}s keep track of a mapping from
@pyret-id["String" "strings"]s to any Pyret value. In contrast to
@pyret-id{StringDict}s, a @pyret{MutableStringDict} can have
mappings added, deleted, or changed.

A @pyret-id{MutableStringDict} can be sealed to produce a variant
that is read-only. A @pyret-id{MutableStringDict} can also be
frozen to produce an immutable @pyret-id{StringDict} (see above).

@section{MutableStringDict Constructor}

@collection-doc["mutable-string-dict" #:contract `(a-arrow ("elt" "a") ,(SD-of "a"))]

Creates an mutable string-dict with the given @pyret{elt}s.

@examples{
  msd1 = [mutable-string-dict: "a", 5, "b", 10]
}

@section{MutableStringDict Methods}

@msd-method["get-now"
  #:contract (a-arrow (MSD-of "a") S (O-of "a"))
  #:args (list (list "self" #f) (list "key" #f))
  #:return (O-of "a")
]

Returns @pyret-id["none" "option"] if the key is not in the dictionary, and a
@pyret-id["some" "option"] containing the value the key maps to
if the key is in the dictionary.

@examples{
check:
  [mutable-string-dict: "a", 5].get-now("a") is some(5)
  [mutable-string-dict: "a", 5].get-now("b") is none
end
}

@msd-method["get-value-now"
  #:contract (a-arrow (MSD-of "a") S "a")
  #:args (list (list "self" #f) (list "key" #f))
  #:return "a"
]

Returns the value that @pyret{key} maps to if it is present, and throws an
exception otherwise.

@examples{
check:
  [mutable-string-dict: "a", 5].get-value-now("a") is 5
  [mutable-string-dict: "a", 5].get-value-now("b") raises "Key b not found"
end
}

@msd-method["set-now"
  #:contract (a-arrow (MSD-of "a") S "a" No)
  #:args (list (list "self" #f) (list "key" #f) (list "value" #f))
  #:return No
]

Modifies the mutable-string-dict so that it now maps @pyret{key}
to @pyret{value}. This method is called only for its side-effect
and so returns @pyret{nothing}

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5, "b", 10]
  msd1.get-value-now("a") is 5
  msd1.get-value-now("b") is 10
  msd1.set-now("a", 15) is nothing
  msd1.get-value-now("a") is 15
  msd1.get-value-now("b") is 10
end
}

@msd-method["has-key-now"
  #:contract (a-arrow (MSD-of "a") S B)
  #:args (list (list "self" #f) (list "key" #f))
  #:return B
]

Returns @pyret{true} if @pyret{key} is in the string-dict; @pyret{false} if not.

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5]
  msd1.has-key-now("a") is true
  msd1.has-key-now("b") is false
end
}

@msd-method["keys-now"
  #:contract (a-arrow (MSD-of "a") (S-of S))
  #:args (list (list "self" #f))
  #:return (S-of S)
]

Returns the set of keys in the string-dict.

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5, "b", 10]
  msd1.keys-now() is [tree-set: "a", "b"]
  msd1.keys-now() is [tree-set: "b", "a"]
end
}

@msd-method["remove-now"
  #:contract (a-arrow (MSD-of "a") S No)
  #:args (list (list "self" #f) (list "key" #f))
  #:return No
]

Modifies the mutable-string-dict so that it no longer has the
argument @pyret{key}.

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5, "b", 10]
  msd1.has-key-now("a") is true
  msd1.has-key-now("b") is true
  msd1.remove-now("b") is nothing
  msd1.has-key-now("a") is true
  msd1.has-key-now("b") is false
end
}

@msd-method["count-now"
  #:contract (a-arrow (MSD-of "a") N)
  #:args (list (list "self" #f))
  #:return N
]

Returns the number of keys in the mutable-string-dict.

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5, "b", 10]
  msd1.count-now() is 2
  msd1.set-now("c", 15)
  msd1.count-now() is 3
  msd1.remove-now("a")
  msd1.count-now() is 2
end
}

@msd-method["freeze"
  #:contract (a-arrow (MSD-of "a") (SD-of "a"))
  #:args (list (list "self" #f))
  #:return (SD-of "a")
]

Returns an immutable string-dict that has the same keys and
values as the mutable one.

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5, "b", 10]
  sd1 = msd1.freeze()
  sd2 = sd1.set("a", 10)
  sd2.get-value("a") is 10
  sd1.get-value("a") is 5
end
}

@msd-method["seal"
  #:contract (a-arrow (MSD-of "a") (MSD-of "a"))
  #:args (list (list "self" #f))
  #:return (MSD-of "a")
]

Returns a sealed version of the mutable-string-dict that has the
same keys and values, but does not allow modification. The
original mutable-string-dict continues to be modifiable, and such
modifications will be visible in the sealed one.

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5, "b", 10]
  smsd1 = msd1.seal()
  smsd1.get-value-now("a") is 5
  smsd1.set-now("a", 15) raises "Cannot modify sealed string dict"
  msd1.set-now("a", 15) is nothing
  msd1.get-value-now("a") is 15
  smsd1.get-value-now("a") is 15
end
}

@msd-method["merge-now"
  #:contract (a-arrow (MSD-of "a") (MSD-of "a") No)
  #:args (list (list "self" #f) (list "other" #f))
  #:return No
]

Modifies the mutable string-dict to include the keys from the @pyret{other}
mutable-string-dict. If a key occurs originally in only of the string-dicts, its final 
value is taken from that string-dict. If a key occurs originally in both
the string-dicts, its value is taken from the @pyret{other} string-dict.
@pyret{merge-now} returns nothing.

@examples{
check:
  msd1 = [mutable-string-dict: "a", 5, "c", 4]
  msd2 = [mutable-string-dict: "a", 10, "b", 6]
  msd1.get-value-now("a") is 5
  msd1.get-value-now("b") raises "Key b not found"
  msd1.get-value-now("c") is 4
  msd1.merge-now(msd2) is nothing
  # msd1 already had key "a", but updates its new value from msd2
  msd1.get-value-now("a") is 10
  # msd1 did not have key "b", so gets it from msd2
  msd1.get-value-now("b") is 6
  # msd2 doesn't have key "c", so msd1 keeps its value for "c"
  msd1.get-value-now("c") is 4
end
}

@msd-method["keys-list-now"
  #:contract (a-arrow (MSD-of "a") (L-of S))
  #:args (list (list "self" #f))
  #:return (L-of S)
]

Returns the list of keys in the mutable string-dict, in some unspeicified order.

@examples{
check:
  msd2 = [mutable-string-dict: "a", 10, "b", 6]
  msd2.keys-list-now().sort() is [list: "a", "b"]
end
}

@msd-method["map-keys-now"
  #:contract (a-arrow (MSD-of "a") (a-arrow "a" "b") (L-of "b"))
  #:args (list (list "self" #f) (list "f" #f))
  #:return (L-of "b")
]

Applies the function @pyret{f} to each key in the mutable-string-dict,
and returns a list of the returned values in some unspecified order.

@examples{
check:
  msd2 = [mutable-string-dict: "a", 10, "b", 6]
  msd2.map-keys-now(lam(x): string-append(x, x) end) is%(lam(lft, rt): rt.member(lft) end)
    [list: [list: "aa", "bb"], [list: "bb", "aa"]]
end
}

@msd-method["fold-keys-now"
  #:contract (a-arrow (MSD-of "a") (a-arrow S "b") "b")
  #:args (list (list "self" #f) (list "f" #f) (list "init" #f))
  #:return "b"
]

Returns the result of folding the function @pyret{f} across the keys in the
mutable string-dict, in some unspecified order, starting with @pyret{init} as
the base value.

@examples{
check:
  msd2 = [mutable-string-dict: "a", 10, "b", 6]
  msd2.fold-keys-now(lam(x, acc): acc + string-length(x) end, 0) is 2
end
}

@msd-method["each-key-now"
  #:contract (a-arrow (MSD-of "a") (a-arrow S No) No)
  #:args (list (list "self" #f) (list "f" #f))
  #:return No
]

Calls the function @pyret{f} on each key in the mutable string-dict,
returning nothing. Use @pyret{each-key-now} instead of @pyret{map-keys-now}
when the function @pyret{f} is used only for its side-effects.

@examples{
var numkeys = 0

check:
  msd2 = [mutable-string-dict: "a", 10, "b", 6]
  msd2.each-key-now(lam(x): numkeys := numkeys + 1 end) is nothing
  numkeys is 2
end
}
}
