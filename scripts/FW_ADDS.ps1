# Active Directory Domain Services Ports

# DNS (TCP and UDP 53)
New-NetFirewallRule -DisplayName "AD DS DNS (TCP)" -Direction Inbound -LocalPort 53 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "AD DS DNS (UDP)" -Direction Inbound -LocalPort 53 -Protocol UDP -Action Allow

# Kerberos (TCP and UDP 88)
New-NetFirewallRule -DisplayName "AD DS Kerberos (TCP)" -Direction Inbound -LocalPort 88 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "AD DS Kerberos (UDP)" -Direction Inbound -LocalPort 88 -Protocol UDP -Action Allow

# LDAP (TCP and UDP 389)
New-NetFirewallRule -DisplayName "AD DS LDAP (TCP)" -Direction Inbound -LocalPort 389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "AD DS LDAP (UDP)" -Direction Inbound -LocalPort 389 -Protocol UDP -Action Allow

# LDAP SSL (TCP 636)
New-NetFirewallRule -DisplayName "AD DS LDAP SSL (TCP)" -Direction Inbound -LocalPort 636 -Protocol TCP -Action Allow

# Global Catalog (TCP and UDP 3268)
New-NetFirewallRule -DisplayName "AD DS Global Catalog (TCP)" -Direction Inbound -LocalPort 3268 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "AD DS Global Catalog (UDP)" -Direction Inbound -LocalPort 3268 -Protocol UDP -Action Allow

# Global Catalog SSL (TCP 3269)
New-NetFirewallRule -DisplayName "AD DS Global Catalog SSL (TCP)" -Direction Inbound -LocalPort 3269 -Protocol TCP -Action Allow

# Kerberos Change/Password (TCP 464)
New-NetFirewallRule -DisplayName "AD DS Kerberos Password Change (TCP)" -Direction Inbound -LocalPort 464 -Protocol TCP -Action Allow

# RPC (Dynamic Ports)
# You can open the RPC endpoint mapper (TCP 135) and then allow dynamic RPC ports, or open a specific range.
# Option 1: RPC Endpoint Mapper (TCP 135) and Dynamic Ports (Recommended for most cases)
New-NetFirewallRule -DisplayName "AD DS RPC Endpoint Mapper (TCP)" -Direction Inbound -LocalPort 135 -Protocol TCP -Action Allow
# Dynamic RPC ports are usually in the range 49152-65535.
# For a more specific range, replace 49152-65535 with your desired range.
# For example:
# New-NetFirewallRule -DisplayName "AD DS RPC Dynamic Ports" -Direction Inbound -LocalPort 49152-65535 -Protocol TCP -Action Allow
# A better way is to use the windows firewall built in group.
New-NetFirewallRule -DisplayName "AD DS RPC Dynamic Ports" -Group "@FirewallAPI.dll,-28502" -Direction Inbound -Protocol TCP -Action Allow

#Option 2: Specific RPC ports (If you have configured static RPC ports)
#Example:
#New-NetFirewallRule -DisplayName "AD DS RPC Specific Port" -Direction Inbound -LocalPort 50000 -Protocol TCP -Action Allow

# NetBIOS (UDP 137, UDP 138, TCP 139) (Usually not required in modern environments, but may be needed for older systems)
# New-NetFirewallRule -DisplayName "AD DS NetBIOS Name Service (UDP)" -Direction Inbound -LocalPort 137 -Protocol UDP -Action Allow
# New-NetFirewallRule -DisplayName "AD DS NetBIOS Datagram Service (UDP)" -Direction Inbound -LocalPort 138 -Protocol UDP -Action Allow
# New-NetFirewallRule -DisplayName "AD DS NetBIOS Session Service (TCP)" -Direction Inbound -LocalPort 139 -Protocol TCP -Action Allow

# SMB (TCP 445)
New-NetFirewallRule -DisplayName "AD DS SMB (TCP)" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Allow

# ICMP (Optional, for ping)
New-NetFirewallRule -DisplayName "AD DS ICMP (Ping)" -Direction Inbound -Protocol ICMPv4 -Action Allow