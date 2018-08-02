The source of the documentation for the Pyret programming language.

Read the built documentation at https://www.pyret.org/docs/latest/

Learn about the language at https://www.pyret.org.

See the code for the language at https://github.com/brownplt/pyret-lang.

Program in Pyret at https://code.pyret.org.

### Installing

Make sure you [install Racket](https://racket-lang.org/download/).

If you are using a Mac, `racket` will not be runnable automatically.
To make it runnable, say that you are using Racket 6.5 and install the program at
`/Applications/Racket\ v6.5/`, you need to put

    export PATH=$PATH:/Applications/Racket\ v6.5/bin/

to `.bashrc` (if you use Bash) and then restart the shell to make it take
an effect.

Also make sure you have `node` and `npm`.

When you have everything mentioned above, run `make install` to download
additional files needed for compilation.

### Compilation

You can compile the documentation via `make`.
