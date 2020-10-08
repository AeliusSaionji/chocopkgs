$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/456.71/456.71-desktop-win10-64bit-international-whql.exe'
	checksum64     = '570fd1dd03fca65644ca555b0a988752e1a71e5edb8502e80dedc925637ea6df'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/456.71/456.71-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'b6337c7a81beb07a111030755462bd7c860a53bdad39c40887429ef9e5dac90a'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/456.71/456.71-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '9efa5d638bd9f8620af5219aa39002ffa2a07fcde2b5560dfb57de544e33ccf2'
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
