$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/446.14/446.14-desktop-win10-64bit-international-whql.exe'
	checksum64     = '09a5d43131326fd2b188a3438c5fc54ca1e78f4fa428186f1acbc1ac87267d62'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/446.14/446.14-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'e2b72e1c83d0db7e0419149a82388e923823b079b51a17f7b2e7d3a1677b404c'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/446.14/446.14-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '4c18ec7988153623fc1cc59ef235748d51293b5cd3d36e5931cfc3f46cc0f532'
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
