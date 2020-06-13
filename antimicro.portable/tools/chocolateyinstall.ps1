$packageArgs = @{
  packageName   = 'antimicro.portable'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  url           = 'https://github.com/AntiMicro/antimicro/releases/download/2.23/antimicro-2.23-win32.portable.zip'
  checksum      = '5e180198ec6ae56648b0daa3f4e045d5543ca3bbbdd47a2277a2a814a298f74d'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
