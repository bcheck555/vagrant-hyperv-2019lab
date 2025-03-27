Get-PackageProvider -Name NuGet -ForceBootstrap
if (-not (Get-Module -Name gpowmi -ListAvailable))
{
   Install-Module -Name gpowmi -Force
}

$mappings = Import-Csv -Path C:\temp\wmiMapping.csv
foreach ($mapping in $mappings) {
    Set-GPOWmiFilter -GroupPolicyName $mapping.GPO -WMIFilterName $mapping.WMI
}