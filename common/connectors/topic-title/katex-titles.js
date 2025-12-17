import Component from "@glimmer/component";

export default class TopicTitleUppercase extends Component {
  get upcasedTitle() {
    return this.args.outletArgs.model.title.toUpperCase();
  }
}
