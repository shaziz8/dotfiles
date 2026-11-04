#!/usr/bin/env bash

# ytdl1080.sh - download a video in 1080p with aria2c, merge to mp4,
# embed one subtitle track, the thumbnail and metadata

# Take the first argument as the URL; default to empty if none was given
url="${1:-}"

# If no URL was passed, ask for one interactively (-r keeps backslashes literal)
if [[ -z "$url" ]]; then
    read -rp "Enter URL: " url
fi

# If it's still empty (user just pressed Enter), print an error to stderr and quit
[[ -z "$url" ]] && { echo "No URL given." >&2; exit 1; }

# yt-dlp options, kept in an array so each one can have a comment
opts=(
    # Use aria2c as the external downloader instead of yt-dlp's built-in one
    --downloader aria2c

    # aria2c settings: -x 16 = 16 connections per server,
    # -s 16 = split the file into 16 pieces, -k 1M = minimum piece size of 1 MB
    --downloader-args "aria2c:-x 16 -s 16 -k 1M"

    # Format selection, tried left to right (/ means "fall back to the next one"):
    #   1) 1080p mp4 video + m4a audio (merged)
    #   2) a single pre-merged 1080p mp4 file
    #   3) any 1080p video + any audio
    #   4) any single pre-merged 1080p file
    -f "bv*[height=1080][ext=mp4]+ba[ext=m4a]/b[height=1080][ext=mp4]/bv*[height=1080]+ba/b[height=1080]"

    # Container to use when video and audio are merged
    --merge-output-format mp4

    # Download manually uploaded subtitles, falling back to auto-generated ones
    --write-subs --write-auto-subs

    # Exactly one English track (plain "en" avoids duplicates like en-orig)
    --sub-langs "en"

    # Embed the downloaded subtitle into the video file
    --embed-subs

    # Convert the thumbnail to jpg (YouTube's webp can't go into mp4 directly)
    --convert-thumbnails jpg

    # Embed the thumbnail as cover art in the video file
    --embed-thumbnail

    # Embed title, uploader, date and description as file metadata
    --embed-metadata

    # Don't download a whole playlist if the URL is a video inside one
    --no-playlist
)

# Run yt-dlp with the options above; quoting "$url" protects characters like &
yt-dlp "${opts[@]}" "$url"
