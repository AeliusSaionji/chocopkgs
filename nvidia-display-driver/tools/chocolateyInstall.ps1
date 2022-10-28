$instDir    = "${ENV:TEMP}\nvidiainstall" # Folder to move desired components into
$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'nvidia-display-driver'
  destination    = "${ENV:TEMP}\nvidiadriver" # Folder to extract drivers
  url64          = 'https://us.download.nvidia.com/Windows/526.47/526.47-desktop-win10-win11-64bit-international-dch-whql.exe'
  checksum64     = 'f5b3cda5f1d7e7f7784678416cae0faf2bbbaecec372c0678efc5b36f7c3da4e'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/473.81/473.81-desktop-win8-win7-64bit-international-whql.exe'
  $packageArgs['checksum64'] = '577c0f93857b807eb719f96bec0c82b797995a023bc80c7f0f306503fd83c4e5'
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
New-Item -Path "$instDir\GFExperience" -ItemType Directory

# Download driver package as a zip
$packageArgs['file'] = "${ENV:TEMP}\nvidiadriver.zip"
Get-ChocolateyWebFile @packageArgs

# Unzip driver package
Get-ChocolateyUnzip @packageArgs

# Move everything we want to a new folder
Move-Item ($packageArgs['destination'] + "\Display.Driver"        ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\Display.Optimus"       ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\NVI2"                  ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\PhysX"                 ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\EULA.txt"              ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\ListDevices.txt"       ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\setup.cfg"             ) -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\setup.exe"             ) -Destination "$instDir"
# Must include these legal files to satisfy the installer. GFE will not be installed.
Move-Item ($packageArgs['destination'] + "\GFExperience\PrivacyPolicy"      ) -Destination "$instDir\GFExperience"
Move-Item ($packageArgs['destination'] + "\GFExperience\EULA.html"          ) -Destination "$instDir\GFExperience"
Move-Item ($packageArgs['destination'] + "\GFExperience\FunctionalConsent_*") -Destination "$instDir\GFExperience"
# I've changed my mind about not including the audio and USB-C driver by default.
Move-Item ($packageArgs['destination'] + "\HDAudio") -Destination "$instDir"
Move-Item ($packageArgs['destination'] + "\PPC"    ) -Destination "$instDir" -ErrorAction SilentlyContinue
if ( $pp.NV3DVision ) {
  Move-Item ($packageArgs['destination'] + "\NV3DVision"          ) -Destination "$instDir"
  Move-Item ($packageArgs['destination'] + "\NV3DVisionUSB.Driver") -Destination "$instDir"
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

# Remove unused files
Remove-Item ($packageArgs['destination']) -Recurse -Force

# Finally, install
$packageArgs['file'    ] = "$instDir\setup.exe"
$packageArgs['fileType'] = 'EXE'
Install-ChocolateyInstallPackage @packageArgs

