const express = require("express");
const fs = require("fs");
const path = require("path");
const multer = require("multer");
const app = express();
const PORT = process.env.PORT || 4000;

// Set test URL-stub for QRcode
const { exec } = require("child_process");

// Set EJS as the view engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Define routes
app.get("/", (req, res) => {
  res.render("index", { content: "home" });
});

// QR code implementation for http://localhost:4000/?manufacturerId=123&productCode=456

// app.get("/", (req, res) => {
//     const manufacturerId = req.query.manufacturerId || "";
//     const productCode = req.query.productCode || "";

//     res.render("index", {
//         content: "home",
//         manufacturerId,
//         productCode,
//     });
// });

app.get("/recording", (req, res) => {
  res.render("index", { content: "recording" });
});

app.get("/form-submitted", (req, res) => {
  res.render("index", { content: "form-submitted" });
});

// Set up static files
const uploadPath = path.join(__dirname, "uploads");
if (!fs.existsSync(uploadPath)) {
  fs.mkdirSync(uploadPath);
}
app.use("/uploads", express.static(uploadPath));
app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// File upload configuration
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

let writeStream = null;
let currentFilePath = null;

app.post("/upload", upload.single("chunk"), (req, res) => {
  const chunk = req.file;
  const chunkIndex = parseInt(req.body.chunkIndex, 10);
  const totalChunks = parseInt(req.body.totalChunks, 10);

  if (chunkIndex === 0) {
    if (writeStream) {
      writeStream.end();
    }
    const filename = `video_${Date.now()}.webm`;
    currentFilePath = path.join(uploadPath, filename);
    writeStream = fs.createWriteStream(currentFilePath);
  }

  writeStream.write(chunk.buffer, (err) => {
    if (err) {
      return res
        .status(500)
        .json({ success: false, message: "File write error" });
    }

    console.log(`Chunk ${chunkIndex + 1}/${totalChunks} uploaded`);

    if (chunkIndex + 1 === totalChunks) {
      writeStream.end();
      const downloadUrl = `http://localhost:${PORT}/uploads/${path.basename(
        currentFilePath
      )}`;
      return res.json({
        success: true,
        message: "All chunks uploaded and file assembled",
        video: downloadUrl,
      });
    } else {
      res.json({ success: true, message: `Chunk ${chunkIndex + 1} uploaded` });
    }
  });
});

// old standard create-ticket function

// app.post("/create-ticket", async (req, res) => {
//     console.log("Request body:", req.body);

//     const { comment, email, video } = req.body;

//     if (!comment || !email || !video) {
//         return res.status(400).json({
//             success: false,
//             message: "Comment, email, and video are required.",
//         });
//     }

//     // Add a text link to the video
//     const fullComment = `${comment}\n\nVideo link: ${video}`;

//     try {
//         const fetch = (await import("node-fetch")).default;

//         const response = await fetch("http://localhost/api/tickets.json", {
//             method: "POST",
//             headers: {
//                 "Content-Type": "application/json",
//                 "X-API-Key": "52042121362A4DF9EC54070117252288",
//             },
//             body: JSON.stringify({
//                 name: "Test API User",
//                 email: email,
//                 subject: "New Ticket Submission",
//                 message: fullComment, // Add a text link to the video
//             }),
//         });

//         const isJson = response.headers
//             .get("content-type")
//             ?.includes("application/json");
//         const resultText = isJson ? await response.json() : await response.text();
//         console.log("API Response:", resultText);

//         if (response.ok) {
//             res.json({ success: true, message: "Ticket successfully created!" });
//         } else {
//             res.status(500).json({ success: false, message: resultText });
//         }
//     } catch (error) {
//         console.error("Error sending the ticket:", error);
//         res.status(500).json({
//             success: false,
//             message: "An error occurred while creating the ticket.",
//         });
//     }
// });

// create-ticket function with new fields
app.post("/create-ticket", async (req, res) => {
  // Log the request body
  console.log("Request body:", req.body);

  const { comment, email, video, name } = req.body;
  // const { manufacturerId, productCode } = req.query;

  // Validate required fields
  if (!comment || !email || !video) {
    return res.status(400).json({
      success: false,
      message: "Comment, email, and video are required.",
    });
  }

  // Predefined data with support for the name field
  const predefinedData = {
    manufacturer: "Stryker Corporation",
    deviceName: "Sonopet iQ",
    productCode: "1.0",
    serialNumber: "2203003500268",
    firma: "Österreichisches Rotes Kreuz",
    name: "Max Mustermann",
    address: "Hohenzeller Straße 3, 4910 Ried im Innkreis",
    phone: "+43 7752 81844 801",
  };

  // Construct the full comment
  const fullComment = `
        ${comment}
        
        Video link: ${video}
        
        -- Additional Info --
      Manufacturer: ${predefinedData.manufacturer}
      Device Name: ${predefinedData.deviceName}
      Product Code: ${predefinedData.productCode}
      Serial Number: ${predefinedData.serialNumber}
      Company: ${predefinedData.firma}
      Contact Person: ${predefinedData.name}
      Address: ${predefinedData.address}
      Phone: ${predefinedData.phone}

     
    `;
  // Manufacturer: ${manufacturerId}
  // Product Code: ${productCode}

  try {
    const fetch = (await import("node-fetch")).default;

    const response = await fetch("http://localhost/api/tickets.json", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-API-Key": "52042121362A4DF9EC54070117252288",
      },
      body: JSON.stringify({
        name: predefinedData.ansprechpartner, // Send the name to the ticket system
        email: email,
        subject: "New Ticket Submission",
        message: fullComment, // Full comment with data
      }),
    });

    // Check if the response is JSON
    const isJson = response.headers
      .get("content-type")
      ?.includes("application/json");
    const resultText = isJson ? await response.json() : await response.text();
    console.log("API Response:", resultText);

    if (response.ok) {
      res.json({ success: true, message: "Ticket successfully created!" });
    } else {
      res.status(500).json({ success: false, message: resultText });
    }
  } catch (error) {
    console.error("Error sending the ticket:", error);
    res.status(500).json({
      success: false,
      message: "An error occurred while creating the ticket.",
    });
  }
});

//standard listener
// app.listen(PORT, () => {
//     console.log(`Server running on port ${PORT}`);
// });

//stub-listener with the predefined URL
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);

  const url = `http://localhost:${PORT}/?manufacturerId=123&productCode=2203003500268`;

  // Open the browser (Windows only)
  exec(`start ${url}`);

  console.log(`Browser opened with URL: ${url}`);
});
//актуальная версия
const express = require("express");
const fs = require("fs");
const path = require("path");
const multer = require("multer");
const moddataurl = require("node-rfc2397");

const app = express();

// //Uncomment to enable HTTPS
// var https = require('https');

// var options = {
//   key: fs.readFileSync('../key.pem'),
//   cert: fs.readFileSync('../cert.pem')
// };

// // Create an HTTPS service identical to the HTTP service.
// https.createServer(options, app).listen(4443);


const PORT = process.env.PORT || 4000;
const ticketApiURL = "ticket.mediarecorder.bluezone.at";
const ticketApi = `https://${ticketApiURL}/api/tickets.json`;

// Set EJS as the view engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Static files setup
const uploadPath = path.join(__dirname, "uploads");
if (!fs.existsSync(uploadPath)) {
  fs.mkdirSync(uploadPath);
}
app.use("/uploads", express.static(uploadPath));
app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// File upload configuration
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

let writeStream = null;
let currentFilePath = null;

// Routes
app.get("/", (req, res) => {
  const serialNumber = req.query.serialNumber;

  const predefinedDevices = {
    "2203003500268": {
      image: "/images/Sonopet.webp",
      deviceName: "Sonopet iQ",
      manufacturer: "Stryker Corporation",
      productCode: "1.0",
      serialNumber: "2203003500268",
      firma: "Österreichisches Rotes Kreuz",
      name: "Max Mustermann",
      address: "Hohenzeller Straße 3, 4910 Ried im Innkreis",
      phone: "+43 7752 81844 801",
    },
    "2298909558763": {
      image: "/images/Power_PRO.webp",
      deviceName: "Power-PRO XT Elektrisch betriebene Fahrtrage",
      manufacturer: "Stryker Corporation",
      productCode: "6506",
      serialNumber: "2298909558763",
      firma: "Krankenhaus der Barmherzigen Brüder",
      name: "Dr. Johannes Müller",
      address: "Marschallgasse 12, 8020 Graz, Österreich",
      phone: "+43 316 7060",
    },
  };

  const predefinedData = predefinedDevices[serialNumber] || {
    image: "/images/default.webp",
    deviceName: "Unknown Device",
    serialNumber: serialNumber
  };

  res.render("index", { content: "home", predefinedData: predefinedData });
});

app.get("/recording", (req, res) => {
  const serialNumber = req.query.serialNumber;
  res.render("index", { content: "recording", predefinedData: { serialNumber: serialNumber } });
});

app.get("/form-submitted", (req, res) => {
  res.render("index", { content: "form-submitted", predefinedData: null });
});

// Handle video upload in chunks
app.post("/upload", upload.single("chunk"), (req, res) => {
  const chunk = req.file;
  const chunkIndex = parseInt(req.body.chunkIndex, 10);
  const totalChunks = parseInt(req.body.totalChunks, 10);

  if (chunkIndex === 0) {
    if (writeStream) {
      writeStream.end();
    }
    const filename = `video_${Date.now()}.webm`;
    currentFilePath = path.join(uploadPath, filename);
    writeStream = fs.createWriteStream(currentFilePath);
  }

  writeStream.write(chunk.buffer, (err) => {
    if (err) {
      return res.status(500).json({ success: false, message: "File write error" });
    }

    console.log(`Chunk ${chunkIndex + 1}/${totalChunks} uploaded`);

    if (chunkIndex + 1 === totalChunks) {
      writeStream.end();
      const downloadUrl = `http://${req.headers['host']}/uploads/${path.basename(
        currentFilePath
      )}`;
      return res.json({
        success: true,
        message: "All chunks uploaded and file assembled",
        video: downloadUrl,
      });
    } else {
      res.json({ success: true, message: `Chunk ${chunkIndex + 1} uploaded` });
    }
  });
});

// Handle ticket creation
app.post("/create-ticket", async (req, res) => {
  const serialNumber = req.body.serialNumber?.trim();

  const predefinedDevices = {
    "2203003500268": {
      manufacturer: "Stryker Corporation",
      deviceName: "Sonopet iQ",
      productCode: "1.0",
      serialNumber: "2203003500268",
      firma: "Österreichisches Rotes Kreuz",
      address: "Hohenzeller Straße 3, 4910 Ried im Innkreis",
    },
    "2298909558763": {
      manufacturer: "Stryker Corporation",
      deviceName: "Power-PRO XT Elektrisch betriebene Fahrtrage",
      productCode: "6506",
      serialNumber: "2298909558763",
      firma: "Krankenhaus der Barmherzigen Brüder",
      address: "Marschallgasse 12, 8020 Graz, Österreich",
    },
  };

  const predefinedData = predefinedDevices[serialNumber] || {
    manufacturer: "Unknown Manufacturer",
    deviceName: "Unknown Device",
    productCode: "N/A",
    serialNumber: serialNumber || "N/A",
    firma: "Unknown Company",
    address: "Unknown Address",
  };

  const { name, number, comment, email, video } = req.body;

  const fullComment = `
    ${comment}
    Video link: ${video}

    -- Additional Info --
    Name: ${name}
    Phone Number: ${number}
    Manufacturer: ${predefinedData.manufacturer}
    Device Name: ${predefinedData.deviceName}
    Product Code: ${predefinedData.productCode}
    Serial Number: ${predefinedData.serialNumber}
    Company: ${predefinedData.firma}
    Address: ${predefinedData.address}
  `;

  try {
    const fetch = (await import("node-fetch")).default;

    const bodytext = JSON.stringify({
      name: name,
      email: email,
      subject: "New Ticket Submission",
      message: fullComment,
      video: video,
    });

    const response = await fetch(ticketApi, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-API-Key": "9BD589EC1646E4B4A6966B277B1FD08F",
      },
      body: bodytext,
    });

    const resultText = await response.text();
    if (response.ok) {
      res.json({
        success: true,
        message: "Ticket was successfully created!",
      });
    } else {
      res.status(500).json({ success: false, message: resultText });
    }
  } catch (error) {
    console.error("Error while sending the ticket:", error);
    res.status(500).json({
      success: false,
      message: "An error occurred while creating the ticket.",
    });
  }
});


// Start the server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Use the following URLs in your QR codes:`);
  console.log(`1: http://192.168.56.101:${PORT}/?serialNumber=2203003500268`);
  console.log(`2: http://192.168.56.101:${PORT}/?serialNumber=2298909558763`);
});

