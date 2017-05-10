$packageName = 'geforce-game-ready-driver'
$version = '{{PackageVersion}}'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$url   = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-32bit-international-whql.exe"
$url64 = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-64bit-international-whql.exe"
$checksum   = 'EF60B3246D57E58A28A8C78FC9B192C46B189B5E56E714E4C8302AE7F12B2381E342494770E5EBEC07C9C6F53DCFA0DD78DE2839F5B019535F153B1A6633EE8D'
$checksum64 = '6F3DAF20A9D29E6176F154C1E0A03230EA96114866D88DC8DF7B517EA8AFA3C58551C746E154D10C0CC55F02958AE7FC5E4DCDA5A14EC5FDB1E33FFF215211B0'
$checksumType = 'SHA512'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-32bit-international-whql.exe"
	$url64 = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql.exe"
	$checksum   = '2B1037E88205BEF588CEC5AFE73AD177BCFE3A7C26CD0955EA42B67173BEE7BC69A7F3DE4EA453E77D33D499FE666D5EADECA544D970F5A3AFB3BC113BFC7F0A'
	$checksum64 = '1A059C83E8980CAE434DD6FE5C38F163CB58EA4CF6CA4A851C38281BD0DEB55C2FBC3C43A5A723270F4A1B99B038FE0DCF3CBC0A65E7C468BC3A24229F1173E2'
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 `
-ValidExitCodes @(0,1)

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
