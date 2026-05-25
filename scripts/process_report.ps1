Get-Process |
Sort-Object CPU -Descending | 
Select-Object -First 10 Name, CPU, WorkingSet, 
    @{Name="Timestamp";Expression={Get-Date}},
    @{Name="Username";Expression={$env:USERNAME}},
    @{Name="ComputerName";Expression={$env:COMPUTERNAME}} |
Export-Csv top_processes2.csv -NoTypeInformation 

Write-Host "Process report generated."

