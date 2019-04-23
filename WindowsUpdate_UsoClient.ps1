
### https://www.idkrtm.com/windows-update-commands/
### https://www.urtech.ca/2018/11/usoclient-documentation-switches/

## opdater windows 10 via Usoclient.exe ( en nativ måde at køre opdateringer på )
		
$UsoClient = "C:\WINDOWS\System32\UsoClient.exe"

Start-Process -FilePath $UsoClient -ArgumentList "Refreshsettings" -Wait
Start-Process -FilePath $UsoClient -ArgumentList "ScanInstallWait" -Wait
Start-Process -FilePath $UsoClient -ArgumentList "StartInstall"  -Wait
