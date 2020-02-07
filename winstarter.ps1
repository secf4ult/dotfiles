# Description: WinStarter
# Author: secf4ult
# Last Update: 2018-4-6
#
# Modified from https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f

Set-ExecutionPolicy Unrestricted -Force

# ---- Install Chocolatey ----
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Disable-UAC
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA  -Value 0

# ---- WINDOWS SETTINGS ----
# UNINSTALL
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
# 3D Paint
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage
# Camera
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage
# Immersive Reader
Get-AppxPackage Microsoft.ImmersiveReader | Remove-AppxPackage

# File Explorer:
# Displays file extentsion
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Type DWord -Value 0
# Displays hidden files, folders, and drives
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowSuperHidden -Type DWord -Value 1
# Displays protected operating system files
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Type DWord -Value 1
# Displays the full path in the title bar
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState -Name FullPath -Type DWord -Value 1
# Change Explorer home screen back to "This PC"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1
# Expand navigation pane to current folder
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Type DWord -Value 1

# Taskbar:
# Taskbar small icons
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarSmallIcons -Type DWord
# Dock taskbar top
# from: https://github.com/chocolatey/boxstarter/blob/master/Boxstarter.WinConfig/Set-TaskbarOptions.ps1
# the 9th byte in StuckRects?/Settings controls taskbar, for what meaning every bit represents refer to: http://www.dabcc.com/deciphering-stuckrects2/
$dockingKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects2'
if(-not (Test-Path -Path $dockingKey)) {
	$dockingKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
}
Set-ItemProperty -Path $dockingKey -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x07,0x00,0x00,0x2e,0x00,0x00,0x00))

# Start Menu
# Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Enable Developer Mode
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Type DWORD -Value 1

# ---- Windows Subsystems/Features ----
# choco install Microsoft-Hyper-V-All -source windowsFeatures
choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Apps ---
cinst googlechrome -y
cinst python3 -y
cinst visualstudiocode -y
cinst mpc-be -y
cinst git -y
cinst firacode -y
cinst wireshark -y
# choco install docker-for-windows -y
# choco install vcxsrv -y

# ---- Restore Temporary Settings ----
# Enable-UAC
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA  -Value 1
# Enable-MicrosoftUpdate
# Install-WindowsUpdate -acceptEula
Set-ExecutionPolicy RemoteSigned -Force

# ---- Rename the Computer ----
# Requires restart, or add the -Restart flag
$computername = "secf4ult"
if ($env:computername -ne $computername) {
	Rename-Computer -NewName $computername
}
