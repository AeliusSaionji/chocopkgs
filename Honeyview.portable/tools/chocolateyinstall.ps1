$packageName = 'Honeyview.portable'
$url = 'http://ca-dl.bandisoft.com/honeyview/HONEYVIEW-PORTABLE.ZIP'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $toolsDir
