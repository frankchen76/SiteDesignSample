[CmdletBinding()]
param (
    #[Parameter(Mandatory)]    
    [string] $AdminUrl="https://m365x725618-admin.sharepoint.com",
    [string] $ThemeName = "ContosoTheme01",
    [string] $CredStoreName = "SPO-M365x725618"
)

#Get Credential from Credential Store if specified
if ($CredStoreName -ne "") {
    $psCred = Get-PnPStoredCredential -Name $CredStoreName -Type PSCredential
}

#Connect to admin url
if ($null -eq $psCred) {
    Connect-PnPOnline -Url $AdminUrl -UseWebLogin
}
else {
    Connect-PnPOnline -Url $AdminUrl -Credentials $psCred    
}

$themepalette = @{
    "themePrimary" = "#f55e07";
    "themeLighterAlt" = "#fff8f5";
    "themeLighter" = "#fde4d6";
    "themeLight" = "#fcceb3";
    "themeTertiary" = "#f99d68";
    "themeSecondary" = "#f67124";
    "themeDarkAlt" = "#dc5507";
    "themeDark" = "#ba4806";
    "themeDarker" = "#893504";
    "neutralLighterAlt" = "#e9e9e9";
    "neutralLighter" = "#e5e5e5";
    "neutralLight" = "#dcdcdc";
    "neutralQuaternaryAlt" = "#cdcdcd";
    "neutralQuaternary" = "#c4c4c4";
    "neutralTertiaryAlt" = "#bcbcbc";
    "neutralTertiary" = "#a19f9d";
    "neutralSecondary" = "#605e5c";
    "neutralPrimaryAlt" = "#3b3a39";
    "neutralPrimary" = "#323130";
    "neutralDark" = "#201f1e";
    "black" = "#000000";
    "white" = "#f0f0f0";
    }

$existTheme = Get-PnPTenantTheme -Name $ThemeName

if ($null -eq $existTheme) {
    #Add theme
    Add-PnPTenantTheme -Identity $ThemeName -Palette $themepalette -IsInverted $false
    
    #hide default theme
    Set-PnPHideDefaultThemes -HideDefaultThemes $true
}

