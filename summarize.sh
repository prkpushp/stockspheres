#!/bin/bash

video_id="$1"
text=$(cat "shortswork_flow/$video_id/${video_id}.txt")
GEMINI_API_KEY="${{ secrets.GEMINI_API_KEY }}"
url="https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro-002:generateContent?key=${GEMINI_API_KEY}"

json=$(jq -n --arg txt "भाई, सुनो! इस वीडियो का फुल टु मजेदार 40 सेकंड का निचोड़ दो, जैसे दोस्त को समझा रहे हो! सिर्फ 60-75 शब्दों में।: $text" '{
    contents: [{
        parts: [{ text: $txt }]
    }]
}')

response=$(curl -s -X POST "$url" -H "Content-Type: application/json" -d "$json")
summary=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text // "Error"')
echo "$summary" > "shortswork_flow/$video_id/${video_id}_summary.txt"
