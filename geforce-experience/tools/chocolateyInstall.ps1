$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.14.0.139/GeForce_Experience_v3.14.0.139.exe'
    checksum       = 'bc1cf1c63d2f95b277d590f58982726591c5fe970af308d6989e6e01cb27a491'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Output "If you experience errors after updating, you may need to reboot."
