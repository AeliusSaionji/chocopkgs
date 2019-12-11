$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/441.66/441.66-desktop-win10-64bit-international-whql.exe'
	checksum64     = '8432b0f571141fbc648872b94e31661baec8e9066603e4d53288eab91ac14aaf'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/441.66/441.66-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '52f3dc1c4b3e64abb2f452d14b5f411d5562ca056e60774dd2d901ed32cea41f'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/441.66/441.66-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '5f8b96f40a3a9d13273de0cbbf695f7220bddb4abeac67f180ce8a945a500f36'
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
