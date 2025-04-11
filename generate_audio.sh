#!/bin/bash

video_id="$1"
ELEVENLABS_API_KEY="${{ secrets.ELEVENLABS_API_KEY }}"
text=$(cat "shortswork_flow/$video_id/${video_id}_summary.txt" | jq -Rs .)
output="shortswork_flow/$video_id/${video_id}.mp3"

body=$(cat <<EOF
{
  "text": $text,
  "model_id": "eleven_multilingual_v2",
  "voice_settings": {
    "stability": 0.5,
    "similarity_boost": 0.9,
    "style_exaggeration": 1.5
  }
}
EOF
)

curl -X POST "https://api.elevenlabs.io/v1/text-to-speech/rFzjTA9NFWPsUdx39OwG" \
     -H "Content-Type: application/json" \
     -H "xi-api-key: $ELEVENLABS_API_KEY" \
     -d "$body" --output "$output"
