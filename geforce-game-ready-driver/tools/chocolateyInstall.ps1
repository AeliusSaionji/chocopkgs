$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'geforce-game-ready-driver'
  fileType       = 'EXE'
  url64          = 'https://us.download.nvidia.com/Windows/471.96/471.96-desktop-win10-win11-64bit-international-whql.exe'
  checksum64     = 'a980394eaed79c936ce92a3bd90b071d2dd55ef4787ab565a77e9529b738c301'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/471.96/471.96-desktop-win8-win7-64bit-international-whql.exe'
  $packageArgs['checksum64'] = '2bdab4ac818631eb4e66289098539a97d8d274a64829df43520ccae20d731b59'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
  $packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/471.96/471.96-desktop-win10-win11-64bit-international-dch-whql.exe'
  $packageArgsDCHChecksum = '2815c7a78d27421768aa1694e8663f631fe916ca10f1efa4150be438e4df603c'
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
