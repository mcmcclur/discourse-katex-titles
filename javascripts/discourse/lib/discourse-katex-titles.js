let katexLoadPromise;

export function loadKatex() {
  if (window.renderMathInElement) {
    return Promise.resolve();
  }

  if (katexLoadPromise) {
    return katexLoadPromise;
  }

  katexLoadPromise = new Promise((resolve, reject) => {
    const css = document.createElement("link");
    css.rel = "stylesheet";
    css.href = "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css";
    document.head.appendChild(css);

    const katexScript = document.createElement("script");
    katexScript.src =
      "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js";
    katexScript.defer = true;

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
  }).catch((error) => {
    katexLoadPromise = undefined;
    throw error;
  });

  return katexLoadPromise;
}

export function renderKatexInElement(element, sourceKey) {
  if (!element || !sourceKey) {
    return;
  }

  if (element.dataset.katexSourceKey === sourceKey) {
    return;
  }

  loadKatex()
    .then(() => {
      if (!window.renderMathInElement) {
        return;
      }

      window.renderMathInElement(element, {
        delimiters: [
          { left: "$", right: "$", display: false },
          { left: "\\(", right: "\\)", display: false },
        ],
        throwOnError: false,
      });

      element.dataset.katexSourceKey = sourceKey;
    })
    .catch(() => {
      // Keep the original title visible if KaTeX fails to load or render.
    });
}
