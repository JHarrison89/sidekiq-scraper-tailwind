import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"


// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["container"]

  toggleSideNav() {
    if (this.containerTarget.classList.contains('hidden')) {
      this.openSideNav()
    } else {
      this.closeSideNav()
    }
  }

  openSideNav() {
    // el-transition.js shows the element by removing the hidden class
    enter(this.containerTarget);
  }

  closeSideNav() {
    // el-transition.js hides the element by addding the hidden class
    leave(this.containerTarget)
  }
}
