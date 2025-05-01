$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'geforce-game-ready-driver'
  fileType       = 'EXE'
  url64          = 'https://us.download.nvidia.com/Windows/576.28/576.28-desktop-win10-win11-64bit-international-dch-whql.exe'
  checksum64     = 'e35f884b4e0c832ac7de6d7a4006e3017ad23e17219f810e0f3d39598d6b36bc'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/475.14/475.14-desktop-win8-win7-64bit-international.exe'
  $packageArgs['checksum64'] = '8ecf71315de1258209043c56e39c2a260560bc05327920a3d6c1f91408b9c960'
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
  Write-Warning "NVIDIA has ended support for 32bit operating systems."
  Write-Warning "32 bit users should specify version 391.35."
  Write-Warning "Security patches for 32bit may be available on geforce.com"
  Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
