# Microsoft Certificate Services (AD CS) Firewall Ports

# HTTP (TCP 80) - For Certificate Enrollment via Web Enrollment
New-NetFirewallRule -DisplayName "AD CS HTTP (TCP 80)" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow

# HTTPS (TCP 443) - For Certificate Enrollment via Web Enrollment (Secure)
New-NetFirewallRule -DisplayName "AD CS HTTPS (TCP 443)" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow

# DCOM (TCP 135) - For RPC-based communication
New-NetFirewallRule -DisplayName "AD CS DCOM (TCP 135)" -Direction Inbound -LocalPort 135 -Protocol TCP -Action Allow

# DCOM Dynamic Ports (TCP)
# Use the built-in firewall group for dynamic RPC ports.
New-NetFirewallRule -DisplayName "AD CS DCOM Dynamic Ports" -Group "@FirewallAPI.dll,-28502" -Direction Inbound -Protocol TCP -Action Allow

# LDAP (TCP 389) - For AD CS to access Active Directory
New-NetFirewallRule -DisplayName "AD CS LDAP (TCP 389)" -Direction Inbound -LocalPort 389 -Protocol TCP -Action Allow

# LDAP SSL (TCP 636) - For secure LDAP communication
New-NetFirewallRule -DisplayName "AD CS LDAP SSL (TCP 636)" -Direction Inbound -LocalPort 636 -Protocol TCP -Action Allow

# CRL Distribution Point (CDP) ports (if using HTTP/HTTPS or LDAP/LDAPS)
# These depend on how you've configured your CDP. Adjust as needed.
# Example HTTP CDP:
# New-NetFirewallRule -DisplayName "AD CS CDP HTTP (TCP 80)" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
# Example HTTPS CDP:
# New-NetFirewallRule -DisplayName "AD CS CDP HTTPS (TCP 443)" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow
# Example LDAP CDP:
# New-NetFirewallRule -DisplayName "AD CS CDP LDAP (TCP 389)" -Direction Inbound -LocalPort 389 -Protocol TCP -Action Allow
# Example LDAPS CDP:
# New-NetFirewallRule -DisplayName "AD CS CDP LDAPS (TCP 636)" -Direction Inbound -LocalPort 636 -Protocol TCP -Action Allow

# OCSP (Online Certificate Status Protocol) Ports (if using)
# Example HTTP OCSP:
# New-NetFirewallRule -DisplayName "AD CS OCSP HTTP (TCP 80)" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
# Example HTTPS OCSP:
# New-NetFirewallRule -DisplayName "AD CS OCSP HTTPS (TCP 443)" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow

# Certificate Enrollment Policy (CEP) and Certificate Enrollment Web Service (CES) Ports (if using)
# Example CEP/CES HTTP:
# New-NetFirewallRule -DisplayName "AD CS CEP/CES HTTP (TCP 80)" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
# Example CEP/CES HTTPS:
# New-NetFirewallRule -DisplayName "AD CS CEP/CES HTTPS (TCP 443)" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow

# Certificate Authority Web Enrollment (if using)
# Example HTTP:
# New-NetFirewallRule -DisplayName "AD CS CA Web Enrollment HTTP (TCP 80)" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
# Example HTTPS:
# New-NetFirewallRule -DisplayName "AD CS CA Web Enrollment HTTPS (TCP 443)" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow