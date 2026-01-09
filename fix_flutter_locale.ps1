# Fix Flutter Locale Issue
# This file sets the correct Flutter storage URLs to prevent Chinese/Japanese text

# Set international Flutter storage URLs
$env:FLUTTER_STORAGE_BASE_URL = "https://storage.googleapis.com"
$env:PUB_HOSTED_URL = "https://pub.dev"

Write-Host "Flutter storage URLs set to international mirrors"
Write-Host "FLUTTER_STORAGE_BASE_URL: $env:FLUTTER_STORAGE_BASE_URL"
Write-Host "PUB_HOSTED_URL: $env:PUB_HOSTED_URL"
Write-Host ""
Write-Host "Now run: flutter clean && flutter pub get"
