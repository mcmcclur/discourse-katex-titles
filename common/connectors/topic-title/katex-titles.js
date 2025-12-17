import Component from "@glimmer/component";

export default class TopicTitleUppercase extends Component {
  get upcasedTitle() {
    console.log('try to upcase title:', this.args.outletArgs.model.title);
    return this.args.outletArgs.model.title.toUpperCase();
  }
}
