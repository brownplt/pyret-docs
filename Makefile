all:
	scribble \
    ++style ./node_modules/codemirror/lib/codemirror.css \
    ++extra ./node_modules/codemirror/lib/codemirror.js \
    ++extra ./node_modules/codemirror/addon/runmode/runmode.js \
    \
    ++extra ./node_modules/pyret-codemirror-mode/mode/pyret.js \
    ++style ./node_modules/pyret-codemirror-mode/css/pyret.css \
    ++extra src/hilite.js \
    \
    ++style src/styles.css \
    --prefix src/myprefix.html \
    \
    --dest ./build/ \
    --dest-name docs \
    ++arg "$(VERSION)" \
    --htmls src/index.scrbl
