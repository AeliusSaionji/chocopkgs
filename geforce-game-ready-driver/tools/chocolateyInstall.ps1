$packageName = 'geforce-game-ready-driver'
$version = '{{PackageVersion}}'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-32bit-international-whql.exe"
$url64 = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-64bit-international-whql.exe"
$checksum   = '6eaf363ec5dc4b00b2c72c5edbeed19a63670dfed534880db1b50d9c65fbf4b1ab2263165e215b8c6c5fbfbc62b158f12e0817ee8dd9bbccb7b67f71996ca94d'
$checksum64 = 'c52afab044d1e2eac773b81986d49cac70406de02cb9799994817530d6a5b8b002befb936de19dd019ccd993304542943e24b753c347b8bf0eb3f66c17b4f9b2'
$checksumType = 'SHA512'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-32bit-international-whql.exe"
	$url64 = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql.exe"
	$checksum   = '0d4c84e81df01be199fb17cc437b4fb7a3aa6a5937bac6932f142586018e005acfabc8d4a9edc1848693fe441dfa8691bdb426dcd9a910dfbf04b0f895d9d4ca'
	$checksum64 = '87942fe5b7c71ad379cf9815ee321e47759554e043fdbd119158116d40d1713672139754582fc42d73eb2cc61755db84ca9022de922adc3f5a712daff50f2f8c'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
