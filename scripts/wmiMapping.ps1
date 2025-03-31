Get-PackageProvider -Name NuGet -ForceBootstrap
if (!(Get-Module -Name gpowmi))
{
   Install-Module -Name gpowmi -Force
}

$dsrmPassword = ConvertTo-SecureString -String 'P@55w0rd' -AsPlainText -Force
$serviceAccount = "packet\Administrator"
$credential = New-Object System.Management.Automation.PSCredential($serviceAccount, $dsrmPassword)
$mappings = Import-Csv -Path C:\temp\wmiMapping.csv
foreach ($mapping in $mappings) {
    Set-GPOWmiFilter -GroupPolicyName $mapping.GPO -WMIFilterName $mapping.WMI -Credential $credential
}