import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  api.modifyClass(
    "component:discourse-topic",
    (Superclass) =>
      class extends Superclass {
        get title() {
          return this.model?.title || super.title;
        }

        get fancyTitle() {
          return this.model?.title || super.fancyTitle;
        }

        get topicTitle() {
          return this.model?.title || super.topicTitle;
        }

        get titleText() {
          return this.model?.title || super.titleText;
        }
      }
  );
});
