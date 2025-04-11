#!/bin/bash

video_id="$1"
summary=$(cat "shortswork_flow/$video_id/${video_id}_summary.txt")
GEMINI_API_KEY="${{ secrets.GEMINI_API_KEY }}"

json=$(jq -n --arg summary "$summary" '{
    contents: [{
        parts: [{ text: "Generate a catchy YouTube Shorts title (max 40 characters), a 2-line description, and 5-7 trending hashtags for this summary: \($summary)" }]
    }]
}')

response=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro-002:generateContent?key=${GEMINI_API_KEY}" \
                -H "Content-Type: application/json" -d "$json")

echo "$response" | jq -r '.candidates[0].content.parts[0].text // "Error"' > "shortswork_flow/$video_id/${video_id}_shorts.txt"
