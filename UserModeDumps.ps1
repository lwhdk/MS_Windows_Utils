$EventlogSourceName = “UserModeDumpsSetup”
 
#$startReboot = 1 scriptet vil forsage at maskine genstarter
$startReboot = 0
 
## https://msdn.microsoft.com/en-us/library/windows/desktop/bb787181(v=vs.85).aspx
 
# DumpFolder
$DumpFolder = "c:\temp\dumps"
# Dump typen
$DumpType = 2
# Antal dumps før Overwrite begynder
$DumpCount = 3
 
#Dump Registry
$RegLocalDumps = "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps"
## test reg Path
##$RegLocalDumps = "HKCU:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps"
 
 
 
 
if ([System.Diagnostics.EventLog]::SourceExists($EventlogSourceName) -eq $false) {
 
    New-EventLog –LogName Application –Source $EventlogSourceName
 
}
 
IF(!(Test-Path $RegLocalDumps))
  {
      New-Item -Path $RegLocalDumps -Force
      Write-EventLog –LogName Application –Source $EventlogSourceName –EntryType Warning –EventID 1 –Message “UserMode Registry Key is Created”
  }
 
if (Test-Path $RegLocalDumps) {
    New-ItemProperty -Path $RegLocalDumps -Name "DumpFolder" -Value $DumpFolder -PropertyType ExpandString -Force
    New-ItemProperty -Path $RegLocalDumps -Name "DumpType" -Value $DumpType -PropertyType DWORD -Force
    New-ItemProperty -Path $RegLocalDumps -Name "DumpCount" -Value $DumpCount -PropertyType DWORD -Force
    Write-EventLog –LogName Application –Source $EventlogSourceName –EntryType Warning –EventID 1 –Message “UserMode Registry Entries is Updated”
}
 
 
if(!(test-path $DumpFolder))
{
 
    New-Item -Path $DumpFolder -ItemType Directory -Force
    Write-EventLog –LogName Application –Source $EventlogSourceName –EntryType Warning –EventID 2 –Message “UserMode DumpFolder is created”
 
}
 
Write-EventLog –LogName Application –Source $EventlogSourceName –EntryType Warning –EventID 3 –Message “UserMode Dump is Configured, Reboot need before it works”
 
if($startReboot -eq 1 )
{
    Write-EventLog –LogName Application –Source $EventlogSourceName –EntryType Warning –EventID 4 –Message “UserMode Dump is Configured, Reboot NOW”
    Restart-Computer -Force -Wait 60
 
}
 
 