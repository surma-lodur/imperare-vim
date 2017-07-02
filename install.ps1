$url = "https://download.sysinternals.com/files/Junction.zip"
$output = "$PSScriptRoot\vim\bin\junctions.zip"
$start_time = Get-Date

"Download Junctions"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

"Unzip Junctions"
$shell = new-object -com shell.application
$zip = $shell.NameSpace($output)
foreach($item in $zip.items())
{
$shell.Namespace("$PSSCriptRoot\vim\bin").copyhere($item)
}

$url = "http://prdownloads.sourceforge.net/ctags/ctags58.zip"
$output = "$PSScriptRoot\vim\bin\ctags58.zip"
$start_time = Get-Date

"Download ctags"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

"Unzip Ctags"
$shell = new-object -com shell.application
$zip = $shell.NameSpace($output)
foreach($item in $zip.items())
{
$shell.Namespace("$PSSCriptRoot\vim\bin").copyhere($item)
}

Move-Item $PSSCriptRoot\vim\bin\ctags58\ctags.exe $PSSCriptRoot\vim\bin\

"Download ag"
$url = "https://kjkpub.s3.amazonaws.com/software/the_silver_searcher/rel/0.29.1-1641/ag.exe"
$output = "$PSScriptRoot\vim\bin\ag.exe"
$start_time = Get-Date

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

"Link Paths"
invoke-expression "mklink /H $env:userprofile\_vimrc $PSScriptRoot\vimrc"
invoke-expression "cmd /c $PSScriptRoot\vim\bin\junction  %userprofile%\_vim %cd%\vim"
