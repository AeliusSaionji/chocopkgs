$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.15.0.186/GeForce_Experience_v3.15.0.186.exe'
    checksum       = 'ebb5d145121dbb644895d14b0dfd748b8927b1f32eb4e0acdf8c8b923a73cb4c'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Output "If you experience errors after updating, you may need to reboot."
