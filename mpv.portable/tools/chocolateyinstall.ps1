$packageName = 'mpv.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '2017.12.25'
$version = $version.Replace(".","")
$url = "https://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "https://mpv.srsfckn.biz/mpv-x86_64-$version.7z"
$checksum = '122AE8D1CE7E7F07AA594CA9F23B58A65B6D0574910692F2D8CB6811A4B0964838156F4E4858F896B49E8C563DA8DCEE06FF15EA0E4DEBF29149D83A2FE3D467'
$checksum64 = '2DF4D375C9F67F7A9EFD638AE04515060305930FFA07596985F9BF457A81936578C0FB4E7B3426DB45C8679D7B09651177CC4AC5DBAE25AA15E8FF2A3E07D9F3'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

# mpv can't be shimmed, the shim doesn't work with mpv.com
# as of 2016.01.18, there is a dll dependency, so mpv can't be hardlinked to chocolatey\bin
# adding to PATH until chocolatey implements a /usr/lib equivalent
$pathType = 'User'
If ( Test-ProcessAdminRights ) { $pathType = 'Machine' }
Install-ChocolateyPath $toolsDir $pathType
