$url = "https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip"
$file = "U_STIG_GPO_Package_January_2025.zip"
$temp = "C:\temp"
$labGPO = "LAB Group Policy.zip"
$basePath = "C:\Jan25 DISA STIG GPO Package 0117"
$supportPath = "Support Files"
$psScript = "DISA_GPO_Baseline_Import.ps1"
$gpoList = "c:\temp\DISA_AllGPO_Import_Jan2025.csv"
$importTable = "c:\temp\importtable.migtable"
$ProgressPreference = 'SilentlyContinue'   #Speeds up IWR

#Import GPOs
New-Item -ItemType "directory" -Path $basePath
Invoke-WebRequest -Uri $url\$file -OutFile $basePath\$file
Expand-Archive -Path $basePath\$file -DestinationPath $basePath -Force
Expand-Archive -Path $temp\$labGPO -DestinationPath $basePath -Force

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