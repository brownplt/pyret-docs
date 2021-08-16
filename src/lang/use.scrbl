#lang scribble/base

@(require "../../scribble-api.rkt")
@(append-gen-docs
  `(module "use" (path #f)
    (form-spec (name "use context"))))

@docmodule["use" #:noimport #t #:friendly-title "Use"]{


@section[#:tag "s:use:context"]{Contexts}

@form["use context" "use context <import>"]{

@seclink["modules" "Modules"] are a useful mechanism for providing and
including names between different parts of a program that is split across
files. One limitation of modules is that importing or including names from a
module is strictly @bold{additive} – including can only make @bold{more names}
available. For different course contexts and applications, sometimes we want
more control over exactly which names are available, including leaving some
out, or redefining some common names ourselves.

This is what @tt{use context} is for. The meaning of @tt{use context} is to
start the program in an context with no names at all available, and then adding
only what's provided from the module listed after @tt{context} @tt{<import>}.
The @tt{<import>} part of  @tt{use context} line can use any of the
@seclink["s:modules:finding-modules" "dependency types"].
}

As an example, consider an assignment where students write their own
implementation of lists, defining functions named @tt{map}, @tt{filter}, and so
on. In this case, the context they use should not be the default context
(because it already has @tt{map} and so on):

@pyret-block[#:style "bad-ex"]{
use context essentials2021

data List<A>:
  | empty
  | link(first :: A, rest :: List<A>)
end

# causes a shadowing error because empty and link already are defined and
# provided by essentials2021
}

You could create a context with just a limited set of global names, and publish
it as a @tt{shared-gdrive} module:

@pyret-block[#:style "good-ex"]{
# In file "list-assignment-context.arr"
use context global # This is a good default environment to use when constructing namespaces
# Basic functions/types like num-max, to-string, Number, String
import global as G
provide from G: *, type * end

# Option and Either might be used as return types for some list functions,
# so provide those
import option as O
provide from O: *, type * end

import either as E
provide from E: *, type * end
}

Then students could use that module as their context:

@pyret-block[#:style "good-ex"]{
use context shared-gdrive("list-assignment-context.arr", "google-id-goes-here")

data List<A>:
  | empty
  | link(first :: A, rest :: List<A>)
end
}







@subsection[#:tag "s:use:compat"]{Backwards and Forwards Compatibility}

By default, until @tt{use context} was released, all Pyret programs had a
single default context. It had provided common names related to, for example,
@seclink["lists" "Lists"] and @seclink["option" "Option"].  Now files that
don't have a @tt{use} line are treated as if they start with @tt{use context
essentials2020}, which is equivalent to this historically available default
context. The online environment @hyperlink["https://code.pyret.org"
"code.pyret.org"] inserts @tt{use context essentialsYEAR} into new programs,
where @tt{YEAR} will change when new useful names are available. Notably,
@tt{essentials2021} includes all of the names for the untyped @seclink["image"
"Image"] library by default, removing the need to @tt{include image} in new
programs.

Existing contexts provided by Pyret, like @tt{essentials2020} and
@tt{essentials2021}, aren't intended to change the names they provide, so files
with a @tt{use context} line won't have their set of available names changed
with updates to the language. This is important for @bold{forwards}
compatibility, because Pyret is particular about @seclink["s:shadowing"
"shadowing"], so context stability ensures that definitions in files using a
context in this way won't suddenly shadow a newly-provided name after an
update.

In general, if you are the author of a context, you should carefully consider
whether you want to add new names to an existing context, or create a new
context with new names. The decision is mostly based on if active users are
likely to have their own definitions of newly-provided names, because changing
the context could cause a shadowing error in that case.

This means that sometimes programmers will want to manually update the year in
a context, if it's convenient for getting access to some new library function.
Of course, they could always add the appropriate @tt{import} statement to
access it directly.


}

