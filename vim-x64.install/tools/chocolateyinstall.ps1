$packageName = 'vim-x64'
$fileType = 'exe'
$silentArgs = '/S'
$version = '{{PackageVersion}}'
$url = "https://bintray.com/artifact/download/veegee/generic/vim${version}_x64.exe"
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'

# An uninstaller that doesn't accept arguments will run if this key exists
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4' -Force -ErrorAction "SilentlyContinue"
# Manual uninstall
# Explorer handle prevents removal, reboot explorer
Get-Process | Where { $_.name -eq 'explorer'      } | Stop-Process -Force
Get-Process | Where { $_.name -eq 'FreeCommander' } | Stop-Process -Force
Remove-Item -Path "$ENV:ProgramFiles\Vim" -Force -Recurse

Install-ChocolateyPackage $packageName $fileType $silentArgs $url -checksum $checksum -checksumType $checksumType
