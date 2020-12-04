#testing
$AdminUrl = "https://m365x725618-admin.sharepoint.com",
$CredStoreName = "SPO-M365x725618"

#Get current ps running path
$scriptFullPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path $scriptFullPath

#init site script file
$SiteScriptFile = "{0}\sitescript-contoso-externalsharing.json" -f $scriptPath

$siteScriptJson = ""
Get-Content $SiteScriptFile | Where-Object { $siteScriptJson += $_ }

#add site script
$siteScriptObj = Add-SPOSiteScript -Title "Contoso ExternalSharing" -Content $siteScriptJson -Description "Contoso ExternalSharing script"

# add site design
$sd_Communication = Add-SPOSiteDesign -Title "Contoso ExternalSharing(disabled)" -WebTemplate "68" -SiteScripts $siteScriptObj.Id -Description "Apply Contoso ExternalSharing to communication sites" #-IsDefault
$sd_Team = Add-SPOSiteDesign -Title "Contoso ExternalSharing(disabled)" -WebTemplate "64" -SiteScripts $siteScriptObj.Id -Description "Apply Contoso ExternalSharing to Team sites" #-IsDefault

#remove the site design
Remove-SPOSiteDesign -Identity $sd_Team.Id
Remove-SPOSiteDesign -Identity $sd_Communication.Id

#remove the site script
Remove-SPOSiteScript -Identity $siteScriptObj.Id

