import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"]

  open() {
    this.sidebarTarget.classList.add("open")
  }

  close() {
    this.sidebarTarget.classList.remove("open")
  }
}
