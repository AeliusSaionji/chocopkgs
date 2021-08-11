$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/471.68/471.68-desktop-win10-win11-64bit-international-whql.exe'
	checksum64     = '0fc8734cba65aee0ad1d2e4b45e766944235f6397885c4b33a7f82970183fd02'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/471.68/471.68-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '4a38be118ec485d0beb8612c1e1df9bc1171eeb6fb33184c7ed080d0eca3ccbf'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/471.68/471.68-desktop-win10-win11-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '3a2ccb2fed66e2a831ab12e73deef4fe072f59a6166abcf48524310e84d9b91e'
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
Write-Host "Nvidia website is funneling users towards the DCH download of their drivers. DCH is a new driver format, Win10 users should consider using the chocolatey package parameter to install the DCH version. See this package's page on chocolatey for details."
