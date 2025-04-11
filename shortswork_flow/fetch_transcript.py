import sys
from youtube_transcript_api import YouTubeTranscriptApi
import json
import os

def fetch_transcript(video_id):
    try:
        transcript = YouTubeTranscriptApi.get_transcript(video_id)
        os.makedirs(f"shortswork_flow/output/{video_id}", exist_ok=True)
        with open(f"shortswork_flow/output/{video_id}/transcript.json", "w") as f:
            json.dump(transcript, f, indent=2)
        print(f"Transcript saved for video ID: {video_id}")
    except Exception as e:
        print(f"Failed to fetch transcript: {e}")
        sys.exit(1)

if __name__ == "__main__":
    fetch_transcript(sys.argv[1])
