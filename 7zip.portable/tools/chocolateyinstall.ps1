$packageName = '7zip.portable'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$versionMinusDots = '{{PackageVersion}}'.Replace(".","")
$url = "http://www.7-zip.org/a/7z$($versionMinusDots).exe"
$url64 = "http://www.7-zip.org/a/7z$($versionMinusDots)-x64.exe"
$extrasUrl = "http://www.7-zip.org/a/7z$($versionMinusDots)-extra.7z"

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
Install-ChocolateyZipPackage $packageName $extrasUrl $toolsDir

Remove-Item -Path "$toolsDir\Uninstall.exe"

if (Get-ProcessorBits 32) {
  # generate ignore for x64\7za.exe
  New-Item "$toolsDir\x64\7za.exe.ignore" -Type file -Force | Out-Null
} else {
  #generate ignore for 7za.exe and let x64 version pick up and shim
  New-Item "$toolsDir\7za.exe.ignore" -Type file -Force | Out-Null
}
