#!/bin/bash

url="$1"
video_id=$(echo "$url" | grep -o 'v=[^&]*' | cut -d'=' -f2)

if [[ -z "$video_id" ]]; then
    echo "Invalid YouTube URL."
    exit 1
fi

mkdir -p shorts_workflow/$video_id && cd shorts_workflow/$video_id

echo "Fetching transcript..."
python3 ../../fetch_with_notegpt.py "$url"

../../summarize.sh "$video_id"
../../generate_audio.sh "$video_id"
../../generate_metadata.sh "$video_id"
