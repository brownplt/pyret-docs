const CPO = "https://pyret-horizon.herokuapp.com/editor#controlled=true";
//const CPO = "http://localhost:4999/editor#controlled=true";
//const CPO = "https://pyret-vmt-dfb765867402.herokuapp.com/editor#controlled=true";

function makeEmbed(id, container) {
  let messageNumber = 0;
  function sendReset(frame, state) {
    if(!state) {
      state = {
        definitionsAtLastRun: false,
        interactionsSinceLastRun: [],
        editorContents: "use context starter2024",
        replContents: ""
      };
    }
    state.messageNumber = 0;
    const payload = {
      data: {
        type: 'reset',
        state: typeof state === "string" ? state : JSON.stringify(state)
      },
      protocol: 'pyret'
    };
    console.log("Sending", payload);
    frame.contentWindow.postMessage(payload, '*');
  }

  function gainControl(frame) {
    frame.contentWindow.postMessage({
      type: 'gainControl'
    }, '*');
  }

  function setInteractions(frame, text) {
    messageNumber += 1;
    const change = {
      from: { line: 0, ch: 0 },
      to: { line: 0, ch: 0 },
      text: text
    };
    const payload = {
      protocol: 'pyret',
      data: {
        type: 'changeRepl',
        change: change
      },
      state: { replContents: text, messageNumber }
    };
    frame.contentWindow.postMessage(payload, '*');
  }

  function directPostMessage(frame, message) {
    frame.contentWindow.postMessage(message);
  }

  const frame = document.createElement("iframe");
  frame.id = id;
  frame.src = CPO;
  frame.width = "100%";
  frame.frameBorder = 0;
  frame.style = "height: 100%; border: 0;";
  container.appendChild(frame);

  const { promise, resolve, reject } = Promise.withResolvers();
  setTimeout(() => reject(new Error("Timeout waiting for Pyret to load")), 60000);

  window.addEventListener('message', message => {
    if(message.data.protocol !== 'pyret') {
      return;
    }
    if(message.source !== frame.contentWindow) {
      return;
    }
    const pyretMessage = message.data;
    if(pyretMessage.data.type === 'pyret-init') {
      console.log("Sending gainControl", pyretMessage);
      gainControl(frame);
      resolve(makeEmbedAPI(frame));
    }
    else {
      messageNumber = pyretMessage.state.messageNumber;
    }
  });
  function makeEmbedAPI(frame) {
    return {
      sendReset: (state) => sendReset(frame, state),
      postMessage: (message) => directPostMessage(frame, message),
      getFrame: () => frame,
      setInteractions: (text) => setInteractions(frame, text)
    }
  }
  return promise;
}

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
      const embed = await makeEmbed("editor" + (++currentId), container);
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
