document.addEventListener("turbo:load", () => {
  const video = document.getElementById('be-read-video');
  const canvas = document.getElementById('be-read-canvas');
  const photoInput = document.getElementById('be-read-photo-input');
  const captureButton = document.getElementById('be-read-capture');
  const submitButton = document.getElementById('submit-button');
  let stream = null;

  // Exit early if any element is missing (prevents errors on other pages)
  if (!video || !canvas || !captureButton || !photoInput || !submitButton) {
    console.warn("BeRead elements not found on the page.");
    return;
  }

  // Start camera stream
  navigator.mediaDevices.getUserMedia({ video: true })
    .then(mediaStream => {
      stream = mediaStream;
      video.srcObject = stream;
      video.play();
    })
    .catch(err => {
      alert("Camera access error: " + err.message);
    });

  // Show a floating notification message
  function showNotification(message) {
    const notif = document.createElement('div');
    notif.className = 'photo-notification';
    notif.textContent = message;
    document.body.appendChild(notif);

    // Fade out after 2 seconds
    setTimeout(() => {
      notif.style.opacity = '0';
      setTimeout(() => {
        notif.remove();
      }, 600);
    }, 2000);
  }

  // Capture photo from video stream
  captureButton.addEventListener('click', () => {
    if (!video.videoWidth || !video.videoHeight) {
      alert("Wait for camera to load...");
      return;
    }

    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    const ctx = canvas.getContext('2d');
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

    const dataURL = canvas.toDataURL('image/jpeg');
    photoInput.value = dataURL;

    showNotification("📸 Photo captured!");

    // Enable submit button
    submitButton.disabled = false;
    submitButton.style.opacity = "1";

    // Stop camera stream
    if (stream) {
      stream.getTracks().forEach(track => track.stop());
      stream = null;
    }

    // Hide video and disable capture button
    video.style.display = 'none';
    captureButton.disabled = true;
    captureButton.style.cursor = 'not-allowed';
  });

  // On form submit: ensure photo present and stop camera if needed
  document.querySelector('form').addEventListener('submit', (event) => {
    if (!photoInput.value) {
      event.preventDefault();
      alert("📸 Please take a photo before sending.");
      return;
    }

    if (stream) {
      stream.getTracks().forEach(track => track.stop());
      stream = null;
    }

    // Disable submit button to prevent double submissions
    submitButton.disabled = true;
    submitButton.style.opacity = "0.5";
  });
});
