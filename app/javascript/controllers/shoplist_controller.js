import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  generate(event) {
    event.preventDefault();
    event.stopPropagation();

    const recipeId = event.params["recipeid"];
    const selectElem = document.getElementById(event.params["select"]);
    const inventoryId = selectElem.value;

    location.replace(`/shopping_list?recipe_id=${recipeId}&inventory_id=${inventoryId}`);
  }
}
