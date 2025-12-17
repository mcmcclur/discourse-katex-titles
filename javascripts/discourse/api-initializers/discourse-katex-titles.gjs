import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  console.log("Info:", api, document.querySelectorAll(".fancy-title"));
  api.renderInOutlet("topic-title", 
    <template>
      <div>Fancy Title Extension</div>
    </template>
  )
  })
