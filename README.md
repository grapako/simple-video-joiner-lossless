# Simple Video Joiner (Lossless) 🎬

A lightweight Windows Batch script to merge multiple video files (MP4) into a single file instantly, without re-rendering or losing quality.

## 🌟 Features
- **No Rendering:** Uses FFmpeg's "stream copy" mode (merges in seconds).
- **100% Quality Retention:** Does not touch the video or audio pixels.
- **Auto-Detection:** Automatically finds and lists all `.mp4` files in the folder.
- **UTF-8 Support:** Handles Spanish accents and special characters in filenames.
- **Verification Step:** Shows the join order before starting.

## 🛠️ Requirements
This script requires **FFmpeg** to be installed and added to your system's PATH. 
*Note: If you have [auto-editor](https://github.com/WyattBlue/auto-editor) installed, you already have FFmpeg.*

## 🚀 How to Use
1. Download `SimpleVideoJoiner.bat`.
2. Place the script in the folder containing your video parts.
3. (Optional) Rename your files (e.g., `01-video.mp4`, `02-video.mp4`) to ensure the correct order.
4. Run the script and select **Option 1 (Auto-Join)**.
5. The merged file will appear as `[first_file_name]-merged.mp4`.

## 🤝 Credits
- **Author:** [Juan Ignacio Peralta](https://github.com/grapako)
- **Assisted by:** Gemini 3 Pro
