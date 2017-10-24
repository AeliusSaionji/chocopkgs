$packageName = 'VcXsrv'
$installerType = 'exe'
$silentArgs = '/S'
$version = '1.19.3.1'
$url = "https://sourceforge.net/projects/vcxsrv/files/vcxsrv/${version}/vcxsrv.${version}.installer.exe/download"
$url64 = "https://sourceforge.net/projects/vcxsrv/files/vcxsrv/${version}/vcxsrv-64.${version}.installer.exe/download"
$checksum = 'da89830fb4a62b414e930b3a8f080c9feb6b6c3d4e859fdf9ecb62404eed940709b588bcb1ae6e8243bead7f5f202ddad9c5de9609006c6b8db2bf84e48a95db'
$checksum64 = '0af7c37e5fcd878642c2b1880c443e412fa890c3c9d056f23fa8fc82e2a63eeb87a741dfc64e693f1162480ebb58a0d948f68173c0bbcc8997434f3db6521965'
$checksumType = 'SHA512'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
