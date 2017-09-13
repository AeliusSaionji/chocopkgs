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
  url           = 'https://github.com/henrypp/chromium/releases/download/v61.0.3163.79-r488528-win32/chromium-sync.exe'
  url64bit      = 'https://github.com/henrypp/chromium/releases/download/v61.0.3163.79-r488528-win64/chromium-sync.exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
  checksum      = '3d3b8cb05cfb55a0fc62ed1880b1fc6ea47246ded538ed47ed2b357c8230b41f'
  checksumType  = 'sha256'
  checksum64    = 'c18f22b3547d88ca4fd31bf1a505258b1235e2e698dd9c213a737585e07fb0f2'
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs
