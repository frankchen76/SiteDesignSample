[CmdletBinding()]
param (
    #[Parameter(Mandatory)]
    [string] $AdminUrl = "https://m365x777066-admin.sharepoint.com",
    [string] $SiteScriptFile_Team = "",
    [string] $SiteScriptFile_Communication = "",
    [string] $CredStoreName = "SPO-m365x777066"
)

#Get current ps running path
$scriptFullPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path $scriptFullPath

#init site script file
if ($SiteScriptFile_Team -eq "") {
    $SiteScriptFile_Team = "{0}\sitescript-contoso-m365x777066.json" -f $scriptPath
}
if ($SiteScriptFile_Communication -eq "") {
    $SiteScriptFile_Communication = "{0}\sitescript-contoso-m365x777066.json" -f $scriptPath
}

$siteScriptJson_Team = ""
Get-Content $SiteScriptFile_Team | Where-Object { $siteScriptJson_Team += $_ }

$siteScriptJson_Communication = ""
Get-Content $SiteScriptFile_Communication | Where-Object { $siteScriptJson_Communication += $_ }

#Get Credential from Credential Store if specified
if ($CredStoreName -ne "") {
    $psCred = Get-PnPStoredCredential -Name $CredStoreName -Type PSCredential
}

#Connect to admin url
if ($null -eq $psCred) {
    Connect-SPOService -Url $AdminUrl -UseWebLogin
}
else {
    Connect-SPOService -Url $AdminUrl -Credential $psCred    
}

# $siteScriptObj_Team = Add-SPOSiteScript -Title "Contoso Team" -Content $siteScriptJson_Team -Description "Contoso Team script apply default logo and theme"
# Write-Host "Site scirpt for Team site was created. Id: $($siteScriptObj_Team.Id);Title: $($siteScriptObj_Team.Title)"

$siteScriptObj_Communication = Add-SPOSiteScript -Title "Contoso Communication01" -Content $siteScriptJson_Communication -Description "Contoso Communication01 script"
Write-Host "Site scirpt for Communication site was created. Id: $($siteScriptObj_Communication.Id);Title: $($siteScriptObj_Communication.Title)"

#The value "64" indicates Team site template
# $sd_TeamDefault = Add-SPOSiteDesign -Title "Contoso Team Default" -WebTemplate "64" -SiteScripts $siteScriptObj_Team.Id -Description "Apply default logo and theme to team sites" -IsDefault
# Write-Host "Site Design for Team site was created. Id: $($sd_TeamDefault.Id);Title: $($sd_TeamDefault.Title)"

#the value "68" indicates the Communication site template.
$sd_CommunicationDefault = Add-SPOSiteDesign -Title "Contoso Communication01" -WebTemplate "68" -SiteScripts $siteScriptObj_Communication.Id -Description "Apply Contoso Communication01 to communication sites" #-IsDefault
Write-Host "Site Design for Communication site was created. Id: $($sd_CommunicationDefault.Id);Title: $($sd_CommunicationDefault.Title)"

