#!/usr/bin/env bash
# Launcher for macOS/Linux. Runs the web app with the project's Python 3.13 venv,
# which is required for HD downloads (see README "Running on macOS").
set -e

cd "$(dirname "$0")"

if [ ! -x "venv/bin/python" ]; then
  echo "[X] venv not found. Create it first:"
  echo "    python3.13 -m venv venv"
  echo "    venv/bin/pip install -r requirements.txt"
  echo "    venv/bin/pip install -U 'yt-dlp[default]' faster-whisper bgutil-ytdlp-pot-provider"
  exit 1
fi

echo "[*] Starting YouTube Heatmap Clipper..."
echo "[*] Open your browser at: http://127.0.0.1:${PORT:-5050}"
exec venv/bin/python webapp.py
