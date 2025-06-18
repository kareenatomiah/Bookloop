import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"]

  connect() {
    document.getElementById("menu-toggle").addEventListener("click", () => {
      document.getElementById("sidebar").classList.add("open")
    })

    document.getElementById("close-sidebar").addEventListener("click", () => {
      document.getElementById("sidebar").classList.remove("open")
    })
  }
}
