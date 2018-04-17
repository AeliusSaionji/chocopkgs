$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName = 'mpv.install'
    file        = gi $toolsDir\*_x32.7z
    file64      = gi $toolsDir\*_x64.7z
    destination = "$toolsDir"
}

Get-ChocolateyUnzip @packageArgs

# mpv can't be shimmed, the shim doesn't work with mpv.com
# as of 2016.01.18, there is a dll dependency, so mpv can't be hardlinked to chocolatey\bin
# adding to PATH until chocolatey implements a /usr/lib equivalent
$pathType = 'User'
If ( Test-ProcessAdminRights ) { $pathType = 'Machine' }
Install-ChocolateyPath $toolsDir $pathType