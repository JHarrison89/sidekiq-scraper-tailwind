import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdown"]

  connect() {
    // Add click event listener to the document when controller connects
    this.boundHandleOutsideClick = this.handleOutsideClick.bind(this)
    document.addEventListener('click', this.boundHandleOutsideClick)
  }

  disconnect() {
    // Remove the event listener when the controller disconnects
    document.removeEventListener('click', this.boundHandleOutsideClick)
  }

  toggleDropDown(event) {
    event.stopPropagation() // Prevent the click from immediately closing the dropdown

    if (this.dropdownTarget.classList.contains('hidden')) {
      this.openDropDown()
    } else {
      this.closeDropDown()
    }
  }

  openDropDown() {
    this.dropdownTarget.classList.remove('hidden')
  }

  closeDropDown() {
    this.dropdownTarget.classList.add('hidden')
  }

  handleOutsideClick(event) {
    // If the dropdown is visible and the click is outside both the dropdown and
    // whatever element is toggling the dropdown
    if (!this.dropdownTarget.classList.contains('hidden') &&
        !this.dropdownTarget.contains(event.target) &&
        !event.target.closest(`[data-action*="${this.identifier}#toggleDropDown"]`)) {
      this.closeDropDown()
    }
  }
}
