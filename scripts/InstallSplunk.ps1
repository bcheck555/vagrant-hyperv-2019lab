#https://docs.splunk.com/Documentation/Splunk/9.4.1/Installation/InstallonWindowsviathecommandline
#"https://download.splunk.com/products/splunk/releases/9.1.0/windows/splunk-9.1.0-1c86ca0bacc3-x64-release.msi"
$url = "https://download.splunk.com/products/splunk/releases/9.4.1/windows"
$file = "splunk-9.4.1-e3bdab203ac8-windows-x64.msi"
$basePath = "C:\Temp"
$arguments = "/i `"$basePath\$file`" " +
  "AGREETOLICENSE=Yes " +
  "INSTALLDIR=`"D:\Program Files\Splunk`" " +
  "SPLUNKD_PORT=8089 " +
  "WEB_PORT=8000 " +
  "WINEVENTLOG_APP_ENABLE=0 " +
  "WINEVENTLOG_SEC_ENABLE=0 " +
  "WINEVENTLOG_SYS_ENABLE=0 " +
  "WINEVENTLOG_FWD_ENABLE=0 " +
  "WINEVENTLOG_SET_ENABLE=0 " +
  "REGISTRYCHECK_U=0 " +
  "REGISTRYCHECK_BASELINE_U=0 " +
  "REGISTRYCHECK_LM=0 " +
  "REGISTRYCHECK_BASELINE_LM=0 " +
  "WMICHECK_CPUTIME=0 " +
  "WMICHECK_LOCALDISK=0 " +
  "WMICHECK_FREEDISK=0 " +
  "WMICHECK_MEMORY=0 " +
  "LOGON_USERNAME=`"`" " +
  "LOGON_PASSWORD=`"`" " +
  "SPLUNK_APP=`"`" " +
  "FORWARD_SERVER=`"`" " +
  "DEPLOYMENT_SERVER=`"`" " +
  "LAUNCHSPLUNK=0 " +
  "INSTALL_SHORTCUT=1 " +
  "SPLUNKUSERNAME=admin " +
  "SPLUNKPASSWORD= " +
  "MINPASSWORDLEN=16 " +
  "MINPASSWORDDIGITLEN=1 " +
  "MINPASSWORDLOWERCASELEN=1 " +
  "MINPASSWORDUPPERCASELEN=1 " +
  "MINPASSWORDSPECIALCHARLEN=1 " +
  "GENRANDOMPASSWORD=1 " +
  "/passive"
$ProgressPreference = 'SilentlyContinue'   #Speeds up IWR ¯\_(ツ)_/¯

#Install
if (!(Test-Path -Path $basePath -PathType Container)) {
    New-Item -ItemType "directory" -Path $basePath
}
Invoke-WebRequest -Uri $url\$file -OutFile $basePath\$file
Start-Process msiexec.exe -ArgumentList $arguments -Wait

#Config