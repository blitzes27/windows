# When this skript is executed it will run a skript on github and then delete it. One could run it as a schedueled task. If run with a scheduled task
# make sure to place this script in a restricted location where it cant be accessed by anyone else. Preferebly also signed with a certificate.
$tmp = [IO.Path]::GetTempFileName().Replace('.tmp','.ps1')
$wc = New-Object System.Net.WebClient
$wc.DownloadFile("https://raw.githubusercontent.com/blitzes27/windows/main/firewall/firewall_windows.ps1", $tmp)
powershell.exe -ExecutionPolicy Bypass -File $tmp
Remove-Item $tmp -Force