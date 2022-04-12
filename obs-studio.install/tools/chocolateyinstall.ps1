$ErrorActionPreference = 'Stop';

$url32      = 'https://github.com/obsproject/obs-studio/releases/download/27.2.4/OBS-Studio-27.2.4-Full-Installer-x86.exe'
$url64      = 'https://github.com/obsproject/obs-studio/releases/download/27.2.4/OBS-Studio-27.2.4-Full-Installer-x64.exe'
$checksum32 = 'c7ec7e2c8646b54872b299eeb16054f6b2050204bb2db1c6da78c3be4e24ab71'
$checksum64 = '4c7f82fd2ecc532cbdb7b279702b28b252a38bbc462c65086f53938cd8d4c43b'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url32
  url64bit      = $url64
  checksum      = $checksum32
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  softwareName  = 'OBS Studio'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
