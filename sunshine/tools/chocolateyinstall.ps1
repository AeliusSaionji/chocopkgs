$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file64Location = Get-Item $toolsDir\*_x64.zip
$destination = "$env:ProgramFiles\Sunshine"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $destination
  file64        = $file64Location
}

Stop-Service sunshinesvc -ea 0
Copy-Item "$destination\assets\apps_windows.json" "$destination\assets\apps.json.bak" -ea 0
Copy-Item "$destination\assets\sunshine.conf" "$destination\assets\sunshine.conf.bak" -ea 0
Install-ChocolateyZipPackage @packageArgs
Copy-Item "$destination\assets\apps_windows.json" "$destination\assets\apps.json.default" -ea 0
Copy-Item "$destination\assets\sunshine.conf" "$destination\assets\sunshine.conf.default" -ea 0
Copy-Item "$destination\assets\apps.json.bak" "$destination\assets\apps_windows.json" -ea 0
Copy-Item "$destination\assets\sunshine.conf.bak" "$destination\assets\sunshine.conf" -ea 0
Remove-Item $packageArgs.file64 -Force -ea 0

Start-Process -FilePath "$destination\install-service.bat" -NoNewWindow

Write-Host 'Sunshine can be configured at https://localhost:47990/ by default'
