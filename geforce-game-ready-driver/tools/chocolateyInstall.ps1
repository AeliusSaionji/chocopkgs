$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = 'https://us.download.nvidia.com/Windows/385.28/385.28-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/385.28/385.28-desktop-win10-64bit-international-whql.exe'
$checksum   = '1f0f4914dc19fae732790c8aa2056ea9d9bec2758dcf6ee82b621bab6ae3e957'
$checksum64 = 'cdfc6aa769242cb84cb2d1e7759ff3024b6645d6d64e3ec21ab56ca40acc0701'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/385.28/385.28-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/385.28/385.28-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '2385568cde963f1775563120db6318504da22de599b0b5b2a4b3ad2904ec6dec'
	$checksum64 = '2d5ef1ec5e8791557906049f3620750992c2df2317a388d6f9ccf99198197665'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
