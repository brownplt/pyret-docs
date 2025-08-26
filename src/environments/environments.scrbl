#lang scribble/manual

@(require "../../scribble-api.rkt")

@title[#:tag "environments"]{Environments}

This section summarizes the different @emph{environments} in which Pyret can
run.  Most features are available across all environments, there are some that
only work in particular settings.

Elsewhere in the documentation you may see features flagged with

@cpo-only{@para{Behavior that is specific to, or works only in,
@url["https://code.pyret.org"]. These typically require using a Google-specific
API to access files in Google Drive.}}

@vscode-only{@para{Behavior that is specific to, or works only in, the Visual
Studio Code extension.}}

@cli-only{@para{Behavior that is specific to, or works only in, the command line.}}

A common combination is:

@vscode-cli-only{@para{Behavior that is specific to, or works only in, the Visual
Studio Code extension @emph{or} at the command-line. This typically has to do
with accessing the filesystem.}}

@section{code.pyret.org}

The website @url["https://code.pyret.org"] lets you run Pyret code directly in
your browser, and connect to Google Drive to save and share programs you write.

@section{VScode Extension}

@section{Command Line}
