[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string] $AdminUrl = "",
    [string] $csvFile = "",
    [string] $CredStoreName = "",
    [string] $siteDesignTitle = "Contoso Communication Default"
)

$scriptFullPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path $scriptFullPath

#load CSV sc list
#get default csv files
if ($csvFile -eq "") {
    $csvFile = "$scriptPath\SiteCollectionList.csv"
}
$scList = Import-Csv -Path $csvFile

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

#get site design object
$siteDesignObj = Get-SPOSiteDesign | where { $_.Title -eq $siteDesignTitle }

if ($null -ne $siteDesignObj) {
    foreach ($sc in $scList) {
        Add-SPOSiteDesignTask -SiteDesignId $siteDesignObj.Id -WebUrl $sc.SiteUrl

    }
}
else {
    $errMsg = "Cannot find site design title: {0}" -f $siteDesignTitle
    Write-Error $errMsg
}