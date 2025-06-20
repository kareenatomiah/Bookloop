document.addEventListener("DOMContentLoaded", () => {
  const video = document.getElementById("be-read-video");
  const canvas = document.getElementById("be-read-canvas");
  const captureBtn = document.getElementById("be-read-capture");
  const photoInput = document.getElementById("be-read-photo-input");
  const captionInput = document.getElementById("be-read-text");

  if (!video || !canvas || !captureBtn) return;

  navigator.mediaDevices.getUserMedia({ video: true }).then(stream => {
    video.srcObject = stream;
  });

  captureBtn.addEventListener("click", () => {
    const context = canvas.getContext("2d");
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    context.drawImage(video, 0, 0, canvas.width, canvas.height);

    // Ajout du texte
    context.font = "30px Helvetica";
    context.fillStyle = "white";
    context.fillText(captionInput.value, 20, canvas.height - 40);

    // Transformer en blob et remplir le champ
    canvas.toBlob(blob => {
      const file = new File([blob], "beread.png", { type: "image/png" });
      const dataTransfer = new DataTransfer();
      dataTransfer.items.add(file);
      photoInput.files = dataTransfer.files;
    });
  });
});
