import Component from "@glimmer/component";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import didUpdate from "@ember/render-modifiers/modifiers/did-update";
import { renderMathInElement } from "../../lib/discourse-katex-titles";

export default class DiscourseKatexTitlesTopicTitle extends Component {
  renderTitle = (element) => {
    renderMathInElement(element, this.sourceKey);
  };

  get topic() {
    return this.args.outletArgs?.model;
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
    <h1 class="discourse-katex-titles-topic-page-title">
      <a href={{this.topicUrl}} class="fancy-title">
        <span
          class="discourse-katex-titles-math"
          {{didInsert this.renderTitle}}
          {{didUpdate this.renderTitle this.sourceKey}}
        >
          {{this.topicTitle}}
        </span>
      </a>
    </h1>
  </template>
}
