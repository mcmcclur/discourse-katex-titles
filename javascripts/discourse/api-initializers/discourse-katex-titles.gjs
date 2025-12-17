import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  api.decorateWidget("topic-title:after", (helper) => {
        const titleEl = helper.widget?.element?.querySelector(".fancy-title");
        if (titleEl) {
          titleEl.textContent = titleEl.textContent.toUpperCase();
        }
      })
});
