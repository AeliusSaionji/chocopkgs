$packageName = 'lua54'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Remove from Machine PATH
$machinePath = Get-EnvironmentVariable -Name PATH -Scope Machine
if ( $machinePath.Contains($toolsDir) ) {
	$cleanMachinePath = $([Environment]::GetEnvironmentVariable("PATH",[EnvironmentVariableTarget]::Machine)).Replace("$toolsDir;",'')
	[Environment]::SetEnvironmentVariable("PATH", "$cleanMachinePath", [EnvironmentVariableTarget]::Machine)
}
# Remove from User PATH
$userPath = Get-EnvironmentVariable -Name 'PATH' -Scope User
if ( $userPath.Contains($toolsDir) ) {
	$cleanUserPath = $([Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)).Replace("$toolsDir;",'')
	 [Environment]::SetEnvironmentVariable("PATH", "$cleanUserPath", [EnvironmentVariableTarget]::User)
}
