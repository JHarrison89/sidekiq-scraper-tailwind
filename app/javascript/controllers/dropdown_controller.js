import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["dropdown"]

  toggleDropDown() {
    if (this.dropdownTarget.classList.contains('hidden')) {
      this.openDropDown()
    } else {
      this.closeDropDown()
    }
  }

  openDropDown() {
    this.dropdownTarget.classList.remove('hidden');
  }

  closeDropDown() {
    this.dropdownTarget.classList.add('hidden');
  }
}
