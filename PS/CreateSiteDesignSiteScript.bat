REM login
m365 login

REM list all Site Design
m365 spo sitedesign list

REM list all Site script
m365 spo sitescript list

REM add site script 
$SiteScriptFile = "sitescript-contoso.json" -f $scriptPath
$siteScriptJson = ""
Get-Content $SiteScriptFile | Where-Object { $siteScriptJson += $_ }
m365 spo sitescript add --title "Contoso Com01 Cli" --description "Contoso Communication01 script from Cli" --content $siteScriptJson

REM list site design
m365 spo sitedesign list

REM add site design
m365 spo sitedesign add --title "Contoso Communication01 Cli" --webTemplate CommunicationSite --siteScripts "b9153fc8-e730-4e3f-ae79-779a2e5b1acd"
