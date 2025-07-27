// Routing
function redirectToRecording() {
    window.location.href = "/recording";
}

function redirectToFormSubmitted() {
    console.log("Redirecting to /form-submitted");
    window.location.href = "/form-submitted";
}

// Global variables for video recording
let mediaRecorder;
let recordedChunks = [];
let blob = null; // Video file to be uploaded after approval
let videoUrl = ""; // URL of the uploaded video to be sent with the ticket

// Wait for the DOM to load
document.addEventListener("DOMContentLoaded", () => {
    const videoElement = document.getElementById("main_video");
    const recordButton = document.getElementById("recordButton");
    const newRecordButton = document.getElementById("newRecordButton");
    const approveButton = document.getElementById("approveButton");
    const editButton = document.getElementById("editButton");
    const sendButton = document.getElementById("sendButton");
    const additionalFields = document.getElementById("additional-fields");

    if (!videoElement || !recordButton || !newRecordButton || !approveButton || !editButton || !sendButton) {
        console.error("Missing required elements for recording page");
        return;
    }

    setupMediaRecorder(videoElement);

    // Record button logic
    recordButton.addEventListener("click", () => {
        if (!mediaRecorder) {
            console.error("MediaRecorder is not initialized.");
            alert("MediaRecorder is not ready. Please check camera or microphone settings.");
            return;
        }

        if (mediaRecorder.state === "inactive") {
            recordedChunks = []; // Reset recorded chunks
            mediaRecorder.start(1000);
            recordButton.textContent = "Stop";
            recordButton.classList.add("recording");

            // Hide other buttons
            newRecordButton.style.display = "none";
            approveButton.style.display = "none";
            editButton.style.display = "none";
        } else {
            mediaRecorder.stop();
            recordButton.textContent = "Record";
            recordButton.classList.remove("recording");
        }
    });

    // Reverse button logic (reset video and buttons)
    newRecordButton.addEventListener("click", () => {
        // Reset video element
        if (videoElement.src) {
            URL.revokeObjectURL(videoElement.src);
        }
        videoElement.src = "";
        videoElement.controls = false;

        // Reset buttons and states
        recordButton.style.display = "inline-block";
        recordButton.textContent = "Rekord";
        newRecordButton.style.display = "none";
        approveButton.style.display = "none";
        editButton.style.display = "none";
        sendButton.style.display = "none";

        // Hide additional fields
        if (additionalFields) {
            additionalFields.style.display = "none";
        }

        // Reinitialize MediaRecorder
        setupMediaRecorder(videoElement);
    });

    // Approve button logic
    approveButton.addEventListener("click", async () => {
        if (!blob) {
            alert("No video to approve. Please record a video first.");
            return;
        }

        // Upload video in chunks
        const uploadResponse = await uploadChunks(blob);

        if (uploadResponse && uploadResponse.videoUrl) {
            videoUrl = uploadResponse.videoUrl; // Save video URL
            alert(`Video uploaded successfully! Your video URL: ${videoUrl}`);

            // Show additional fields
            if (additionalFields) {
                additionalFields.style.display = "block";
            }

            // Hide unnecessary buttons
            approveButton.style.display = "none";
            newRecordButton.style.display = "none";
            editButton.style.display = "none";
            sendButton.style.display = "inline-block";
        } else {
            alert("Failed to upload video. Please try again.");
        }
    });

    // Submit button logic
    sendButton.addEventListener("click", async () => {
        if (!videoUrl) {
            alert("Kein Video hochgeladen. Bitte ein Video aufzeichnen und genehmigen.");
            console.log("Video URL before sending:", videoUrl);
            return;
        }

        const comment = document.getElementById("comment").value;
        const email = document.getElementById("email").value;

        if (!comment || !email) {
            alert("Bitte füllen Sie alle Felder aus (Kommentar und E-Mail).");
            return;
        }

        try {
            const response = await fetch("/create-ticket", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    comment: comment,
                    video: videoUrl, // Pass the video URL
                    email: email,
                }),
            });

            const result = await response.json();
            if (result.success) {
                alert("Ticket erfolgreich erstellt!");
                redirectToFormSubmitted();
            } else {
                alert("Fehler beim Erstellen des Tickets: " + result.message);
            }
        } catch (error) {
            console.error("Fehler:", error);
            alert("Beim Erstellen des Tickets ist ein Fehler aufgetreten.");
        }
    });
});

// Setup the MediaRecorder
function setupMediaRecorder(videoElement) {
    navigator.mediaDevices.getUserMedia({ video: true, audio: true })
        .then((stream) => {
            videoElement.srcObject = stream;
            mediaRecorder = new MediaRecorder(stream, { mimeType: "video/webm; codecs=vp8" });

            // Store video data chunks
            mediaRecorder.ondataavailable = (event) => {
                if (event.data.size > 0) {
                    recordedChunks.push(event.data);
                }
            };

            // Handle recording completion
            mediaRecorder.onstop = () => {
                blob = new Blob(recordedChunks, { type: "video/webm" });
                const url = URL.createObjectURL(blob);
                videoElement.srcObject = null;
                videoElement.src = url;
                videoElement.controls = true;

                // Show buttons for approval and new recording
                recordButton.style.display = "none";
                newRecordButton.style.display = "inline-block";
                approveButton.style.display = "inline-block";
                editButton.style.display = "inline-block";
            };
        })
        .catch((error) => {
            console.error("Error accessing camera or microphone:", error);
            alert("Failed to access camera or microphone. Please check your device settings.");
        });
}

// Upload video in 1MB chunks
async function uploadChunks(blob) {
    const CHUNK_SIZE = 1 * 1024 * 1024; // 1 MB
    const totalChunks = Math.ceil(blob.size / CHUNK_SIZE);
    let currentChunk = 0;

    const sendChunk = async () => {
        const start = currentChunk * CHUNK_SIZE;
        const end = Math.min(blob.size, start + CHUNK_SIZE);
        const chunk = blob.slice(start, end);

        const formData = new FormData();
        formData.append("chunk", chunk, "video.webm");
        formData.append("chunkIndex", currentChunk);
        formData.append("totalChunks", totalChunks);

        const response = await fetch("/upload", {
            method: "POST",
            body: formData,
        });

        const data = await response.json();
        currentChunk++;
        if (currentChunk < totalChunks) {
            return sendChunk();
        } else {
            return { videoUrl: data.video };
        }
    };

    return sendChunk();
}
//актуальная версия
// Routing
function redirectToRecording() {
  const serialNumber = new URLSearchParams(window.location.search).get("serialNumber");
  window.location.href = `/recording?serialNumber=${serialNumber}`;
}

function redirectToFormSubmitted() {
  console.log("Redirecting to /form-submitted");
  window.location.href = "/form-submitted";
}

// Global variables for video recording
let mediaRecorder;
let recordedChunks = [];
let blob = null; // Video file to be uploaded after approval
let videoUrl = ""; // URL of the uploaded video to be sent with the ticket
let supportedMimeType = null; // MIME type that is supported by the browser

const isAndroid = navigator.userAgent.toLowerCase().includes("android");
if (isAndroid) {
  document.body.classList.add("android");
}

// Wait for the DOM to load
document.addEventListener("DOMContentLoaded", () => {
  const videoElement = document.getElementById("main_video");
  const recordButton = document.getElementById("recordButton");
  const newRecordButton = document.getElementById("newRecordButton");
  const approveButton = document.getElementById("approveButton");
  const sendButton = document.getElementById("sendButton");
  const additionalFields = document.getElementById("additional-fields");


  if (
    !videoElement ||
    !recordButton ||
    !newRecordButton ||
    !approveButton ||
    !sendButton
  ) {
    console.error("Missing required elements for the recording page");
    return;
  }

  // Check supported MIME types
  console.log("Checking supported MIME types...");
  ["video/webm", "video/mp4", "video/quicktime"].forEach((type) => {
    console.log(`${type}: ${MediaRecorder.isTypeSupported(type)}`);
    if (!supportedMimeType && MediaRecorder.isTypeSupported(type)) {
      supportedMimeType = type; // Save the first supported MIME type
    }
  });

  if (!supportedMimeType) {
    alert("Your browser does not support video recording.");
    return;
  }

  console.log(`Using MIME type: ${supportedMimeType}`);
  setupMediaRecorder(videoElement, supportedMimeType);

  // Record button logic
  recordButton.addEventListener("click", () => {
    if (!mediaRecorder) {
      console.error("MediaRecorder is not initialized.");
      alert(
        "MediaRecorder is not ready. Please check camera or microphone settings."
      );
      return;
    }

    if (mediaRecorder.state === "inactive") {
      recordedChunks = []; // Reset recorded chunks
      mediaRecorder.start(1000);
      recordButton.textContent = "Stop";
      recordButton.classList.add("recording");

      // Hide other buttons while recording
      newRecordButton.style.display = "none";
      approveButton.style.display = "none";
    } else {
      mediaRecorder.stop();
      recordButton.textContent = "Record";
      recordButton.classList.remove("recording");
    }
  });

  // Logic to reset video and buttons
  newRecordButton.addEventListener("click", () => {
    // Reset video element
    if (videoElement.src) {
      URL.revokeObjectURL(videoElement.src);
    }
    videoElement.src = "";
    videoElement.controls = false;

    // Reset buttons and states
    recordButton.style.display = "inline-block";
    recordButton.textContent = "Record";
    newRecordButton.style.display = "none";
    approveButton.style.display = "none";
    sendButton.style.display = "none";

    // Hide additional fields
    if (additionalFields) {
      additionalFields.style.display = "none";
    }

    // Reinitialize MediaRecorder
    setupMediaRecorder(videoElement, supportedMimeType);
  });

  // Approve button logic
  approveButton.addEventListener("click", async () => {
    if (!blob) {
      alert("No video to approve. Please record a video first.");
      return;
    }

    // Upload video in chunks
    const uploadResponse = await uploadChunks(blob);

    if (uploadResponse && uploadResponse.videoUrl) {
      videoUrl = uploadResponse.videoUrl; // Save video URL
      alert(`Video uploaded successfully! Your video URL: ${videoUrl}`);

      // Show additional fields
      if (additionalFields) {
        additionalFields.style.display = "block";
      }

      // Hide unnecessary buttons
      approveButton.style.display = "none";
      newRecordButton.style.display = "none";
      sendButton.style.display = "inline-block";
    } else {
      alert("Failed to upload the video. Please try again.");
    }
  });


  // Submit button logic
  sendButton.addEventListener("click", async () => {
    if (!videoUrl) {
      alert("No video uploaded. Please record and approve a video first.");
      return;
    }

    const name = document.getElementById("name").value;
    const number = document.getElementById("number").value;
    const comment = document.getElementById("comment").value;
    const email = document.getElementById("email").value;
    const serialNumber = new URLSearchParams(window.location.search).get("serialNumber");

    if (!comment || !email || !name || !number) {
      alert("Please fill in all fields (comment and email).");
      return;
    }

    try {
      const response = await fetch("/create-ticket", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          comment,
          name,
          number,
          video: videoUrl,
          email,
          serialNumber,
        }),
      });

      const result = await response.json();
      if (result.success) {
        alert("Ticket created successfully!");
        redirectToFormSubmitted();
      } else {
        alert("Error creating ticket: " + result.message);
      }
    } catch (error) {
      console.error("Error:", error);
      alert("An error occurred while creating the ticket.");
    }
  });


  // Setup the MediaRecorder
  function setupMediaRecorder(videoElement, mimeType) {
    navigator.mediaDevices
      .getUserMedia({
        video: { facingMode: { exact: "environment" } },
        audio: true,
      })
      .then((stream) => {
        console.log("Stream obtained successfully");
        videoElement.srcObject = stream;
        videoElement.play().catch((error) => console.error("Video play error:", error));

        videoElement.setAttribute("playsinline", true);

        videoElement.onloadedmetadata = () => {
          videoElement.play().catch((error) =>
            console.error("Error playing video:", error)
          );
        };

        mediaRecorder = new MediaRecorder(stream, { mimeType });
        mediaRecorder.ondataavailable = (event) => {
          if (event.data.size > 0) {
            recordedChunks.push(event.data);
          }
        };

        mediaRecorder.onstop = () => {
          blob = new Blob(recordedChunks, { type: mimeType });
          const url = URL.createObjectURL(blob);
          videoElement.srcObject = null;
          videoElement.src = url;
          videoElement.controls = true;

          recordButton.style.display = "none";
          newRecordButton.style.display = "inline-block";
          approveButton.style.display = "inline-block";
        };
      })
      .catch((error) => {
        console.error("Error accessing camera or microphone:", error);
        if (error.name === "NotAllowedError") {
          alert("Camera access was denied. Check privacy settings.");
        } else if (error.name === "NotFoundError") {
          alert("Camera not found. Make sure your device has a working camera.");
        } else {
          alert("Error accessing camera: " + error.message);
        }
      });
  }


  // Upload video in 1MB chunks
  async function uploadChunks(blob) {
    const CHUNK_SIZE = 1 * 1024 * 1024; // 1 MB
    const totalChunks = Math.ceil(blob.size / CHUNK_SIZE);
    let currentChunk = 0;

    const sendChunk = async () => {
      const start = currentChunk * CHUNK_SIZE;
      const end = Math.min(blob.size, start + CHUNK_SIZE);
      const chunk = blob.slice(start, end);

      const formData = new FormData();
      formData.append("chunk", chunk, `video.${supportedMimeType.split("/")[1]}`);
      formData.append("chunkIndex", currentChunk);
      formData.append("totalChunks", totalChunks);

      const response = await fetch("/upload", {
        method: "POST",
        body: formData,
      });

      const data = await response.json();
      currentChunk++;
      if (currentChunk < totalChunks) {
        return sendChunk();
      } else {
        return { videoUrl: data.video };
      }
    };

    return sendChunk();
  }
})
