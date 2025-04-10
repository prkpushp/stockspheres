#!/bin/bash
set -e

YOUTUBE_URL=$1
VIDEO_ID=$(echo "$YOUTUBE_URL" | grep -oP '(?<=v=)[^&]+')

echo "Fetching transcript..."
python3 shorts_workflow/fetch_transcript.py "$VIDEO_ID"

echo "Summarizing..."
./shorts_workflow/summarize.sh "$VIDEO_ID"

echo "Generating audio..."
./shorts_workflow/generate_audio.sh "$VIDEO_ID"

echo "Creating metadata..."
./shorts_workflow/generate_metadata.sh "$VIDEO_ID"

echo "✅ Workflow complete for video ID: $VIDEO_ID"
