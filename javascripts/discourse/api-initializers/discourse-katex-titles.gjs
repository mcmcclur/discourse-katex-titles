import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  console.log("Current user is", api.getCurrentUser());
api.onPageChange(() => {
    const tryTypeset = () => {
      document.querySelectorAll(".fancy-title").forEach(el => console.log(el))
      }
    }
  )})
