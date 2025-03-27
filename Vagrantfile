# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.guest = :windows
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.guest = "windows"
  config.vm.box = "hyperv_server_2019"
  config.vm.communicator = "winssh"

  config.vm.define "dc01" do |dc01|
    dc01.vm.network "private_network", bridge: "Ethernet"
    dc01.vm.provider "hyperv" do |hv|
      hv.vmname = "dc01"
      hv.cpus = 4
      hv.memory = "8196"
      hv.mac = "00155d010291"
      hv.enable_virtualization_extensions = true
      hv.linked_clone = true
    end
    dc01.vm.provision "uploads", 
      type: "file",
      source: "./uploads", destination: "c:/temp"
    dc01.vm.provision "rename",
      type: "shell",
      privileged: "true",
      reboot: "true",
      inline: <<-'POWERSHELL'
      $dsrmPassword = ConvertTo-SecureString -String 'P@55w0rd' -AsPlainText -Force
      Set-TimeZone "Eastern Standard Time"
      Set-LocalUser -Name "Administrator" -Password $dsrmPassword
      Rename-Computer -NewName "dc01" -Force -PassThru
      POWERSHELL
    dc01.vm.provision "domain",
      type: "shell",
      privileged: "true",
      inline: <<-'POWERSHELL'
      $dsrmPassword = ConvertTo-SecureString -String 'P@55w0rd' -AsPlainText -Force
      Install-WindowsFeature -name AD-Domain-Services,DNS -IncludeManagementTools
      Install-ADDSForest -DomainName packet.loss -DomainMode 7 -ForestMode 7 -SafeModeAdministratorPassword $dsrmPassword -Force
      POWERSHELL
  end

  config.vm.define "dc02" do |dc02|
    dc02.vm.network "private_network", bridge: "Ethernet"
    dc02.vm.provider "hyperv" do |hv|
      hv.vmname = "dc02"
      hv.cpus = 4
      hv.memory = "8192"
      hv.mac = "00155d010292"
      hv.enable_virtualization_extensions = true
      hv.linked_clone = true
    end
    dc02.vm.provision "scripts", 
      type: "file",
      source: "./scripts", destination: "c:/temp"
    dc02.vm.provision "uploads", 
      type: "file",
      source: "./uploads", destination: "c:/temp"
    dc02.vm.provision "rename",
      type: "shell",
      privileged: "true",
      reboot: "true",
      inline: <<-'POWERSHELL'
      $dsrmPassword = ConvertTo-SecureString -String 'P@55w0rd' -AsPlainText -Force
      Set-TimeZone "Eastern Standard Time"
      Set-LocalUser -Name "Administrator" -Password $dsrmPassword
      Rename-Computer -NewName "dc02" -Force -PassThru
      POWERSHELL
    dc02.vm.provision "domain",
      type: "shell",
      privileged: "false",
      reboot: "true",
      inline: <<-'POWERSHELL'
      $userName = "packet\Administrator"
      $dsrmPassword = ConvertTo-SecureString -String 'P@55w0rd' -AsPlainText -Force
      $credential = New-Object System.Management.Automation.PSCredential($username, $dsrmPassword)
      Install-WindowsFeature -name AD-Domain-Services,DNS -IncludeManagementTools
      Install-ADDSDomainController -InstallDns -DomainName "packet.loss" -Credential $credential -SafeModeAdministratorPassword $dsrmPassword -Force
      POWERSHELL
    dc02.vm.provision "OUMapping",
      type: "shell",
      privileged: "true",
      #reboot: "false",
      path: "./scripts/OUMapping.ps1"
    dc02.vm.provision "GPOImport",
      type: "shell",
      privileged: "true",
      #reboot: "false",
      path: "./scripts/GPOImport.ps1"
    dc02.vm.provision "GPOMapping",
      type: "shell",
      privileged: "true",
      #reboot: "true",
      path: "./scripts/GPOMapping.ps1"
    dc02.vm.provision "WMIMapping",
      type: "shell",
      privileged: "true",
      reboot: "false",
      path: "./scripts/WMIMapping.ps1"
  end
  
  config.vm.define "srv01" do |srv01|
    srv01.vm.network "private_network", bridge: "Ethernet"
    srv01.vm.provider "hyperv" do |hv|
      hv.vmname = "srv01"
      hv.cpus = 4
      hv.memory = "8196"
      hv.enable_virtualization_extensions = true
      hv.linked_clone = true
    end
    srv01.vm.provision "uploads", 
      type: "file",
      source: "./uploads", destination: "c:/temp"
      srv01.vm.provision "rename",
      type: "shell",
      privileged: "true",
      reboot: "true",
      inline: <<-'POWERSHELL'
      $dsrmPassword = ConvertTo-SecureString -String 'P@55w0rd' -AsPlainText -Force
      Set-TimeZone "Eastern Standard Time"
      Set-LocalUser -Name "Administrator" -Password $dsrmPassword
      Rename-Computer -NewName "srv01" -Force -PassThru
    POWERSHELL
    srv01.vm.provision "domain",
      type: "shell",
      privileged: "true",
      inline: <<-'POWERSHELL'
      $dsrmPassword = ConvertTo-SecureString -String 'P@55w0rd' -AsPlainText -Force
      #Add-Computer -DomainName packet.loss -OUPath "OU=Tier1A,OU=Computers,OU=HomeLab,DC=PACKET,DC=LOSS" -PassThru -Verbose
    POWERSHELL
  end
end
