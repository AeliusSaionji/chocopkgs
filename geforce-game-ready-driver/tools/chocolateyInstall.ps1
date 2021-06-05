$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/466.63/466.63-desktop-win10-64bit-international-whql.exe'
	checksum64     = 'e26ba2275426bd71016a8c74963fc974fbf3966a710d40b59394b58143ca5dbc'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/466.63/466.63-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = '792c70c26041d6ff1da7cdd68cf0ae74ccbe81378c0e33aa1d65ebc9167b1035'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/466.63/466.63-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = 'f317e06f4ea4f2d21b72486e5340a000bc496515f525892608615ded788cc595'
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
