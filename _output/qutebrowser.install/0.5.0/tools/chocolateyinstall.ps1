$packageName = 'qutebrowser.install'
$installerType = 'msi'
$silentArgs = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
$validExitCodes = @(0, 3010, 1641)
$version = '0.5.0'
$url = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-win32.msi"
$url64 = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-amd64.msi"

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 $validExitCodes
