#testing
$AdminUrl = "https://m365x725618-admin.sharepoint.com"
$CredStoreName = "SPO-M365x725618"

$psCred = Get-PnPStoredCredential -Name $CredStoreName -Type PSCredential
Connect-SPOService -Url $AdminUrl -Credential $psCred

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

Get-SPOSiteDesign

Get-SPOSiteScript

Set-SPOSiteScript -Identity 9d54d3a8-dc32-4125-9681-e2a542109c35 -Content $siteScriptJson_Communication

Grant-SPOSiteDesignRights -Identity 16b3137e-34aa-4816-aa9c-b3d3eeb7d38b `
    -Principals "frank@m365x725618.onmicrosoft.com" `
    -Rights View

Get-SPOSiteDesignRights -Identity 16b3137e-34aa-4816-aa9c-b3d3eeb7d38b
Revoke-SPOSiteDesignRights -Identity 16b3137e-34aa-4816-aa9c-b3d3eeb7d38b
Remove-SPOSiteDesign -Identity 7a4c6f4c-8cca-4e15-9d9d-8d8973b184d9
Remove-SPOSiteScript -Identity 9d54d3a8-dc32-4125-9681-e2a542109c35