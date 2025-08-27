import { fs } from "./embed-api.js"

window.fs = fs;

async function setup() {
    await fs.writeFile("hello.txt", "Hello, world!");
    await fs.createDir("/data");
    await fs.writeFile("/data/words", "apple\nbanana\ncherry");
    await fs.writeFile("/data/numbers.txt", "1\n2\n3\n4\n5");
    await fs.writeFile("/data/story.txt", "A long time ago in a galaxy far, far away...");
}
setup();