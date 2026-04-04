const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Ensure the directory exists (System fail-safe)
const uploadDir = './uploads';
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}

// 1. Configure STORAGE Strategy (Renaming logic)
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, uploadDir); // Save to the 'uploads' folder
    },
    filename: function (req, file, cb) {
        // [Renaming Logic]: We use a prefix (from the request body) 
        // + a timestamp + the original file extension.
        // Example output: npc_small_spider_1712345678.jpg
        const prefix = req.body.image_prefix || 'generic';
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        const ext = path.extname(file.originalname).toLowerCase();
        
        cb(null, `${prefix}_${uniqueSuffix}${ext}`);
    }
});

// 2. Configure FILTER (Only allow images)
const fileFilter = (req, file, cb) => {
    const allowedTypes = /jpeg|jpg|png|webp|gif/;
    const extName = allowedTypes.test(path.extname(file.originalname).toLowerCase());
    const mimeType = allowedTypes.test(file.mimetype);

    if (extName && mimeType) {
        return cb(null, true);
    } else {
        cb(new Error('[SYSTEM ERROR]: Critical Malfunction. Only image files are accepted into the Matrix.'));
    }
};

// 3. Initialize Multer
const upload = multer({
    storage: storage,
    limits: { fileSize: 5 * 1024 * 1024 }, // 5MB limit
    fileFilter: fileFilter
});

module.exports = upload;