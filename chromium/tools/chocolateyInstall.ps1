$ErrorActionPreference = 'Stop'

$version = '62.0.3198.0'

$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
$hive = "hkcu"
$Chromium = $hive + ":" + $chromium_string

if (Test-Path $Chromium) {
  $silentArgs = '--do-not-launch-chrome'
} else {
  $silentArgs = '--system-level --do-not-launch-chrome'
}

$packageArgs = @{
  packageName   = 'chromium'
  fileType      = 'exe'
  url           = 'https://github.com/henrypp/chromium/releases/download/v60.0.3112.113-r474897-win32/chromium-sync.exe'
  url64bit      = 'https://github.com/henrypp/chromium/releases/download/v60.0.3112.113-r474897-win64/chromium-sync.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '47601af968aed6fe69b3c30d4a1e34b59f979b0f13ef79f73244ee8ea7bb8a7d'
  checksumType  = 'sha256'
  checksum64    = '8e2d6e980068e0b8b6c1492ebc1128f7a06eeb68dfc2f86e0e8a87736c942d48'
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs
