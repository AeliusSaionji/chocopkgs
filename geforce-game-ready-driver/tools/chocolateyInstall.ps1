$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/397.93/397.93-desktop-win10-64bit-international-whql.exe'
	checksum64     = '9fb7ccdeceb44ce4dd092a13f8f5b06361c6a9282a7d4adf122e0f6ce0dc4770'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/397.93/397.93-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '2a842d7c3345b4fc7fca0c6f719e4b7f9e479d2ccd776e83e70480e8db8d0842'
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
	Write-Warning "NVIDIA has ended support for 32bit operating systems."
	Write-Warning "32 bit users should specify version 391.35."
	Write-Warning "Security patches for 32bit may be available on geforce.com"
	Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
