import { apiInitializer } from "discourse/lib/api";

export default apiInitializer(api => {
  api.onPageChange(() => {
    const tryTypeset = () => {
      document.querySelectorAll(".fancy-title").forEach(el => {
        console.log('try to typeset title');
        renderMathInElement(el, {
          delimiters: [
            { left: "$", right: "$", display: false },
            { left: "\\(", right: "\\)", display: false }
          ],
          throwOnError: false
        });
      });
    };

    // Try immediately (may work after full navigation, or if titles update synchronously)
    tryTypeset();

    // Use MutationObserver to catch delayed element insertion
    const observer = new MutationObserver(mutations => {
      mutations.forEach(() => {
        tryTypeset();
      });
    });
    const header = document.querySelector("header") || document.body;
    observer.observe(header, { childList: true, subtree: true });

    // Optionally disconnect after a short delay to avoid running forever
    setTimeout(() => observer.disconnect(), 5000);
  });
});

function renderMathInElement(element, options) {
  // Placeholder for the actual KaTeX rendering function
  // In a real implementation, this would call KaTeX's render functions
  console.log("Rendering math in element:", element, "with options:", options);

  retrun null;
}