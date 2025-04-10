import sys
import requests
import time

def fetch_transcript(video_url):
    headers = {
        "authority": "api.notegpt.io",
        "accept": "application/json",
        "content-type": "application/json"
    }

    data = {
        "url": video_url,
        "translate": False,
        "type": "youtube",
        "from": "en",
        "to": "en"
    }

    response = requests.post("https://api.notegpt.io/api/youtube/transcribe", json=data, headers=headers)
    response.raise_for_status()
    result = response.json()

    if 'data' in result and result['data']:
        transcript = " ".join([seg["text"] for seg in result["data"]["segments"]])
        video_id = video_url.split("v=")[-1]
        with open(f"{video_id}.txt", "w") as f:
            f.write(transcript)
        print(f"Transcript saved to {video_id}.txt")
    else:
        print("❌ No transcript found!")

if __name__ == "__main__":
    fetch_transcript(sys.argv[1])
