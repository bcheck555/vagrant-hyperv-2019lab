#"https://download.splunk.com/products/splunk/releases/9.1.0/windows/splunk-9.1.0-1c86ca0bacc3-x64-release.msi"
$url = "https://download.splunk.com/products/splunk/releases/9.4.1/windows"
$file = "splunk-9.4.1-e3bdab203ac8-windows-x64.msi"
$basePath = "C:\Temp"
$ProgressPreference = 'SilentlyContinue'   #Speeds up IWR

#Import GPOs
New-Item -ItemType "directory" -Path $basePath
Invoke-WebRequest -Uri $url\$file -OutFile $basePath\$file
msiexec.exe /i $basePath\$file /passive