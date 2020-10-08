# Introduction 
This project includes all code for Contoso branding POC

| Filename                                 | Description                                                                                                                    |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| PS\Apply-SiteDesign.ps1                  | apply a site design to a list of site collection defined in a csv file                                                         |
| PS\Create-TenantTheme.ps1                | add a SPO theme to a tenant                                                                                                    |
| PS\Create-SiteScriptDesign.ps1           | Create a site script and site design and assoicate it to a web template                                                        |
| PS\Export-SiteScriptFromSite.ps1         | Export site script from a site collection                                                                                      |
| PowerAutomation\SiteProvisioningFlow.zip | A Power Automation Flow which is called by Site Design. It creates a modern page and set it to home page by using SPO REST API |

# Instruction
Apply-SiteDesign.ps1
```Powershell
.\Apply-SiteDesign.ps1 -AdminUrl [spo-admin-url]
```

Create-TenantTheme.ps1
```Powershell
.\Create-TenantTheme.ps1 -AdminUrl [spo-admin-url]
```

```Powershell
.\Create-TenantTheme.ps1 -AdminUrl [spo-admin-url] -ThemeName [Theme-name] -CredStoreName [Credential-Store-Name]
```

Create-SiteScriptDesign.ps1
```Powershell
.\Create-SiteScriptDesign.ps1 -AdminUrl [spo-admin-url]
```
