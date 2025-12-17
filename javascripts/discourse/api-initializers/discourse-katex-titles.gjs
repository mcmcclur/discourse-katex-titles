import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  console.log("Info:", api, document.querySelectorAll(".fancy-title"));
  api.renderInOutlet("topic-title", 
    <template>
      <div>Fancy Title Extension</div>
    </template>
  );
  api.onPageChange(() => {
    const fancyTitle = document.querySelector('a.fancy-title');
    if (fancyTitle) {
      fancyTitle.style.color = "red";
    }
    const topicLink = document.querySelector('a.topic-link span');
    if (topicLink) {
      fancyTitle.style.color = "red";
    }
  });
  api.registrations['app-events:main'].onAppEvent("header:show-topic", () => {
    // Run your code here every time the header topic title appears!
    const headerTopicLink = document.querySelector(".title-wrapper a.topic-link span");
    console.log("Header topic link:", headerTopicLink);
    if (headerTopicLink) {
      // Customize header topic link as you want
      headerTopicLink.style.color = "red";
    }
  });
})


        // application.registrations['app-events:main']
        //     .on('header:show-topic', function(e){ 
        //         $('#top-navbar').css('zIndex',0) 
        //     })
        //     .on('header:hide-topic', function(e){ 
        //         $('#top-navbar').css('zIndex',1001) 
        //     })



