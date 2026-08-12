# setup_env.ps1
# Run this once to configure GreenCut credentials as persistent user environment variables.
# This file is gitignored - never commit credentials.

Write-Host ""
Write-Host "GreenCut - Environment Setup" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

$user = Read-Host "Admin username"

$securePass = Read-Host "Admin password" -AsSecureString
$pass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePass))

# Generate a random 40-char secret key
$chars  = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
$secret = -join (1..40 | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })

[System.Environment]::SetEnvironmentVariable("PHYSIO_ADMIN_USER", $user,   "User")
[System.Environment]::SetEnvironmentVariable("PHYSIO_ADMIN_PASS", $pass,   "User")
[System.Environment]::SetEnvironmentVariable("PHYSIO_SECRET_KEY", $secret, "User")

Write-Host ""
Write-Host "Done. Variables set as persistent user environment variables:" -ForegroundColor Green
Write-Host "  PHYSIO_ADMIN_USER = $user" -ForegroundColor Green
Write-Host "  PHYSIO_ADMIN_PASS = (hidden)" -ForegroundColor Green
Write-Host "  PHYSIO_SECRET_KEY = (generated)" -ForegroundColor Green
Write-Host ""
Write-Host "Restart your terminal before running the app." -ForegroundColor Yellow
