Quick lab using Vagrant and Hyper-V.


<ul>
  <li>DC01 setup as first domain controller
  <li>DC02 setup as secondary domain controller
    <ul>
      <li>Import DISA GPOs for a quick start
      <li>Import DISA WMI filters for a quick start
      <li>Map WMI filters to appropriate GPOs - NOT WORKING
      <li>Import OU structure
      <li>Map GPOs to appropriate OU
    </ul>
  <li>SRV01 domain joined server
</ul>

Install Vagrant

Install Hyper-V
  
Clone repo
  
Setup reserved address' in DHCP
  
From elevated Powershell: .\lab_up.ps1