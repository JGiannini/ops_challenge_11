<#

Title: Automated Endpoint Configuration 
Author: Jamie Giannini

Objectives:
[X] Enable file and printer sharing
[X] Allow ICMP traffic
[X] Enable Remote management
[X] Remove bloatware
[X] Enable Hyper-V
[X] Disable SMBv1, an insecure protcol

#>

#Enable file and printer sharing
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True

#Enable ICMP
netsh advfirewall firewall add rule name="Allow incoming ping requests IPv4" dir=in action=allow protocol=icmpv4

#Enable Remote management
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
#Enable-PSRemoting -force

#Remove bloatware
iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/debloat'))

#Enable Hyper-V
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

#Toggle SMBv1
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force

#Source: https://github.com/superswan/Powershell-SysAdmin