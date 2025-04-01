#https://learn.microsoft.com/en-us/archive/msdn-technet-forums/b4e479fd-48b7-4659-ac02-6e7eadd1bdda
#https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_DoD.zip

$url = "https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip"
$file = "unclass-certificates_pkcs7_DoD.zip"
$basePath = "C:\Temp"
$certPath = "Certificates_PKCS7_v5_14_DoD"
$ProgressPreference = 'SilentlyContinue'   #Speeds up IWR ¯\_(ツ)_/¯

#Begin
if (!(Test-Path -Path $basePath -PathType Container)) {
    New-Item -ItemType "directory" -Path $basePath
}
Invoke-WebRequest -Uri $url\$file -OutFile $basePath\$file
Expand-Archive -Path $basePath\$file -DestinationPath $basePath -Force
#Convert to Individual PEM
[void][reflection.assembly]::LoadWithPartialName("System.Security")
$data = [System.IO.File]::ReadAllBytes("$basePath\$certPath\Certificates_PKCS7_v5_14_DoD.der.p7b")
$cms = new-object system.security.cryptography.pkcs.signedcms
$cms.Decode($data)
foreach ($certificate in $cms.Certificates ) {
    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $certificate
    # Get CN from certificates, will be used as file name for .cer files
    $commonName = ([regex]'(?i)cn=(.+?),').Match($cert.Subject).Groups[1].Value
    
    $content = @(
    'BEGIN CERTIFICATE'
    [System.Convert]::ToBase64String($cert.RawData, 'InsertLineBreaks')
    'END CERTIFICATE'
    )
    $certFile = Join-Path -Path $basePath -ChildPath "$($commonName).crt"
    $content | Out-File -FilePath $certFile -Encoding ascii
}
#Install
$certificates = Get-ChildItem -Path "C:\temp\" -Filter "*id*.crt"
foreach ($certificate in $certificates) {
  certutil -dspublish -f $certificate.name NTAUTHCA
}
