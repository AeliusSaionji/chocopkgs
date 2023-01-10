$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'antimicro.install'
  fileType       = 'msi'
  url64          = 'https://github.com/AntiMicro/antimicro/releases/download/2.24-final/antimicro-2.24-win64.msi'
  checksum64     = '6ed60e839281f6802dbbd2221079dcd9cd0562513f4124e8c431ab7a6e8d9af2'
  checksumType64 = 'sha256'
  silentArgs     = '/qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'AntiMicro'
}

Install-ChocolateyPackage @packageArgs
