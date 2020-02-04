$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/442.19/442.19-desktop-win10-64bit-international-whql.exe'
	checksum64     = '1b2c2791d686f3831cd0547b39e317d33831642d72fb7c6267e1a66bdf7bc008'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/442.19/442.19-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '52cc63e8e728e04f566acf776cd3974e161be78e4f9144fe0d1af05efea2d721'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/442.19/442.19-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'f9ba76fb80d409ce7359ad2f1a30d2bb588cbe8b8c1319c555aee974b6a380ab'
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
