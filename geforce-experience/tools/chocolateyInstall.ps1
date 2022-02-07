$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.25.0.84/GeForce_Experience_v3.25.0.84.exe'
    checksum       = '9a33cee0b5ea0e48547d21c38d9be0281adbff8af4bc905451e64ac741e189bb'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Host "If you experience errors after updating, you may need to reboot."
