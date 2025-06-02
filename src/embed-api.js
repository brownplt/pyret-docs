import { makeEmbed } from "./pyret_2.js";
const CPO = "https://pyret-horizon.herokuapp.com/editor#controlled=true&footerStyle=hide&warnOnExit=false";

let currentId = 0;
async function embedFromPage(tryItLink, code) {
  const newlines = code.split("\n").length;
  let height = ((newlines * 2) + 6);
  height = Math.max(height, 12) + "em";
  let showing = false;
  let container = document.createElement("div");
  tryItLink.parentNode.appendChild(container);
  tryItLink.addEventListener('click', async function () {
    if(!showing) {
      showing = true;
      container.style = `height: ${height}; display: block`;
      tryItLink.innerText = "(Close)";
      const embed = await makeEmbed("editor" + (++currentId), container, CPO);
      embed.onChange((_) => {
        tryItLink.innerText = "(Close [changes will not be saved])";
      });
      embed.sendReset({
        definitionsAtLastRun: code,
        interactionsSinceLastRun: [],
        editorContents: code,
        replContents: ""
      });
    }
    else {
      showing = false;
      container.innerHTML = "";
      container.style = "display: none";
      tryItLink.innerText = "(Try it!)";
    }
  });
}

window.addEventListener('load', function() {
  const elts = document.getElementsByClassName("show-embed");
  for(let i = 0; i < elts.length; i += 1) {
    console.log("Embedding: ", elts[i], elts[i].attributes);
    embedFromPage(elts[i], elts[i].attributes.code.value);
  }
});
