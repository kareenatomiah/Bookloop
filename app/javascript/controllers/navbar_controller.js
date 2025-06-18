import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sideMenu", "searchBar"]

  toggleMenu() {
    this.sideMenuTarget.classList.toggle("hidden")
  }

  activateSearch() {
    if (this.hasSearchBarTarget) {
      this.searchBarTarget.scrollIntoView({ behavior: "smooth" })
      this.searchBarTarget.focus()
    } else {
      window.location.href = "/search"
    }
  }
}
