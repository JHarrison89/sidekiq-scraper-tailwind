import { Controller } from "@hotwired/stimulus"
import {  enter, leave } from "el-transition"

// Connects to data-controller="flash-notification"
export default class extends Controller {
  static targets = ["notification"]

  connect() {
    enter(this.notificationTarget);

    // Set a 3-second timeout before proceeding
    setTimeout(() => {
      this.fadeOut();
    }, 3000);
  }

  fadeOut() {
    leave(this.notificationTarget);
  }

  closeNotification() {
    this.notificationTarget.classList.add('hidden');
  }
}
