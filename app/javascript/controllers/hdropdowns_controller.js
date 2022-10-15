import { Controller } from "@hotwired/stimulus"

const HIDDEN_CLASS = 'u-is-hidden';
const DROPDOWN_CLASS = 'c-hdropdown';

export default class extends Controller {
  toggleDropdown(event) {
    event.preventDefault();
    event.stopPropagation();

    const dropdownId = event.params["id"];

    const headerDropdowns = document.querySelectorAll(`.${DROPDOWN_CLASS}`);

    headerDropdowns.forEach((dropdown) => {
      if (dropdown.id === dropdownId) {
        dropdown.classList.toggle(HIDDEN_CLASS);
      } else {
        dropdown.classList.add(HIDDEN_CLASS);
      }
    });
  }
}
