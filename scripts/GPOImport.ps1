$url = "https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip"
$file = "U_STIG_GPO_Package_January_2025.zip"
$basePath = "C:\Jan25 DISA STIG GPO Package 0117"
$supportPath= "Support Files"
$psScript = "DISA_GPO_Baseline_Import.ps1"
$gpoList = "DISA_AllGPO_Import_Jan2025.csv"
$importTable = "C:\temp\importtable.migtable"

#Import GPOs
New-Item -ItemType "directory" -Path $basePath
Invoke-WebRequest -Uri $url\$file -OutFile $basePath\$file
Expand-Archive -Path $basePath\$file -DestinationPath $basePath -Force

$oldText = "ADD YOUR DOMAIN ADMINS"
$newText = "Domain Admins@packet.loss"
(Get-Content -Path $importTable) -replace $oldText, $newText | Set-Content -Path $importTable

$oldText = "ADD YOUR ENTERPRISE ADMINS"
$newText = "Enterprise Admins@packet.loss"
(Get-Content -Path $importTable) -replace $oldText, $newText | Set-Content -Path $importTable

Set-Location $basePath\$supportPath
& .\$psScript $gpoList $importTable

#Import WMI Filters
$files = Get-ChildItem -Path $basePath -Filter "*.mof" -Recurse | Select-Object FullName

foreach ($file in $files) {
  $oldDomain = "security.local"
  $newDomain = "packet.loss"
  (Get-Content -Path $file.FullName) -replace $oldDomain, $newDomain | Set-Content -Path $file.FullName
  $oldDomain = "testing.com"  #Fuck consistency...
  $newDomain = "packet.loss"
  (Get-Content -Path $file.FullName) -replace $oldDomain, $newDomain | Set-Content -Path $file.FullName
  mofcomp.exe -N:Root\policy $file.FullName
}