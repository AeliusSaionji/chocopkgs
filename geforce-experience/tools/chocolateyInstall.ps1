$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.18.0.102/GeForce_Experience_v3.18.0.102.exe'
    checksum       = '457edd5becd4dc6c9f1c83382e7a8dbafd12c1ae1aa85bef4aed7008107a9758'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Output "If you experience errors after updating, you may need to reboot."
