import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rating"]

  connect() {
    const elements = document.querySelectorAll("[id^='rating-']")

    elements.forEach(el => {
      const workKey = el.id.replace("rating-", "")
      fetch(`/api/ratings/${workKey}`)
        .then(response => response.json())
        .then(data => {
          if (data.average) {
            el.innerText = `★ ${data.average.toFixed(1)} (${data.count} ratings)`
            el.style.color = "#f39c12"
          } else {
            el.innerText = "No rating yet"
            el.style.color = "#999"
          }
        })
    })
  }
}
