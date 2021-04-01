# Description: Setup Windows 10 environment
# Author: secf4ult
# Last Update: 2018-4-6
#
# Modified from https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f

Set-ExecutionPolicy Unrestricted -Force

# ---- Install Scoop  ----
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# Disable-UAC
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA  -Value 0

# ---- WINDOWS SETTINGS ----
# UNINSTALL
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
Get-AppxPackage Microsoft.ImmersiveReader | Remove-AppxPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage

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
# Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarSmallIcons -Type DWord
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
# New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Type DWORD -Value 1

#--- Apps ---
scoop install sudo grep sed less touch ln curl wget
scoop install git 7zip openssh nmap docker
# font
scoop bucket add nerd-fonts
scoop install FiraCode-NF Meslo-NF
# nirsoft
scoop bucket add nirsoft
# gui apps
scoop bucket add extras
scoop install chromium-dev-nosync firefox-developer mpv wireshark steam vscodium-portable

# Setup Powershell
# Install-Module -Name PowerShellGet -Force
# Install-Module -Name posh-git -Scope CurrentUser -Force
# Install-Module -Name oh-my-posh -Scope CurrentUser -Force

# Install Windows Subsystem for Linux
# build 20262 or higher
# wsl --install
# Manual steps: https://docs.microsoft.com/en-us/windows/wsl/install-win10#manual-installation-steps
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# wsl --set-default-version 2

# ---- Restore Temporary Settings ----
# Enable-UAC
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA  -Value 1
# Enable-MicrosoftUpdate
# Install-WindowsUpdate -acceptEula
Set-ExecutionPolicy RemoteSigned -Force

# Config the scoop
scoop config proxy 127.0.0.1:7890
# Config powershell
scoop install concfg
concfg import solarized-dark -y


# ---- Rename the Computer ----
# Requires restart, or add the -Restart flag
$computername = "secf4ult"
if ($env:computername -ne $computername) {
	Rename-Computer -NewName $computername
}
