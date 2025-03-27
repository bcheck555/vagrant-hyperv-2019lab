$mappings = Import-Csv -Path C:\temp\GPOMapping.csv

foreach ($mapping in $mappings) {
    If ($mapping.Link -eq "Yes") {
        New-GPLink -Name $mapping.Name -Target $mapping.Target -Order $mapping.Order -LinkEnabled Yes
    }   
}