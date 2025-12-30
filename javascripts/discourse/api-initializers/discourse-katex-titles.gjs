import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  // console.log("Info:", api, document.querySelectorAll(".fancy-title"));
  // api.renderInOutlet("topic-title", 
  //   <template>
  //     <div>Fancy Title Extension</div>
  //   </template>
  // );
  // api.onPageChange(() => {
  //   const fancyTitle = document.querySelector('a.fancy-title');
  //   if (fancyTitle) {
  //     fancyTitle.style.color = "red";
  //   }
  //   )
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
})


