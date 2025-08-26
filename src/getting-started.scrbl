#lang scribble/base

@(require (only-in scribble/manual link))

@title[#:style '(toc)]{Getting Started and Running Pyret}

The most direct way to Pyret is to visit @url["https://code.pyret.org"], which
runs Pyret entirely within your browser.

There are a few other ways to run Pyret via the command-line and via Visual
Studio Code, and all of these are summarized in @secref["environments"].

If you're interested in a textbook, you can try out
@link["http://papl.cs.brown.edu/2020/" "Programming and Programming Languages
(PAPL)"], which has all its programs in Pyret.

@(table-of-contents)

@include-section["environments/environments.scrbl"]
@include-section["tour.scrbl"]
