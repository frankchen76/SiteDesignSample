# Demonstrate how to export site script from a existing site collection
$psCred = Get-PnPStoredCredential -Name "SPO-M365x725618" -Type PSCredential
$psCred
Connect-SPOService -Url https://m365x725618-admin.sharepoint.com -Credential $psCred

# Export a web to a Site Script
Get-SPOSiteScriptFromWeb `
    -WebUrl https://m365x725618.sharepoint.com/sites/TestCommunication4 `
    -IncludeBranding `
    -IncludeTheme `
    -IncludeRegionalSettings `
    -IncludeSiteExternalSharingCapability `
    -IncludeLinksToExportedItems `
    -IncludedLists ("Shared Documents", "DeptDocuments")

# Export a list to a Site Script
Get-SPOSiteScriptFromList `
    -ListUrl "https://m365x725618.sharepoint.com/sites/TestCommunication4/DeptDocuments"
