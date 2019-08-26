$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.20.0.105/GeForce_Experience_v3.20.0.105.exe'
    checksum       = 'a17cf6ebf84af3be110cb046c45b1957e47a9482d1d1c5d58f6ba59f65c72aa3'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Host "If you experience errors after updating, you may need to reboot."
