
$CUAppToUninstall = "Myapp"
$CUAppToUninstallVersion = "4.0.0.6"
$CUUninstall = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\"

$CYkeys  = Get-ChildItem $CUUninstall -Recurse  


foreach ( $propkeys in $CYkeys)
{
    # $propkeys.Property 
     $key = $propkeys.Name
     $key = $key.Replace("HKEY_CURRENT_USER\","HKCU:\")
       $data = get-itemproperty -path $key 


       if(($data.DisplayName -eq $CUAppToUninstall) -and ($data.DisplayVersion -eq $CUAppToUninstallVersion) )
       {
       $data.DisplayName
       $data.DisplayVersion
       $data.UninstallString
       $data.QuietUninstallString
       $uninstall = "/C " + $data.UninstallString
       Start-Process -FilePath $env:ComSpec -ArgumentList  $uninstall -Wait
       
       }
}

