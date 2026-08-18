#!/usr/bin/env powershell

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Download Best Video + Audio
# @raycast.mode silent
# @raycast.packageName Video Tools

# Optional parameters:
# @raycast.icon 📺
# @raycast.argument1 { "type": "text", "placeholder": "Paste video URL here" }

# Documentation:
# @raycast.author DisgruntledDev
# @raycast.description Downloads the absolute best video and audio quality using yt-dlp on Windows.

$url = $args[0]
$downloadFolder = "$env:USERPROFILE\Downloads"

# Open cmd.exe to run yt-dlp, show progress, and close automatically when done
Start-Process cmd.exe -ArgumentList "/c cd /d `"$downloadFolder`" && yt-dlp -f `"bestvideo+bestaudio/best`" --merge-output-format mkv `"$url`""

Write-Output "Downloading to your Downloads folder..."
