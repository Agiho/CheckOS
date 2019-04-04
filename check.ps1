<#PSScriptInfo
.VERSION 1.0.0
.DESCRIPTION Display System and disk information using win32_logicaldisk and win32_operatingsystem

.AUTHOR Mateusz Brunke (mateusz.brunke@outlook.com, mateusz.brunke@poczta-polska.pl)
.PROJECTURI http://gogs.code.ncoms.net/Agiho/CheckOS https://github.com/Agiho/CheckOS

.COPYRIGHT Copyright (C) 2018 Mateusz Brunke <mateusz.brunke@outlook.com>
.LICENSEURI http://www.gnu.org/licenses/gpl-2.0.html
#>

function Get-HostProperties{

param ($computerName = (Read-Host "Enter Server Name")
)

Get-WmiObject -Class win32_logicaldisk -ComputerName $computerName | ft DeviceID,  @{Name="File System";e={$_.FileSystem}}, @{Name="Free Disk Space (GB)";e={$_.FreeSpace /1GB}}, @{Name="Total Disk Size (GB)";e={$_.Size /1GB}} -AutoSize
Get-WmiObject -Class win32_computersystem -ComputerName $computerName | ft @{Name="Physical Processors";e={$_.NumberofProcessors}} ,@{Name="Logical Processors";e={$_.NumberOfLogicalProcessors}} , @{Name="TotalPhysicalMemory (MB)";e={[math]::truncate($_.TotalPhysicalMemory /1MB)}}, Model -AutoSize
Get-WmiObject -Class win32_operatingsystem -ComputerName $computerName | ft @{Name="Total Visible Memory Size (MB)";e={[math]::truncate($_.TotalVisibleMemorySize /1KB)}}, @{Name="Free Physical Memory (MB)";e={[math]::truncate($_.FreePhysicalMemory /1KB)}} -AutoSize
Get-WmiObject -Class win32_operatingsystem -ComputerName $computerName | ft @{Name="Operating System";e={$_.Name}}, @{Name="Service Pack";e={$_.ServicePackMajorVersion}} -AutoSize
Get-WmiObject -Class win32_operatingsystem -ComputerName $computerName | ft @{Name="Operating System Version";e={$_.Version}} -AutoSize
Get-WmiObject -Class win32_operatingsystem -ComputerName $computerName | ft @{Name="OS Architecture";e={$_.OSArchitecture}} -AutoSize
Get-WmiObject -Class win32_bios -ComputerName $computerName | ft @{Name="ServiceTag";e={$_.SerialNumber}}
Get-WmiObject -Class win32_bios -ComputerName $computerName | ft @{Name="Current status of the object";e={$_.Status}}
}
Get-HostProperties

write-host "Press any key to continue..."
[void][System.Console]::ReadKey($true)