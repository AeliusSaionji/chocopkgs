$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/451.67/451.67-desktop-win10-64bit-international-whql.exe'
	checksum64     = '98389ba661f66f09a36662e932fd5a7ccb62918986c124b8dd780e62adb1f2af'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/451.67/451.67-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '06dbce208dbd269c4f12ab4534eef843b117ee2dfe8a4d7ec9e8b859b0433913'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/451.67/451.67-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'ca0a4efb3da40c01bd743c566ce1990e23c6b0ff206fcabf62acf4957ddb5c94'
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
