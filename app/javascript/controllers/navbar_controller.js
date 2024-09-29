import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"


// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["sidenav", "dropdown"]

  toggleSideNav() {
    if (this.sidenavTarget.classList.contains('hidden')) {
      this.openSideNav()
    } else {
      this.closeSideNav()
    }
  }

  openSideNav() {
    // el-transition.js shows the element by removing the hidden class
    enter(this.sidenavTarget);
  }

  closeSideNav() {
    // el-transition.js hides the element by addding the hidden class
    leave(this.sidenavTarget)
  }


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
