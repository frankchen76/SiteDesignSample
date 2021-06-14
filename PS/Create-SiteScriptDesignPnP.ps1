function Create-SiteScriptDesignPnP {
    param (
        [string] $AdminUrl = "https://m365x725618-admin.sharepoint.com",
        [string] $SiteScriptTitle = "",
        [string] $SiteDesignTitle = "",
        [string] $SiteScriptFile = "",
        [string] $WebTemplate = "",
        [string] $ClientId = ""
    )

    $siteScriptJson = ""
    Get-Content $SiteScriptFile | Where-Object { $siteScriptJson += $_ }

    #Get Credential from Credential Store if specified
    if ($clientId -ne "") {
        Connect-PnPOnline -Url $AdminUrl -ClientId $clientId -Interactive -ForceAuthentication
    }
    else {
        Connect-PnPOnline -Url $AdminUrl -Interactive -ForceAuthentication
    }

    $siteScriptObj = Add-PnPSiteScript -Title $SiteScriptTitle -Content $siteScriptJson -Description $SiteScriptTitle
    Write-Host "Site scirpt for Communication site was created. Id: $($siteScriptObj.Id);Title: $($siteScriptObj.Title)"

    #The value "64" indicates Team site template
    # $sd_TeamDefault = Add-SPOSiteDesign -Title "Contoso Team Default" -WebTemplate "64" -SiteScripts $siteScriptObj_Team.Id -Description "Apply default logo and theme to team sites" -IsDefault
    # Write-Host "Site Design for Team site was created. Id: $($sd_TeamDefault.Id);Title: $($sd_TeamDefault.Title)"

    #the value "68" indicates the Communication site template.
    $sd_CommunicationDefault = Add-PnPSiteDesign -Title $SiteDesignTitle -WebTemplate $WebTemplate -SiteScriptIds $siteScriptObj.Id -Description $SiteDesignTitle #-IsDefault
    Write-Host "Site Design for Communication site was created. Id: $($sd_CommunicationDefault.Id);Title: $($sd_CommunicationDefault.Title)"
}

#Get current ps running path
$scriptFullPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path $scriptFullPath

$url = "https://m365x725618-admin.sharepoint.com"
$ssTitle = "Contoso Communication PnP"
$sdTitle = "Contoso Communication PnP"
$file = "{0}\sitescript-contoso.json" -f $scriptPath
# 68 communication; 64: team
$wt = "68"
$cid = "7fab5118-0b7d-4706-9236-448743f335be"

Create-SiteScriptDesignPnP -AdminUrl $url `
    -SiteScriptTitle $ssTitle `
    -SiteDesignTitle $sdTitle `
    -SiteScriptFile  $file `
    -WebTemplate $wt `
    -ClientId $cid

# Remove-PnPSiteScript -Identity 6f990159-e4f2-4393-834e-8a8f03abe62a -Force
# Remove-PnPSiteDesign -Identity f543cd71-8f3b-4986-a433-a5dd9170e03e -Force
# Get-PnPSiteScript
# Get-PnPSiteDesign