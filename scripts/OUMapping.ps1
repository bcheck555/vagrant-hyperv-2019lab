$mappings = Import-Csv -Path C:\temp\OUMapping.csv

foreach ($mapping in $mappings) {
    New-ADOrganizationalUnit -Name $mapping.OU -Path $mapping.Path -ProtectedFromAccidentalDeletion $True
}
