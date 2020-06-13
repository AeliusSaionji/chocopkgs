$packageArgs = @{
  packageName    = 'antimicro.install'
  fileType       = 'msi'
  softwareName   = 'AntiMicro'
  silentArgs     = '/qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  url            = 'https://github.com/AntiMicro/antimicro/releases/download/2.23/antimicro-2.23-win32.msi'
  checksum       = '27817cc5c7673fc5e356db531325cfd0c95fa07b24d61c4f85363ae883627728'
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
