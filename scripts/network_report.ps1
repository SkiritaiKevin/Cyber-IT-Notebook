$timestamp = Get-Date  
$username = $env:USERNAME 
$computerName = $env:COMPUTERNAME 

Get-NetTCPConnection | 
Where-Object { $_.State -eq "Established" } |
Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, 
@{Name="Timestamp";Expression={$timestamp}},
@{Name="Username";Expression={$username}},
@{Name="ComputerName";Expression={$computerName}} |
Export-Csv active_tcp_connections.csv -NoTypeInformation 

Get-NetTCPConnection |
Where-Object { $_.State -eq "Listen" } |
Select-Object LocalAddress, LocalPort, State,
@{Name="Timestamp";Expression={$timestamp}},
@{Name="Username";Expression={$username}},
@{Name="ComputerName";Expression={$computerName}} |
Export-Csv listening_ports.csv -NoTypeInformation

Get-NetIPAddress |
Select-Object IPAddress, InterfaceAlias, AddressFamily, PrefixLength,
@{Name="Timestamp";Expression={$timestamp}},
@{Name="Username";Expression={$username}},
@{Name="ComputerName";Expression={$computerName}} |
Export-Csv local_ip_info.csv -NoTypeInformation

Write-Host "Network reports generated."