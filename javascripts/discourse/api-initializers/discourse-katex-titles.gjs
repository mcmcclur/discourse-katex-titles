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
  });
  api.onAppEvent("header:show-topic", () => {
    const topicLinkSpan = document.querySelector('a.topic-link span');
    console.log("Topic link span:", topicLinkSpan);
    if (topicLinkSpan) {
      topicLinkSpan.style.color = "red";
    }
  });
})


