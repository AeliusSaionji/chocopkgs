$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/441.20/441.20-desktop-win10-64bit-international-whql.exe'
	checksum64     = '696bafbb02d8459bb61f15891801701a917af4c9892f16db56e1d5a7b3b35e56'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/441.20/441.20-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'aa24f3f8ed7838eff3f9e11c582cfc53bf04891a7766021378adf36966c492a2'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/441.20/441.20-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '1a07047994e142f9458d4d258aeabbff1675d5507ee09d3b8d6c48b16220576f'
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
