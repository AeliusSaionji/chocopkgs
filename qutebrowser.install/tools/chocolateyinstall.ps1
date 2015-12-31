$packageName = 'qutebrowser.install'
$installerType = 'msi'
$silentArgs = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
$validExitCodes = @(0, 3010, 1641)
$version = '{{PackageVersion}}'
$url = "https://github.com/The-Compiler/qutebrowser/releases/download/v0.4.1/qutebrowser-$version-win32.msi"
$url64 = "https://github.com/The-Compiler/qutebrowser/releases/download/v0.4.1/qutebrowser-$version-amd64.msi"

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 $validExitCodes
