import Component from "@glimmer/component";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import didUpdate from "@ember/render-modifiers/modifiers/did-update";
import { renderKatexInElement } from "../../lib/discourse-katex-titles";

export default class DiscourseKatexTitlesLatestTopicListTitle extends Component {
  renderTitle = (element) => {
    renderKatexInElement(element, this.sourceKey);
  };

  get topic() {
    return this.args.outletArgs?.topic;
  }

  get sourceKey() {
    return this.topic?.title || "";
  }

  get topicTitle() {
    return this.topic?.title || "";
  }

  get topicUrl() {
    return this.topic?.lastUnreadUrl || this.topic?.url || "#";
  }

  <template>
    <a
      href={{this.topicUrl}}
      data-topic-id={{this.topic.id}}
      class="title discourse-katex-titles-latest-topic-list-title"
      {{didInsert this.renderTitle}}
      {{didUpdate this.renderTitle this.sourceKey}}
    >
      {{this.topicTitle}}
    </a>
  </template>
}
