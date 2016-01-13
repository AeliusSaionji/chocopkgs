$packageName = 'ioquake3-data'
$version = '1.36'
$url = "http://ioquake3.org/files/1.36/data/ioquake3-q3a-1.32-1.x86.exe"
$checksum = '3829740942f12e3e6102ea864643aa0d'
$checksumType  = 'md5'
$fileType = 'EXE'
$silentArgs = '/S' # NSIS
$validExitCodes= @(0)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType

# Find ioquake3 folder
$local_key     = 'HKCU:\Software\*'
$machine_key   = 'HKLM:\SOFTWARE\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\*'
Get-ItemProperty -Path @($machine_key6432,$machine_key, $local_key) `
	-ErrorAction SilentlyContinue `
	| ? { $_.PSChildName -like "ioquake3" } `
	| ForEach-Object { `
	$baseq3Dir = Join-Path $_.Install_Dir "baseq3" ; `
	$missionDir = Join-Path $_.Install_Dir "missionpack" }

# Find pak0 from existing Steam quake3 installation
$local_key_steam     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key_steam   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432_steam = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
Get-ItemProperty -Path @($machine_key6432_steam,$machine_key_steam, $local_key_steam) `
	-ErrorAction SilentlyContinue `
	| ? { $_.DisplayName -like "Quake III Arena" } `
	| ForEach-Object { if (($_.InstallLocation -ne $null) -and ($_.InstallLocation -ne '')) { `
	$pakPath = Join-Path $_.InstallLocation "baseq3\pak0.pk3" ; ` 
	$pakTAPath = Join-Path $_.InstallLocation "missionpack\pak0.pk3" }}
if ( $pakPath -ne $null ) { Copy-Item $pakPath $baseq3Dir }
if ( $packTAPath -ne $null ) { Copy-Item $pakTAPath $missionDir }

# Find pak0 from existing GOG quake3 installation
$local_key_gog     = 'HKCU:\Software\GOG.com\Games\*'
$machine_key_gog   = 'HKLM:\SOFTWARE\GOG.com\Games\*'
$machine_key6432_gog = 'HKLM:\SOFTWARE\Wow6432Node\GOG.com\Games\*'
Get-ItemProperty -Path @($machine_key6432_gog,$machine_key_gog, $local_key_gog) `
	-ErrorAction SilentlyContinue `
	| ? { $_.GAMENAME -like "Quake III Gold" } `
	| ForEach-Object { if (($_.PATH -ne $null) -and ($_.PATH -ne '')) { `
	$pakPath = Join-Path $_.PATH "baseq3\pak0.pk3" ;
	$pakTAPath = Join-Path $_.PATH "missionpack\pak0.pk3" }}
if ( $pakPath -ne $null ) { Copy-Item $pakPath $baseq3Dir }
if ( $packTAPath -ne $null ) { Copy-Item $pakTAPath $missionDir }
