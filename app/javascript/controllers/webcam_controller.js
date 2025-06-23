import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const video = document.getElementById("be-read-video")
    const canvas = document.getElementById("be-read-canvas")
    const input = document.getElementById("be-read-photo-input")
    const button = document.getElementById("be-read-capture")

    if (!video || !canvas || !input || !button) return

    navigator.mediaDevices.getUserMedia({ video: true })
      .then((stream) => {
        video.srcObject = stream

        const form = document.querySelector("form")
        form.addEventListener("submit", () => {
          stream.getTracks().forEach(track => track.stop())
        })

        button.addEventListener("click", () => {
          canvas.width = video.videoWidth
          canvas.height = video.videoHeight
          canvas.getContext("2d").drawImage(video, 0, 0)
          const dataUrl = canvas.toDataURL("image/jpeg")
          input.value = dataUrl
          alert("✅ Photo prise ! Tu peux maintenant envoyer.")
        })
      })
      .catch((err) => {
        alert("🚫 Erreur caméra : " + err.message)
      })
  }
}
