# setup_env.ps1
# Run this once to configure PhysioOnWheels credentials as persistent user environment variables.
# This file is gitignored - never commit credentials.

Write-Host ""
Write-Host "GreenCut - Environment Setup" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan
Write-Host ""

$user = Read-Host "Admin username"

$securePass = Read-Host "Admin password" -AsSecureString
$pass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePass))

# Generate a random 40-char secret key
$chars  = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
$secret = -join (1..40 | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })

Write-Host ""
Write-Host "Stripe (optional — press Enter to skip)" -ForegroundColor Cyan
$stripeSecret = Read-Host "Stripe Secret Key (sk_live_... or sk_test_...)"
$stripePublic = Read-Host "Stripe Publishable Key (pk_live_... or pk_test_...)"

[System.Environment]::SetEnvironmentVariable("PHYSIO_ADMIN_USER",    $user,         "User")
[System.Environment]::SetEnvironmentVariable("PHYSIO_ADMIN_PASS",    $pass,         "User")
[System.Environment]::SetEnvironmentVariable("PHYSIO_SECRET_KEY",    $secret,       "User")
[System.Environment]::SetEnvironmentVariable("PHYSIO_STRIPE_SECRET_KEY", $stripeSecret, "User")
[System.Environment]::SetEnvironmentVariable("PHYSIO_STRIPE_PUBLIC_KEY", $stripePublic, "User")

Write-Host ""
Write-Host "Done. Variables set as persistent user environment variables:" -ForegroundColor Green
Write-Host "  PHYSIO_ADMIN_USER    = $user" -ForegroundColor Green
Write-Host "  PHYSIO_ADMIN_PASS    = (hidden)" -ForegroundColor Green
Write-Host "  PHYSIO_SECRET_KEY    = (generated)" -ForegroundColor Green
if ($stripeSecret) {
    Write-Host "  PHYSIO_STRIPE_SECRET = (set)" -ForegroundColor Green
    Write-Host "  PHYSIO_STRIPE_PUBLIC = (set)" -ForegroundColor Green
} else {
    Write-Host "  PHYSIO_STRIPE_SECRET = (skipped — demo mode)" -ForegroundColor Yellow
}
Write-Host ""
Write-Host "Restart your terminal before running the app." -ForegroundColor Yellow
