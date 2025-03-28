#https://docs.splunk.com/Documentation/Forwarder/9.4.1/Forwarder/InstallaWindowsuniversalforwarderfromaninstaller
$url = "https://download.splunk.com/products/universalforwarder/releases/9.4.1/windows"
$file = "splunkforwarder-9.4.1-e3bdab203ac8-windows-x64.msi"
$basePath = "C:\Temp"
$arguments = "/i `"$basePath\$file`" " +
  "AGREETOLICENSE=Yes " +
  "INSTALLDIR=`"C:\Program Files\Splunk`" " +
  "LOGON_USERNAME=`"`" " +
  "LOGON_PASSWORD=`"`" " +
  "RECEIVING_INDEXER=`"log01.packet.loss:8089`" " +
  "DEPLOYMENT_SERVER=`"`" " +
  "LAUNCHSPLUNK=1 " +
  "SERVICESTARTTYPE=auto " +
  "MONITOR_PATH=`"`" " +
  "PERFMON= " +
  "CERTFILE=<c:\path\to\certfile.pem> " +
  "ROOTCACERTFILE=D:\Program Files\Splunk\etc\auth\mycerts " +
  "CERTPASSWORD= " +
  "CLONEPREP=0 " +
  "SET_ADMIN_USER=0 " +
  "SPLUNKUSERNAME= " +
  "SPLUNKPASSWORD= " +
  "MINPASSWORDLEN=16 " +
  "MINPASSWORDDIGITLEN=1 " +
  "MINPASSWORDLOWERCASELEN=1 " +
  "MINPASSWORDUPPERCASELEN=1 " +
  "MINPASSWORDSPECIALCHARLEN=1 " +
  "GENRANDOMPASSWORD=1 " +
  "USE_LOCAL_SYSTEM=1 " +
  "PRIVILEGEBACKUP=0 " +
  "PRIVILEGESECURITY=1 " +
  "PRIVILEGEIMPERSONATE=0 " +
  "GROUPPERFORMANCEMONITORUSERS=0 " +
  "/passive"
$ProgressPreference = 'SilentlyContinue'   #Speeds up IWR ¯\_(ツ)_/¯

#Install
if (!(Test-Path -Path $basePath -PathType Container)) {
    New-Item -ItemType "directory" -Path $basePath
}
Invoke-WebRequest -Uri $url\$file -OutFile $basePath\$file
Start-Process msiexec.exe -ArgumentList $arguments -Wait

#Config