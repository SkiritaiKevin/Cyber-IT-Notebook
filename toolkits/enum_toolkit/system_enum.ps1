$Timestamp = Get-Date
$Hostname = $env:COMPUTERNAME
$LoggedInUser = whoami

# System Info: hostname, OS version, uptime, logged-in user
$OS = Get-CimInstance Win32_OperatingSystem
$Uptime = (Get-Date) - $OS.LastBootUpTime

[PSCustomObject]@{
    Timestamp    = $Timestamp
    Hostname     = $Hostname
    OSVersion    = $OS.Caption
    OSBuild      = $OS.BuildNumber
    LastBootTime = $OS.LastBootUpTime
    Uptime       = "$($Uptime.Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"
    LoggedInUser = $LoggedInUser
} | Export-Csv systemInfo_enum.csv -NoTypeInformation


# Running Services
Get-Service |
Where-Object {$_.Status -eq "Running"} |
Select-Object Name, DisplayName, Status,
    @{Name="Timestamp";Expression={$Timestamp}},
    @{Name="Hostname";Expression={$Hostname}} |
Export-Csv runningServices_enum.csv -NoTypeInformation


# Local Administrators
Get-LocalGroupMember -Group "Administrators" |
Select-Object Name, ObjectClass, PrincipalSource,
    @{Name="Timestamp";Expression={$Timestamp}},
    @{Name="Hostname";Expression={$Hostname}} |
Export-Csv localAdmins_enum.csv -NoTypeInformation