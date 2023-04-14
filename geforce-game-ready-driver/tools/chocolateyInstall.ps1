$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'geforce-game-ready-driver'
  fileType       = 'EXE'
  url64          = 'https://us.download.nvidia.com/Windows/531.61/531.61-desktop-win10-win11-64bit-international-dch-whql.exe'
  checksum64     = 'd0694a9dc6c56840618470908ff5eddb2acf87228c5cc418d7736b7ffaa13bf4'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/474.30/474.30-desktop-win8-win7-64bit-international-whql.exe'
  $packageArgs['checksum64'] = '1350f6159ea9c9a4cf796edf1dab39f4d5ff7b5f66f34b17b4b5b53dffce5685'
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
  Write-Warning "NVIDIA has ended support for 32bit operating systems."
  Write-Warning "32 bit users should specify version 391.35."
  Write-Warning "Security patches for 32bit may be available on geforce.com"
  Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
