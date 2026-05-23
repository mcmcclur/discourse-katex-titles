import Component from "@glimmer/component";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import didUpdate from "@ember/render-modifiers/modifiers/did-update";
import { renderKatexInElement } from "../../lib/discourse-katex-titles";

export default class DiscourseKatexTitlesTopicLink extends Component {
  renderTitle = (element) => {
    renderKatexInElement(element, this.sourceKey);
  };

  get sourceKey() {
    const topic = this.args.outletArgs?.topic;

    return topic?.fancy_title || topic?.title || "";
  }

  <template>
    <span
      class="discourse-katex-titles-topic-link-wrapper"
      {{didInsert this.renderTitle}}
      {{didUpdate this.renderTitle this.sourceKey}}
    >
      {{yield}}
    </span>
  </template>
}
