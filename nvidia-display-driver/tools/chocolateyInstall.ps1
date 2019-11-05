$instDir    = "${ENV:TEMP}\nvidiainstall" # Folder to move desired components into
$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'nvidia-display-driver'
	destination    = "${ENV:TEMP}\nvidiadriver" # Folder to extract drivers
	url64          = 'https://us.download.nvidia.com/Windows/441.12/441.12-desktop-win10-64bit-international-whql.exe'
	checksum64     = '0a41e62b9b104b3a1a77b8b5a7831a5e048dc46ac0f186cd251e26345baae683'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/441.12/441.12-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '61fde900af5ce7cef984207724d7ad05f2ff82a93d5cc5beda0339681fa5a12a'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/441.12/441.12-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '311a3bad122e83d2376eeb36f07c934e6ba46681ad3e06bb91b54be74db29211'
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
if ( $pp.NV3DVision ) {
  Move-Item ($packageArgs['destination'] + "\NV3DVision"          ) -Destination "$instDir"
  Move-Item ($packageArgs['destination'] + "\NV3DVisionUSB.Driver") -Destination "$instDir"
}
if ( $pp.HDAudio ) {
  Move-Item ($packageArgs['destination'] + "\HDAudio"             ) -Destination "$instDir"
}

# Remove unused files
Remove-Item ($packageArgs['destination']) -Recurse -Force

# Finally, install
$packageArgs['file'    ] = "$instDir\setup.exe"
$packageArgs['fileType'] = 'EXE'
Install-ChocolateyInstallPackage @packageArgs
