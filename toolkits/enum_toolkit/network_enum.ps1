$Timestamp = Get-Date 
$Hostname = $env:COMPUTERNAME 

#Active TCP Connections 
Get-NetTCPConnection | 
Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess, 
    @{Name="Timestamp";Expression={$Timestamp}}, 
    @{Name="Hostname";Expression={$Hostname}} | 
Export-Csv activeTCPconnections_enum.csv -NoTypeInformation 

# Listening Ports
Get-NetTCPConnection |
Where-Object {$_.State -eq "Listen"} |
Select-Object LocalAddress, LocalPort, State, OwningProcess,
    @{Name="Timestamp";Expression={$Timestamp}},
    @{Name="Hostname";Expression={$Hostname}} |
Export-Csv listeningPorts_enum.csv -NoTypeInformation

# Local IP Addresses
Get-NetIPAddress |
Where-Object {$_.AddressFamily -eq "IPv4"} |
Select-Object InterfaceAlias, IPAddress, PrefixLength, AddressFamily,
    @{Name="Timestamp";Expression={$Timestamp}},
    @{Name="Hostname";Expression={$Hostname}} |
Export-Csv localIPaddresses_enum.csv -NoTypeInformation

# DNS Servers
Get-DnsClientServerAddress |
Select-Object InterfaceAlias, AddressFamily, ServerAddresses,
    @{Name="Timestamp";Expression={$Timestamp}},
    @{Name="Hostname";Expression={$Hostname}} |
Export-Csv dnsServers_enum.csv -NoTypeInformation

# Routing Table
Get-NetRoute |
Select-Object DestinationPrefix, NextHop, RouteMetric, InterfaceAlias, AddressFamily,
    @{Name="Timestamp";Expression={$Timestamp}},
    @{Name="Hostname";Expression={$Hostname}} |
Export-Csv routingTable_enum.csv -NoTypeInformation