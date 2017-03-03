$packageName = 'mpv.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Remove from Machine PATH
$machinePath = [Environment]::GetEnvironmentVariable("PATH",[EnvironmentVariableTarget]::Machine)
if ( $machinePath.Contains($toolsDir) ) {
	$cleanMachinePath = $([Environment]::GetEnvironmentVariable("PATH",[EnvironmentVariableTarget]::Machine)).Replace("$toolsDir;",'')
	[Environment]::SetEnvironmentVariable("PATH", "$cleanMachinePath", [EnvironmentVariableTarget]::Machine)
}
# Remove from User PATH
$userPath = [Environment]::GetEnvironmentVariable("PATH",[EnvironmentVariableTarget]::User)
if ( $userPath.Contains($toolsDir) ) {
	$cleanUserPath = $([Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)).Replace("$toolsDir;",'')
	 [Environment]::SetEnvironmentVariable("PATH", "$cleanUserPath", [EnvironmentVariableTarget]::User)
}
	
Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-uninstall.bat /u" 'cmd.exe' -validExitCodes '0'
