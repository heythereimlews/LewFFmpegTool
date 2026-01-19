# SoftTelecineSlayer

**SoftTelecineSlayer** is a small Windows batch-based FFmpeg front-end designed for physical-media enthusiasts who work with DVD and Blu-ray rips.  
It automates common restoration tasks like soft-telecine correction, deinterlacing, and pulldown creation — with clean timestamps and sane defaults.

Built by **Lewis (HeyThereImLews)** for personal media-restoration workflows.

---

## ✨ Features

- Convert **soft-telecine progressive DVDs (29.97p flagged film)** → true **23.976p**  
  (no frame dropping, no speed-up, correct timestamps)

- Deinterlace **true interlaced sources** → clean progressive output  
  (handles NTSC & PAL automatically)

- Add **3:2 pulldown** when needed

- Automatic output directory (`C:\Rips`)

- Clean console UI with readable progress output

- No external GUI dependencies — just FFmpeg

---

## 🧠 Why this tool exists

Many DVDs store film content as **progressive 29.97 with soft-telecine flags**.  
Typical IVTC filters (`pullup/decimate`) are designed for **hard telecine** and can:

- Drop real frames
- Produce sped-up playback
- Break timestamps
- Cause audio sync issues

**SoftTelecineSlayer** correctly handles **soft-telecine progressive sources** by rebuilding timestamps instead of dropping frames.

---

## ⚙️ Requirements

- Windows
- FFmpeg in system PATH  
  (https://ffmpeg.org/download.html)

---

## 🚀 Usage

1. Run `LewFFmpegTool.bat`
2. Enter full path to your input video
3. Choose an operation: 1 for removing 3:2 Pulldown, 2 to deinterlace, and 3 to add 3:2 pulldown so the other way around.

Have fun, make sure to credit me! And happy archiving :)

