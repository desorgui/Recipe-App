import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  generate(event) {
    event.preventDefault();
    event.stopPropagation();

    const recipeId = event.params["recipeid"];
    const selectElem = document.getElementById(event.params["select"]);
    const inventoryId = selectElem.value;

    get(`/shopping_list?recipe_id=${recipeId}&inventory_id=${inventoryId}`);
  }
}
