$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/471.41/471.41-desktop-win10-64bit-international-whql.exe'
	checksum64     = '476c6e64a68aa5c9f3ce2612413701aa46546c643550a9a45bff1c08c226dc28'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/471.41/471.41-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'db99207de731b4ad3395887d42fac21a58c8abd2983825443edad589ef488513'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/471.41/471.41-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'e0a6c5fad2a1476c8d9f1438c13111794b5d759a6efdec54bea3cf199cb1b91f'
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
