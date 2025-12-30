import { apiInitializer } from "discourse/lib/api";
// import * as katex from "katex";
// import "katex/dist/katex.min.css";
// console.log("katex loaded:", katex);

export default apiInitializer((api) => {
  loadKatex().then(katex => {
    console.log("katex loaded from CDN:", katex);
  }).catch(error => {
    console.error("Failed to load KaTeX from CDN:", error);
  });
  api.onAppEvent("page:changed", () => {
    const fancyTitle = document.querySelector('a.fancy-title');
    if (fancyTitle) {
      fancyTitle.style.color = "red";
    }
    const frontTitles = document.querySelectorAll('a.title');
    for (const el of frontTitles) {
      el.style.color = "red";
    }
  });
  api.onAppEvent("topic:scrolled", () => {
    const topicLinkSpan = document.querySelector('a.topic-link span');
    if (topicLinkSpan) {
      topicLinkSpan.style.color = "red";
    }
  });
  document.addEventListener("animationstart", event => {
    console.log("topic loaded");
    document.querySelectorAll('.topic-list-item .title').forEach(
      node => {
        node.style.color = "red";
      });
  });
});

function loadKatex() {
  if (window.renderMathInElement) {
    return Promise.resolve();
  }

  return new Promise((resolve, reject) => {
    // CSS
    const css = document.createElement("link");
    css.rel = "stylesheet";
    css.href =
      "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css";
    document.head.appendChild(css);

    // Core KaTeX
    const katexScript = document.createElement("script");
    katexScript.src =
      "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js";
    katexScript.defer = true;

    // Auto-render
    const autoRenderScript = document.createElement("script");
    autoRenderScript.src =
      "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js";
    autoRenderScript.defer = true;

    katexScript.onload = () => {
      autoRenderScript.onload = resolve;
      autoRenderScript.onerror = reject;
      document.head.appendChild(autoRenderScript);
    };

    katexScript.onerror = reject;
    document.head.appendChild(katexScript);
  });
}

