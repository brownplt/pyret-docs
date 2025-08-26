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

The
@link["https://marketplace.visualstudio.com/items?itemName=PyretProgrammingLanguage.pyret-parley"
"Pyret VScode Extension"] provides a way to run Pyret code within Visual Studio
Code in an environment similar to code.pyret.org, with a definitions and interactions area.

@subsection{Installing the VScode Extension}

From Visual Studio Code, choose the extensions sidebar options (looks like four
squares with the top right square at an angle). Search for “Pyret” and click on
the extension called “Pyret Interactive Editor for VScode”. You should see a
screen like this, with an option to install, which you can click to add the extension:

@image["src/vscode-install.png"]


@subsection{Opening Files in the VScode Extension}

The extension can be used from desktop Visual Studio Code, in which case it's
generally expected that students or users are able to open files and folders
from their computer in VScode (or get a copy of a folder from version control,
etc). Once a folder is opened (for example with File -> Open Folder...),
clicking on files with the @code{.arr} extension will open them in the editor.
Then you can use the Run button and other editor features as usual.

@image["src/vscode-open.png"]

Pyret programs in open editors will always automatically save on each edit,
there is no need to separately save them. This is independent of the “autosave”
setting in Visual Studio Code, though this behavior may change in a future
release.

@subsection{Use with github.dev}

The extension can also be used from
@link["https://docs.github.com/en/codespaces/the-githubdev-web-based-editor"
"github.dev"]. When visiting any Github repository, the keyboard shortcut
. (that is, a single period) will open that repository in
@code{github.dev}, so the repository folder will already be open. (This requires
being logged into a Github account.)

In new github.dev workspaces, the extension is not installed automatically. A
repository can list @emph{recommended} extensions: the
@link["https://github.com/jpolitz/sample-pyret-project/blob/main/.vscode/extensions.json"
"sample-pyret-project"] repository gives examples of this, and will make it so
users are prompted to install the extension when the workspace opens.

@subsection{Editing Pyret Files with the Default Editor}

For many reasons we might prefer to edit @code{.arr} files without using the
visual editor and instead using the Visual Studio Code default text editor.  To
do this, you can open the context menu on a file and choose “Open With...”,
which will allow you select the visual editor or the plain text editor, and
optionally set your preferred default:

@image["src/open-with.png"]

@image["src/open-with-default.png"]

In plain text editors for Pyret files, there is a ▶ icon at the top of the tab.
Clicking this button will run the program (like using the run button in the
visual editor), and open the interactions area in a new VScode pane to the side.

@image["src/play-button.png"]

@image["src/split-run.png"]


@section{Command Line}




