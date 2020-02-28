$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/442.50/442.50-desktop-win10-64bit-international-whql.exe'
	checksum64     = '259f996b74c0f9aa5bb3cc7cac2908cf7a8d35fabb93903cc595a170d571f11d'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/442.50/442.50-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '81d8544106636609fc086c991f711848bf1e88b6699f83ec247e124d9981372d'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/442.50/442.50-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'b3c2300b27c1ee36b029c20d71c5761355e86760bcc6f94aff1f03f0f9f42306'
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
