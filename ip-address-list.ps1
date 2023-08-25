$computerList = Get-Content -Path "C:\computerlist.txt"  # Replace with the path to your computer list file

$computerInfo = @()

foreach ($computer in $computerList) {
    $ipAddress = $null

    try {
        $ipAddress = [System.Net.Dns]::GetHostAddresses($computer) |
                     Where-Object { $_.AddressFamily -eq 'InterNetwork' } |
                     Select-Object -ExpandProperty IPAddressToString -First 1
    } catch {
        # Ignore errors for unreachable computers
    }

    $computerInfo += [PSCustomObject]@{
        ComputerName = $computer
        IPAddress = $ipAddress
    }
}

$computerInfo | Format-Table -AutoSize
