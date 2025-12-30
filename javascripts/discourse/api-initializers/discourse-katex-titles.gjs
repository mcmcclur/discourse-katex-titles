import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  api.onAppEvent("page:changed", () => {
    const fancyTitle = document.querySelector('a.fancy-title');
    if (fancyTitle) {
      fancyTitle.style.color = "red";
    }
    const frontTitles = document.querySelectorAll('a.title');
    for (const el of frontTitles) {
      el.style.color = "red";
    }
  });
  api.onAppEvent("topic:scrolled", () => {
    console.log("Topic scrolled event detected");
    const topicLinkSpan = document.querySelector('a.topic-link span');
    if (topicLinkSpan) {
      topicLinkSpan.style.color = "red";
    }
  });
  api.modifyClass('component:topic-list', {
    myObserver: Ember.observer('topics.[]', function () {
      Ember.run.scheduleOnce('afterRender', () => {
        document.querySelectorAll('.topic-list-item .title')
          .forEach(node => {
            node.style.color = "red";
          });
      });
    })
  });
})


