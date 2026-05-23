import Component from "@glimmer/component";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import didUpdate from "@ember/render-modifiers/modifiers/did-update";
import { renderKatexInElement } from "../../lib/discourse-katex-titles";

export default class DiscourseKatexTitlesHeaderTitle extends Component {
  renderTitle = (element) => {
    const titleWrapper = element.closest(".title-wrapper");

    titleWrapper?.classList.toggle(
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

  get topicUrl() {
    return this.topic?.url || "#";
  }

  <template>
    <span
      class="discourse-katex-titles-header-title"
      {{didInsert this.renderTitle}}
      {{didUpdate this.renderTitle this.sourceKey}}
    >
      <a href={{this.topicUrl}} class="topic-link">
        {{this.topicTitle}}
      </a>
    </span>
  </template>
}
