import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="notification"
export default class extends Controller {
  static targets = ["flash"];
  static values = {
    timeout: { type: Number, default: 3000 },
    type: String,
  };

  connect() {
    setTimeout(() => {
      this.close();
    }, this.timeoutValue);
  }

  close() {
    this.element.classList.add(
      "opacity-100",
      "transition-opacity",
      "ease-out",
      "duration-500"
    );
    this.element.classList.replace("opacity-100", "opacity-0");
    setTimeout(() => {
      this.element.remove();
    }, 500);
  }

  disconnect() {
    this.element.remove();
  }
}
