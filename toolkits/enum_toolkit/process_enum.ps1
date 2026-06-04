$Timestamp = Get-Date
$Hostname = $env:COMPUTERNAME
$ProcessCount = (Get-Process).Count
$PowerShellProcesses = Get-Process powershell, pwsh -ErrorAction SilentlyContinue
$PowerShellProcessCount = $PowerShellProcesses.Count

Get-Process | 
Sort-Object CPU -Descending | 
Select-Object  Name, Id, CPU, WorkingSet,
    @{Name="Timestamp";Expression={$Timestamp}}, 
    @{Name="Hostname";Expression={$Hostname}},
    @{Name="TotalProcessCount";Expression={$ProcessCount}},
    @{Name="RunningPowerShellProcesses";Expression={$PowerShellProcessCount}} |
Export-Csv topCPUprocesses_enum.csv -NoTypeInformation

Get-Process | 
Sort-Object WorkingSet -Descending | 
Select-Object  Name, Id, CPU, WorkingSet,
    @{Name="Timestamp";Expression={$Timestamp}}, 
    @{Name="Hostname";Expression={$Hostname}},
    @{Name="TotalProcessCount";Expression={$ProcessCount}},
    @{Name="RunningPowerShellProcesses";Expression={$PowerShellProcessCount}} |
Export-Csv topRAMprocesses_enum.csv -NoTypeInformation