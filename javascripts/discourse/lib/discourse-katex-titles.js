const KATEX_VERSION = "0.16";
const MATHJAX_VERSION = "4.1.2";

let katexLoadPromise;
let mathJaxLoadPromise;
let mathJaxTypesetQueue = Promise.resolve();

function getRenderer() {
  if (typeof settings === "undefined" || !settings.renderer) {
    return "katex";
  }

  return settings.renderer;
}

function markRendered(element, renderer, sourceKey) {
  element.dataset.mathRenderer = renderer;
  element.dataset.mathSourceKey = sourceKey;
}

function wasRendered(element, renderer, sourceKey) {
  return (
    element.dataset.mathRenderer === renderer &&
    element.dataset.mathSourceKey === sourceKey
  );
}

function getDelimiters() {
  return [
    { left: "$", right: "$", display: false },
    { left: "\\(", right: "\\)", display: false },
  ];
}

function loadScript(src) {
  return new Promise((resolve, reject) => {
    const script = document.createElement("script");
    script.src = src;
    script.defer = true;
    script.onload = resolve;
    script.onerror = reject;
    document.head.appendChild(script);
  });
}

function loadStylesheet(href) {
  if (document.querySelector(`link[href="${href}"]`)) {
    return;
  }

  const css = document.createElement("link");
  css.rel = "stylesheet";
  css.href = href;
  document.head.appendChild(css);
}

function loadKatex() {
  if (window.renderMathInElement) {
    return Promise.resolve();
  }

  if (katexLoadPromise) {
    return katexLoadPromise;
  }

  loadStylesheet(
    `https://cdn.jsdelivr.net/npm/katex@${KATEX_VERSION}/dist/katex.min.css`
  );

  katexLoadPromise = loadScript(
    `https://cdn.jsdelivr.net/npm/katex@${KATEX_VERSION}/dist/katex.min.js`
  )
    .then(() =>
      loadScript(
        `https://cdn.jsdelivr.net/npm/katex@${KATEX_VERSION}/dist/contrib/auto-render.min.js`
      )
    )
    .catch((error) => {
      katexLoadPromise = undefined;
      throw error;
    });

  return katexLoadPromise;
}

function loadMathJax() {
  if (window.MathJax?.typesetPromise) {
    return Promise.resolve();
  }

  if (mathJaxLoadPromise) {
    return mathJaxLoadPromise;
  }

  window.MathJax = {
    startup: {
      typeset: false,
    },
    options: {
      enableMenu: false,
      menuOptions: {
        settings: {
          enrich: false,
        },
      },
    },
    tex: {
      inlineMath: [
        ["$", "$"],
        ["\\(", "\\)"],
      ],
    },
  };

  mathJaxLoadPromise = loadScript(
    `https://cdn.jsdelivr.net/npm/mathjax@${MATHJAX_VERSION}/tex-chtml.js`
  ).catch((error) => {
    mathJaxLoadPromise = undefined;
    throw error;
  });

  return mathJaxLoadPromise;
}

function renderKatexInElement(element) {
  return loadKatex().then(() => {
    if (!window.renderMathInElement) {
      return;
    }

    window.renderMathInElement(element, {
      delimiters: getDelimiters(),
      throwOnError: false,
    });
  });
}

function renderMathJaxInElement(element) {
  return loadMathJax().then(() => {
    mathJaxTypesetQueue = mathJaxTypesetQueue.then(async () => {
      if (!window.MathJax?.typesetPromise) {
        return;
      }

      window.MathJax.typesetClear?.([element]);
      await window.MathJax.typesetPromise([element]);
    });

    return mathJaxTypesetQueue;
  });
}

export function renderMathInElement(element, sourceKey) {
  if (!element || !sourceKey) {
    return;
  }

  const renderer = getRenderer();

  if (wasRendered(element, renderer, sourceKey)) {
    return;
  }

  element.textContent = sourceKey;

  const renderPromise =
    renderer === "mathjax"
      ? renderMathJaxInElement(element)
      : renderKatexInElement(element);

  renderPromise
    .then(() => {
      markRendered(element, renderer, sourceKey);
    })
    .catch(() => {
      // Keep the original title visible if the renderer fails to load or render.
    });
}
