import Component from "@glimmer/component";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import didUpdate from "@ember/render-modifiers/modifiers/did-update";
import { renderKatexInElement } from "../../lib/discourse-katex-titles";

export default class DiscourseKatexTitlesHeaderTitle extends Component {
  renderTitle = (element) => {
    const headerTitle = element.closest(".header-title");

    headerTitle?.classList.toggle(
      "discourse-katex-titles-has-header-title",
      Boolean(this.sourceKey)
    );

    renderKatexInElement(element, this.sourceKey);
  };

  get topic() {
    return (
      this.args.outletArgs?.topic ||
      this.args.outletArgs?.model ||
      this.args.outletArgs?.topicView?.topic
    );
  }

  get sourceKey() {
    return this.topic?.title || "";
  }

  get topicTitle() {
    return this.topic?.title || "";
  }

  <template>
    <span
      class="discourse-katex-titles-header-title"
      {{didInsert this.renderTitle}}
      {{didUpdate this.renderTitle this.sourceKey}}
    >
      {{this.topicTitle}}
    </span>
  </template>
}
