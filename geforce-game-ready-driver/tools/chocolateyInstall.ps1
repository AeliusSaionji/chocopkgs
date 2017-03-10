$packageName = 'geforce-game-ready-driver'
$version = '{{PackageVersion}}'
$fileType = 'exe'
$silentArgs = '-s -noreboot -clean'
$url   = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-32bit-international-whql.exe"
$url64 = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-64bit-international-whql.exe"
$checksum   = '34f6edbfca3cbe70dc83589bfae339437658b2b8c291a9fc278aee0c7cabf6d495ebfb64dff8da3dc6966409ce2857a911c6a39d489c3c6b9fb5597075e04361'
$checksum64 = '753e7023b6ea7dd451cc1ac639d838f6f137a4153e88d6051d8217d69be631f007e90c3a672e795e31abf8a930927a7376eeca7da5852c4cf8de522f51a0fc73'
$checksumType = 'SHA512'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-32bit-international-whql.exe"
	$url64 = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql.exe"
	$checksum   = '2f81b0778d65436708369c3283ca37fa72825eb12c512c22e92362efbf47fa0a17b4d7c86bba289b12007c5c781b33e8a9d1ae891c62c8b2a7913272ffcdd46f'
	$checksum64 = 'd1883e733fa15ba43b76475cb9829bc8fb5edc2fb7efed49e24b3fc206b474f209f0a6b49f4e22a197c3b3c1f0e3f959b2649b394fdf0d6d4e68dafd0d4a8f00'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
