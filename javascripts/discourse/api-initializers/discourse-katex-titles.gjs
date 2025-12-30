import { apiInitializer } from "discourse/lib/api";
// import * as katex from "katex";
// import "katex/dist/katex.min.css";
// console.log("katex loaded:", katex);

export default apiInitializer((api) => {
  loadKatexFromCDN().then(katex => {
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
})



function loadKatexFromCDN() {
  if (window.katex) {
    return Promise.resolve(window.katex);
  }

  return new Promise((resolve, reject) => {
    // CSS
    const link = document.createElement("link");
    link.rel = "stylesheet";
    link.href =
      "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css";
    document.head.appendChild(link);

    // JS
    const script = document.createElement("script");
    script.src =
      "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js";
    script.defer = true;

    script.onload = () => resolve(window.katex);
    script.onerror = reject;

    document.head.appendChild(script);
  });
}
