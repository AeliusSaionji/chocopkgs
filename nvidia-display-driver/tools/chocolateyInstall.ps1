$instDir    = "${ENV:TEMP}\nvidiainstall" # Folder to move desired components into
$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'nvidia-display-driver'
  destination    = "${ENV:TEMP}\nvidiadriver" # Folder to extract drivers
  url64          = 'https://us.download.nvidia.com/Windows/460.79/460.79-desktop-win10-64bit-international-whql.exe'
  checksum64     = '5619b896e98dc7ec62c5f5bd8885fec0c8d259a5213e21d262d8bca903da6cc1'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/460.79/460.79-desktop-win8-win7-64bit-international-whql.exe'
  $packageArgs['checksum64'] = '76ce0d9a9b6c1ba9dc6b1bbebd4978852f5a0231c592ea55ec5a301eab38dbd9'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
  $packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/460.79/460.79-desktop-win10-64bit-international-dch-whql.exe'
  $packageArgsDCHChecksum = '5dd20c22eddd85599b2077783183de39c34bfc23e9b86d3323b30f3336b27889'
  $packageArgs['url64']      = $packageArgsDCHURL
  $packageArgs['checksum64'] = $packageArgsDCHChecksum
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

# Remove unused files
Remove-Item ($packageArgs['destination']) -Recurse -Force

# Finally, install
$packageArgs['file'    ] = "$instDir\setup.exe"
$packageArgs['fileType'] = 'EXE'
Install-ChocolateyInstallPackage @packageArgs
