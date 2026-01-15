# YouTube Heatmap Clipper 🎬

[🇮🇩 Bahasa Indonesia](README.md) | 🇺🇸 **English**

A web application to extract the most engaging moments from YouTube videos using "Most Replayed" (heatmap) data, and automatically convert them into vertical-ready clips for Shorts, Reels, and TikTok — featuring AI-powered subtitles.

This is the web version of the original project: https://github.com/0xACAB666/yt-heatmap-clipper (making the powerful CLI version more "human-friendly").

## Preview

|                            |                            |
| -------------------------- | -------------------------- |
| ![Preview 1](images/1.png) | ![Preview 2](images/2.png) |
| ![Preview 3](images/3.png) | ![Preview 4](images/4.png) |
| ![Preview 5](images/5.png) |                            |

## Features

### Core Features

- Scans YouTube videos via URL
- Extracts YouTube "Most Replayed" (heatmap) segments
- Automatically selects high-engagement moments
- Configurable pre and post padding for each clip
- Outputs 9:16 vertical video format (720x1280)
- No YouTube API key required
- Supports standard YouTube videos and Shorts

### Advanced Features

- **3 Crop Modes**:
  - **Default**: Center crop from the original video
  - **Split Left**: Top = center content, Bottom = bottom-left (facecam)
  - **Split Right**: Top = center content, Bottom = bottom-right (facecam)
- **AI Auto Subtitle (Faster-Whisper)**:
  - 4-5x faster than standard Whisper
  - Supports 99+ languages including Indonesian and English
  - Multiple model sizes: tiny, base, small, medium, large
  - Automatic transcription and subtitle burning
  - Customizable subtitle styles

### Web UI Extras

- **Clean Web Interface**: No CLI required for scanning and clipping
- **Video Metadata Preview**: View title, channel, duration, and thumbnail
- **Heatmap Visualization**: List segments with individual previews
- **Batch Processing**: Multi-select segments and "Create Selected Clips"
- **Custom Ranges**: Manually set Start/End times for custom clipping
- **Multiple Aspect Ratios**: 9:16, 1:1, 16:9, or original ratio
- **Advanced Subtitle Options**:
  - Faster-Whisper model selection (tiny → large-v3)
  - Font selection (Plus Jakarta Sans, Roboto, Montserrat, Arial, or Custom)
  - Subtitle positioning (Bottom or Centered)
  - Custom fonts directory support

## Requirements

- Python 3.8+ (Python 3.11 recommended)
- **FFmpeg (REQUIRED)**
- Internet connection
- Optional: `faster-whisper` (for AI subtitles)

## How to Use (Easiest Way)

Just double-click the **`start.bat`** file.
This script will automatically:

1. Check & Install all requirements
2. Create a safe Python environment (venv)
3. Check for FFmpeg
4. Run the web application

## Installation (Manual)

```powershell
python -m pip install -r requirements.txt
python -m pip install faster-whisper
```

_Note: Skip `faster-whisper` if you don't need subtitle support._

## Run Web App

```powershell
python webapp.py
```

Access at:

- http://127.0.0.1:5000/

## How to Use (Web)

1. **Paste YouTube URL**: Video preview will appear automatically.
2. **Choose Mode**:
   - **Scan Heatmap**: Click "Scan Heatmap" → Select segments → "Create Selected Clips".
   - **Custom Range**: Enter manual Start/End times → "Create Clip".
3. **Configure**: Set Ratio, Crop, Padding, and Subtitles (optional).
4. **Progress**: Monitor the progress panel for output logs and Download/Play buttons.

## Run CLI (Optional)

```powershell
python run.py --url "https://www.youtube.com/watch?v=VIDEO_ID" --crop default --subtitle y --whisper-model small --subtitle-font "Plus Jakarta Sans" --subtitle-fontsdir "fonts" --subtitle-location bottom --ratio 9:16
```

### Key Arguments:

- `--crop`: `default` | `split_left` | `split_right`
- `--ratio`: `9:16` | `1:1` | `16:9` | `original`
- `--subtitle`: `y` | `n`
- `--whisper-model`: `tiny` | `base` | `small` | `medium` | `large-v3`
- `--subtitle-font`: Font name (e.g., Poppins)
- `--subtitle-fontsdir`: Folder containing .ttf/.otf files (default: `fonts`)
- `--subtitle-location`: `bottom` | `center`

## Fonts

- Place font files in the `fonts/` directory (e.g., `fonts/Poppins/Poppins-Regular.ttf`).
- Set "Fonts dir" to `fonts` in the UI.
- Select your font from the dropdown or use "Custom" and type the font family name (e.g., `Poppins`).

## FFmpeg

FFmpeg must be accessible via your system PATH. On Windows, the app also attempts to auto-detect FFmpeg if installed via WinGet.

**Easiest way to install (Windows):**
Open PowerShell as Administrator and run:

```powershell
winget install Gyan.FFmpeg
```

After installation, **RESTART** your terminal or VS Code for FFmpeg to be recognized.

### Whisper Model Comparison

| Model        | Size   | RAM     | Speed (60s) | Accuracy  | Best For                |
| ------------ | ------ | ------- | ----------- | --------- | ----------------------- |
| **tiny**     | 75 MB  | ~500 MB | ~5-7s       | Good      | Quick clips, low-end PC |
| **base**     | 142 MB | ~700 MB | ~8-10s      | Better    | General purpose         |
| **small**    | 466 MB | ~1.5 GB | ~15-20s     | Great     | Quality content         |
| **medium**   | 1.5 GB | ~3 GB   | ~40-50s     | Excellent | Professional work       |
| **large-v3** | 2.9 GB | ~6 GB   | ~90-120s    | Best      | Production quality      |

> **Recommendation**: Use `tiny` for speed, `small` for a balance of quality and speed.

---

## Output

### Video Specifications

- **Format**: MP4 (H.264 video + AAC audio)
- **Resolution**: 720x1280 (9:16 vertical)
- **Video Codec**: libx264, CRF 26, `ultrafast` preset
- **Audio Codec**: AAC, 128 kbps
- **Subtitles**: Burned-in (if enabled), white text with black outline

### File Naming

```
clips/
├── clip_1.mp4
├── clip_2.mp4
└── clip_3.mp4
```

Clips are numbered based on their engagement score (highest first).

---

## Crop Mode Visualization

### Mode 1: Default (Center Crop)

```
Original Video (16:9)         Output (9:16)
┌─────────────────────┐       ┌──────┐
│   [   CONTENT   ]   │  -->  │CONTENT│
└─────────────────────┘       └──────┘
       crop center             full height
```

### Mode 2: Split Left (Facecam Bottom-Left)

```
Original Video (16:9)                Output (9:16)
┌─────────────────────────┐         ┌──────────┐
│                         │         │  GAME    │ 960px
│       GAME AREA         │   -->   │ CONTENT  │
│  [👤]                   │         ├──────────┤
└─────────────────────────┘         │ 👤 FACE  │ 350px
    facecam bottom-left             └──────────┘
```

### Mode 3: Split Right (Facecam Bottom-Right)

```
Original Video (16:9)                Output (9:16)
┌─────────────────────────┐         ┌──────────┐
│                         │         │  GAME    │ 960px
│       GAME AREA         │   -->   │ CONTENT  │
│                   [👤]  │         ├──────────┤
└─────────────────────────┘         │ 👤 FACE  │ 350px
    facecam bottom-right            └──────────┘
```

---

## Troubleshooting

### FFmpeg not found

```bash
# Windows: Download from https://ffmpeg.org/download.html
# Add to PATH or place ffmpeg.exe in script directory

# macOS:
brew install ffmpeg

# Linux:
sudo apt install ffmpeg
```

### No high-engagement segments found

- The video might not have "Most Replayed" data yet (requires sufficient views/engagement).
- Try lowering the `MIN_SCORE` (e.g., from 0.40 to 0.30).
- Verify the YouTube URL is correct.

### Subtitle generation fails

- Ensure an active internet connection for the initial model download.
- Check available RAM (Whisper needs ~500MB-2GB depending on the model).
- Try a smaller model: change `WHISPER_MODEL` from `small` to `tiny`.

### Slow transcription

- Use a smaller model (`tiny` instead of `small`).
- Faster-Whisper is already 4-5x faster than standard Whisper.
- Consider upgrading RAM or using the GPU version.

### Video download fails

- Check your internet connection.
- Verify the YouTube URL is accessible.
- Some videos might be region-locked or have age restrictions.
- Try updating yt-dlp: `pip install -U yt-dlp`.

---

## Tips & Best Practices

### For Gaming Content

- Use **Split Right** or **Split Left** mode to include the facecam.
- Keep `PADDING = 10` for context before and after action.
- Use `small` or `base` models for accurate gaming terminology.

### For Tutorial/Vlog Content

- Use **Default** center crop mode.
- Increase `MAX_DURATION = 90` for longer explanations.
- Enable subtitles with the `tiny` model for rapid processing.

### For Fast-Paced Content

- Reduce `PADDING = 5` to keep clips tight.
- Increase `MIN_SCORE = 0.50` to capture only peak moments.
- Use the `tiny` model to match the quick editing style.

### Subtitle Customization

Edit line ~368 in `run.py` to customize subtitle style:

```python
# Current style (white text, black outline):
BorderStyle=1,Outline=3,Shadow=2,MarginV=30

# Large text:
FontSize=28,Outline=4

# Position higher (avoid facecam):
MarginV=400

# Different color (yellow):
PrimaryColour=&H00FFFF
```

---

## Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

---

## License

MIT License

---

## Credits & Special Thanks

- Special thanks to the original project (CLI version) which served as the foundation: https://github.com/0xACAB666/yt-heatmap-clipper
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - YouTube video downloader
- [FFmpeg](https://ffmpeg.org/) - Video processing
- [Faster-Whisper](https://github.com/guillaumekln/faster-whisper) - AI transcription
- [OpenAI Whisper](https://github.com/openai/whisper) - Speech recognition model

---

## Support

If you find this tool useful, please ⭐ star this repository!

For issues and questions, please open an issue on GitHub.
