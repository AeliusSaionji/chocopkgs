$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'geforce-game-ready-driver'
  fileType       = 'EXE'
  url64          = 'https://us.download.nvidia.com/Windows/472.12/472.12-desktop-win10-win11-64bit-international-whql.exe'
  checksum64     = '95d8dc470e8f1352b4dbc3b38aefeb5cbbba024826a0541a9f88501b642d81d3'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/473.62/473.62-desktop-win8-win7-64bit-international-whql.exe'
  $packageArgs['checksum64'] = '31e6c3aa31c6b5263f79d8ff37f485747d60c681e16f88b362145dd03fa38356'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
  $packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/516.40/516.40-desktop-win10-win11-64bit-international-dch-whql.exe'
  $packageArgsDCHChecksum = 'dec17bcbd76113ce2c24dc95bc0904613f50925cc17ea0eee2c3471ad8454397'
  $packageArgs['url64']      = $packageArgsDCHURL
  $packageArgs['checksum64'] = $packageArgsDCHChecksum
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
  Write-Warning "NVIDIA has ended support for 32bit operating systems."
  Write-Warning "32 bit users should specify version 391.35."
  Write-Warning "Security patches for 32bit may be available on geforce.com"
  Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
Write-Host "Nvidia website is funneling users towards the DCH download of their drivers. DCH is a new driver format, Win10+Win11 users should consider using the chocolatey package parameter to install the DCH version. See this package's page on chocolatey for details."
