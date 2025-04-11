#!/bin/bash
set -e

YOUTUBE_URL=$1
VIDEO_ID=$(echo "$YOUTUBE_URL" | grep -oP '(?<=v=)[^&]+')

echo "Fetching transcript..."
python3 shortswork_flow/fetch_transcript.py "$VIDEO_ID"

echo "Summarizing..."
./summarize.sh "$VIDEO_ID"

echo "Generating audio..."
./generate_audio.sh "$VIDEO_ID"

echo "Creating metadata..."
./generate_metadata.sh "$VIDEO_ID"

echo "✅ Workflow complete for video ID: $VIDEO_ID"
