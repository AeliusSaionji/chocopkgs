$pp = Get-PackageParameters
$instDir    = "${ENV:TEMP}\nvidiainstall" # Folder to move desired components into
$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'nvidia-display-driver'
  destination    = "${ENV:TEMP}\nvidiadriver" # Folder to extract drivers
  url64          = 'https://us.download.nvidia.com/Windows/572.70/572.70-desktop-win10-win11-64bit-international-dch-whql.exe'
  checksum64     = 'fd81090a6dfe9dfe44e6862f0e29688319e25d62f4d9220a71c2335fd7b708da'
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

# Remove any previous tempfiles
Remove-Item "$instDir" -Recurse -Force -ea 0
New-Item -Path "$instDir" -ItemType Directory

# Download driver package as a zip
$packageArgs['file'] = "${ENV:TEMP}\nvidiadriver.zip"
Get-ChocolateyWebFile @packageArgs

# Unzip driver package
Get-ChocolateyUnzip @packageArgs

# Move everything we want to a new folder
Move-Item ($packageArgs['destination'] + "\Display.Driver"        ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\NVApp"                 ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\NVI2"                  ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\NVPCF"                 ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\PhysX"                 ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\EULA.txt"              ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\ListDevices.txt"       ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\setup.cfg"             ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\setup.exe"             ) -Destination "$instDir"
# I've changed my mind about not including the audio and USB-C driver by default.
if ( -not $pp.NoAudio ) {
  Move-Item ($packageArgs['destination'] + "\HDAudio") -Destination "$instDir"
}
if ( -not $pp.NoUSBC ) {
  Move-Item ($packageArgs['destination'] + "\PPC"    ) -Destination "$instDir" -ErrorAction SilentlyContinue
}
if ( $pp.NV3DVision ) {
  Move-Item ($packageArgs['destination'] + "\NV3DVision"          ) -Destination "$instDir"
  Move-Item ($packageArgs['destination'] + "\NV3DVisionUSB.Driver") -Destination "$instDir"
}
if ( $pp.NVApp ) {
  Move-Item ($packageArgs['destination'] + "\NVApp.MessageBus"    ) -Destination "$instDir"
  Move-Item ($packageArgs['destination'] + "\NVCpl"               ) -Destination "$instDir"
}
# Misc new additions
if ( $pp.Nview ) {
  Move-Item ($packageArgs['destination'] + "\Display.Nview") -Destination "$instDir"
}
if ( $pp.ShadowPlay ) {
  Move-Item ($packageArgs['destination'] + "\ShadowPlay") -Destination "$instDir"
}
if ( $pp.FrameView ) {
  Move-Item ($packageArgs['destination'] + "\FrameViewSDK") -Destination "$instDir"
}
if ( $pp.MSVCRT ) {#MS VC Redist from 2019???
  Move-Item ($packageArgs['destination'] + "\MSVCRT") -Destination "$instDir"
}
if ( $pp.NvDLISR ) {
  Move-Item ($packageArgs['destination'] + "\NvDLISR") -Destination "$instDir"
}

# Remove unused files
Remove-Item ($packageArgs['destination']) -Recurse -Force

# Finally, install
$packageArgs['file'    ] = "$instDir\setup.exe"
$packageArgs['fileType'] = 'EXE'
Install-ChocolateyInstallPackage @packageArgs
