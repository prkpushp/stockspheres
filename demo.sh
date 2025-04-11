#!/bin/bash
set -e

YOUTUBE_URL=$1
VIDEO_ID=$(echo "$YOUTUBE_URL" | sed -n 's/.*v=\([^&]*\).*/\1/p')

echo "Fetching transcript..."
python3 shortswork_flow/fetch_transcript.py "$VIDEO_ID"

echo "Summarizing..."
./summarize.sh "$VIDEO_ID"

echo "Generating audio..."
./generate_audio.sh "$VIDEO_ID"

echo "Creating metadata..."
./generate_metadata.sh "$VIDEO_ID"

ffmpeg -i "shortswork_flow/$VIDEO_ID/$VIDEO_ID.mp3" -filter:a "atempo=1.25" "shortswork_flow/$VIDEO_ID/$VIDEO_ID_fast.mp3"

echo "✅ Workflow complete for video ID: $VIDEO_ID"
