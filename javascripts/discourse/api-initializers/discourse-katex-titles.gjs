import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  console.log("Info:", api, document.querySelectorAll(".fancy-title"));
  api.renderInOutlet("topic-title", 
    <template>
      <div>Fancy Title Extension</div>
    </template>
  );
  api.onPageChange(() => {
    // Your code to modify the topic title here
    const fancyTitle = document.querySelector('a.fancy-title');
    if (fancyTitle) {
      // Manipulate the element as needed
      fancyTitle.style.color = "red";
      // ...other code
    }
  });
})




