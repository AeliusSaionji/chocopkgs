$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName      = 'hwinfo.portable'
  file             = "$toolsDir\hwi.zip"
  file64           = "$file"
  Destination      = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

# create empty sidecar so shimgen creates shim for GUI rather than console
Set-Content -Path (Join-Path -Path $toolsDir -ChildPath "HWiNFO32.exe.gui") `
            -Value $null
Set-Content -Path (Join-Path -Path $toolsDir -ChildPath "HWiNFO64.exe.gui") `
            -Value $null

Remove-Item -force "$toolsDir\*.zip" -ea 0
