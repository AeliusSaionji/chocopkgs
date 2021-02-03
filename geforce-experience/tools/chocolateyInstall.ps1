$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.21.0.36/GeForce_Experience_v3.21.0.36.exe'
    checksum       = '93d2aa73c0490fbd4e667d26faf133170c66e60e9687dcf88b8a6216b8c25690'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Host "If you experience errors after updating, you may need to reboot."
