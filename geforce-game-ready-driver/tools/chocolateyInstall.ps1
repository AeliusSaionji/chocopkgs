$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/384.76/384.76-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/384.76/384.76-desktop-win10-64bit-international-whql.exe'
$checksum   = '62337adcd9286982464f362acbf64e8f84e02425882470ba69d584fb8476cf35'
$checksum64 = '0ce3cb326ccc1571ed7ca5cb6bf6a5d4cf95cc27158b15789463cd5d61f5ff02'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/384.76/384.76-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/384.76/384.76-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = 'ecf96dfd4075cf69ec9ae9e89da9cb213f281bdc70d50512a15433cd37ada5a8'
	$checksum64 = '0daf89c1fc636db5c31a7accef4feaacaba0935464af2272043dc9d5fe06e598'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
