#lang scribble/base

@(require
  "../../scribble-api.rkt"
  (only-in scriblib/footnote note)
  scribble/core)

@title[#:tag "s:gapi"]{Google API Integration}

While not directly part of the Pyret language, the @tt{code.pyret.org}
editor has deep integration with various APIs provided by Google.

@section{API Interfacing}

Instead of using the @hyperlink["https://developers.google.com/api-client-library/javascript/" "Google JS API Client"]
directly, client APIs are loaded by calling @tt{gwrap.load} with a
specification of the following type:

@verbatim{
  (: spec :
     (U { name :: String,
          version :: String,
          [callback :: (<API> -> ?)]
        }
        { url :: String,
          [callback :: (<API> -> ?)]
        }))
}

The first case is equivalent to calling
@tt{gapi.client.load(name, version, callback)}, while the second case is
equivalent to calling @tt{gapi.client.load(url, undefined, callback)} (note
that in this case @tt{url} should be a Google
@hyperlink["https://developers.google.com/discovery/" "API Discovery Service"]
URL). If no @tt{callback} option is given, the call to @tt{gwrap.load} returns
a promise which resolves to the loaded API.

Once the API is loaded, the @tt{gwrap} library returns a wrapped version that
has the same methods as the API which is returned by @{gapi.client.load} does,
with two differences. First, in addition to the argument typically accepted
by the method (note that all API methods take one object as an argument), the
methods accept an optional @tt{skipAuth} argument which, when given, performs
the API request without authentication. The second difference is that the API
methods automatically check for and ensure user authentication (if applicable)
and return a @tt{q} promise which resolves to the API response. In other words,
the @tt{gwrap} library abstracts away both the authentication procedure and
the non-@tt{q} response-handling of the Google API.