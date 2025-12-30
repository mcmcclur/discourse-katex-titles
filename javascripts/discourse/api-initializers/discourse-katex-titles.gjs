import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  loadKatex()
    .then(() => {
      api.onAppEvent("page:changed", () => {
        renderKatex("a.fancy-title");
        renderKatex("a.title");
      });
      api.onPageChange(() => {
        renderKatex("a.fancy-title");
        renderKatex("a.title");
      });
      api.onAppEvent("topic:scrolled", () => {
        renderKatex("a.topic-link span");
      });

      // Best I could figure to catch topic list title changes.
      // There should be an api event for this.
      document.addEventListener("onload", () => {
        renderKatex("a.fancy-title");
        renderKatex("a.title");
      })
      document.addEventListener("animationstart", () => {
        renderKatex(".topic-list-item .title");
      });
    })
    .catch(() => {
      "pass";
    });
});

function loadKatex() {
  if (window.renderMathInElement) {
    return Promise.resolve();
  }

  return new Promise((resolve, reject) => {
    const css = document.createElement("link");
    css.rel = "stylesheet";
    css.href = "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css";
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

function renderKatex(elementMatch) {
  if (!window.renderMathInElement) {
    return;
  }

  document.querySelectorAll(elementMatch).forEach((el) => {
    if (el.dataset.katexRendered) {
      return;
    }

    window.renderMathInElement(el, {
      delimiters: [
        { left: "$", right: "$", display: false },
        { left: "\\(", right: "\\)", display: false },
      ],
      throwOnError: false,
    });

    el.dataset.katexRendered = "true";
  });
}
