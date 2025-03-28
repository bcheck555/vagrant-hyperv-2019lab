$featureName = "Adcs-Cert-Authority"
$params = @{
    CAType              = "EnterpriseRootCa"
    caCommonName        = "HomeLAB Root CA"
    CryptoProviderName  = "RSA#Microsoft Software Key Storage Provider"
    KeyLength           = 2048
    HashAlgorithmName   = "SHA256"
    ValidityPeriod      = "Years"
    ValidityPeriodUnits = 30
}

$feature = Get-WindowsFeature -Name $featureName
if (!($feature.InstallState -eq "Installed")) {
    Install-WindowsFeature -Name $featureName -IncludeManagementTools
}
Install-AdcsCertificationAuthority @params -Force
Get-CATemplate | Remove-CATemplate -Force
Add-CATemplate -Name "Workstation" -Force
Add-CATemplate -Name "KerberosAuthentication" -Force