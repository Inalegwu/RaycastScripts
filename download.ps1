#!/usr/bin/env powershell

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Download Best Video (Smart)
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📺
# @raycast.packageName Media Tools
# @raycast.argument1 { "type": "text", "placeholder": "URL (Leave blank to use clipboard)", "optional": true }

# Force stdout to flush immediately for real-time tracking in Raycast
$OutputEncoding = [System.Text.Encoding]::UTF8

$env:PATH += ";$env:USERPROFILE\.deno\bin"

# Prioritize the Raycast input field argument, fallback to clipboard
if ($args) {
    $url = $args
} else {
    $url = Get-Clipboard -Raw
}

# Trim whitespace
if ($url) { $url = $url.Trim() }

# If both are empty or invalid, fail and instruct the user
if (-not $url -or $url -notmatch "^https?://") {
    Write-Output "Error: Clipboard empty. Please paste a URL in the text box."
    Exit 1
}

# Set download directory to your Windows Downloads folder
$downloadsFolder = "$env:USERPROFILE\Downloads"
Set-Location $downloadsFolder

Write-Output "Initializing dlp download..."
Write-Output "Saving to: $downloadsFolder"
Write-Output "----------------------------------------"

# Call your custom binary name
& dlp $url

# Check if the download succeeded
if ($LASTEXITCODE -eq 0) {
    Write-Output "----------------------------------------"
    Write-Output "Download complete! 🎉"
} else {
    Write-Output "----------------------------------------"
    Write-Output "Download failed. Check the URL or connection."
}
