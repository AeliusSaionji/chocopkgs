$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'geforce-game-ready-driver'
  fileType       = 'EXE'
  url64          = 'https://us.download.nvidia.com/Windows/555.99/555.99-desktop-win10-win11-64bit-international-dch-whql.exe'
  checksum64     = '769b637e2499f316f9b17b3f97cd344378f10bc8c6d14708b643d293a066edc5'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/475.06/475.06-desktop-win8-win7-64bit-international.exe'
  $packageArgs['checksum64'] = '3d7fc423f660f3e4af2c4c34b8d9ccf9d025b056ecb81d56e4a61fbc40d50447'
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
  Write-Warning "NVIDIA has ended support for 32bit operating systems."
  Write-Warning "32 bit users should specify version 391.35."
  Write-Warning "Security patches for 32bit may be available on geforce.com"
  Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
