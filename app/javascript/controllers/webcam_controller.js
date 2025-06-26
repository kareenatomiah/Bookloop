import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "video",
    "canvas",
    "preview",
    "photoInput",
    "captureButton",
    "submitButton",
    "notification"
  ]

  connect() {
    console.log("be-real-camera controller connected")
    this.startCamera()
  }

  disconnect() {
    console.log("be-real-camera controller disconnected")
    this.stopCamera()
  }

  async startCamera() {
    try {
      console.log("Attempting to start camera...")

      if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        alert("Your browser does not support camera access.")
        console.error("MediaDevices or getUserMedia not supported.")
        return
      }

      this.stream = await navigator.mediaDevices.getUserMedia({ video: true })
      console.log("Camera stream obtained:", this.stream)

      this.videoTarget.srcObject = this.stream
      this.videoTarget.style.display = "block"
      this.previewTarget.style.display = "none"

      // Enable capture button once stream is live
      this.captureButtonTarget.disabled = false
      this.captureButtonTarget.style.cursor = "pointer"
      // Initially disable submit until photo is captured
      this.submitButtonTarget.disabled = true
      this.submitButtonTarget.style.opacity = "0.6"
    } catch (error) {
      alert("🚫 Unable to access camera: " + error.message)
      console.error("getUserMedia error:", error)
    }
  }

  stopCamera() {
    if (this.stream) {
      this.stream.getTracks().forEach(track => track.stop())
      this.stream = null
      console.log("Camera stopped")
    }
  }

  capture() {
    if (!this.videoTarget.videoWidth || !this.videoTarget.videoHeight) {
      alert("Camera not ready yet.")
      return
    }

    const canvas = this.canvasTarget
    canvas.width = this.videoTarget.videoWidth
    canvas.height = this.videoTarget.videoHeight

    const ctx = canvas.getContext("2d")
    ctx.drawImage(this.videoTarget, 0, 0)

    const dataURL = canvas.toDataURL("image/jpeg")

    this.photoInputTarget.value = dataURL
    this.previewTarget.src = dataURL
    this.previewTarget.style.display = "block"

    this.showNotification("📸 Photo captured!")

    this.submitButtonTarget.disabled = false
    this.submitButtonTarget.style.opacity = "1"

    this.captureButtonTarget.disabled = true
    this.captureButtonTarget.style.cursor = "not-allowed"

    this.videoTarget.style.display = "none"
    this.stopCamera()
  }

  showNotification(message) {
    this.notificationTarget.textContent = message
    this.notificationTarget.style.display = "block"
    this.notificationTarget.style.opacity = "1"

    setTimeout(() => {
      this.notificationTarget.style.opacity = "0"
      setTimeout(() => {
        this.notificationTarget.style.display = "none"
      }, 600)
    }, 1800)
  }
}
