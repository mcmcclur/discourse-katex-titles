import { apiInitializer } from "discourse/lib/api";
import * as katex from "katex";
import "katex/dist/katex.min.css";

console.log("katex loaded:", katex);

export default apiInitializer((api) => {
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

