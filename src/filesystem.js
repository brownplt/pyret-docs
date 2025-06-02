import { fs } from "./embed-api.js"

fs.writeFile("hello.txt", "Hello, world!");
window.fs = fs;