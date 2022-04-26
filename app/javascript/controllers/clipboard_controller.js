import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["source", "button", "tooltip"];

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value);
    this.buttonTarget.classList.add("text-accent");
    this.tooltipTarget.classList.add(
      "tooltip",
      "tooltip-open",
      "tooltip-accent"
    );

    setTimeout(() => {
      this.buttonTarget.classList.remove("text-accent");
      this.tooltipTarget.classList.remove(
        "tooltip",
        "tooltip-open",
        "tooltip-accent"
      );
    }, 1500);
  }
}
