$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/441.87/441.87-desktop-win10-64bit-international-whql.exe'
	checksum64     = '3cdb5ce5176ab0dc0d7af95a1cb9f4336da09aae77537e44563ffd46285dda7a'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/441.87/441.87-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '987cbe1a56e97d799d68f2429119ffeb0bce18397a8e366d23d27d15b97a6cc3'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/441.87/441.87-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'a465be71e165a8df57eb94de2497dbc6f65e39234c2776a5df02858707369ae4'
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
