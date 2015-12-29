$packageName = 'qutebrowser.install'
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$version = '{{PackageVersion}}'
$url = "https://github.com/The-Compiler/qutebrowser/releases/download/v0.4.1/qutebrowser-$version-win32.msi"
$url64 = "https://github.com/The-Compiler/qutebrowser/releases/download/v0.4.1/qutebrowser-$version-amd64.msi"

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64
