# MediaRecorder Prototype

A prototype for recording and transferring videos using the MediaRecorder API. The user can record videos through a web interface, edit them, and then upload them to the server in chunks only after confirmation.

## Features
- Selection of expert category and display of relevant recording guidelines.
- Video recording with the MediaRecorder API.
- Ability to edit, re-record, or approve the video before uploading.
- Chunked upload of the video to the server upon confirmation.
- Videos are stored on the server after approval and uploaded piece by piece.
- Video playback is enabled after recording, allowing the user to view the recording before deciding on next steps.
- Optional features (planned): video editing, adding settings, sending the video to experts.

## Updated Workflow
1. The user records the video using the provided interface.
2. After stopping the recording, the video is not immediately uploaded to the server.
3. The user has the following options:
    - **Edit**: Modify the recorded video (currently opens an alert message).
    - **Approve**: Upload the video in chunks to the server after confirmation.
    - **Re-record**: Start a new recording, discarding the current one.
4. The video is uploaded only after the user clicks the "Approve" button.

## Installation
1. Clone the repository:
    ```sh
    git clone https://gitlab.core.local.blue-zone.at/CDE/Modules/mediarecorder-prototype.git
    cd mediarecorder-prototype
    ```
2. Install the dependencies:
    ```sh
    npm install
    ```

## Start the Server
1. Start the backend server:
    ```sh
    npm start
    ```
2. Open your browser and go to:
    ```
    http://localhost:4000
    ```

## Technologies Used
- **Frontend**: HTML, CSS, JavaScript (Vanilla)
- **Backend**: Node.js, Express.js
- **Video Recording**: MediaRecorder API
- **Video Upload**: Chunked upload to the server using `fetch()`

## Roadmap
- Add support for video editing features before uploading.
- Implement cloud storage integration for video uploads.
- Enable sending videos directly to experts for evaluation.

## Authors and Acknowledgments
- **Daria Stoyanovskaya** - Junior Developer
- **Christian Breitwieser** - Senior Developer

## License
This project is proprietary and belongs to BLUE-ZONE. It is subject to internal licensing rules and policies.

## Project Status
The project is under active development. Further updates and improvements are planned.
