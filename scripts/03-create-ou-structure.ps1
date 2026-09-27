# Create the organizational unit structure for lab.local
# IT was originally demonstrated through the GUI during the live build.
# It is included here so the script represents the complete final structure.

New-ADOrganizationalUnit -Name "IT"           -Path "DC=lab,DC=local"
New-ADOrganizationalUnit -Name "Finance"      -Path "DC=lab,DC=local"
New-ADOrganizationalUnit -Name "HR"           -Path "DC=lab,DC=local"
New-ADOrganizationalUnit -Name "Sales"        -Path "DC=lab,DC=local"
New-ADOrganizationalUnit -Name "Workstations" -Path "DC=lab,DC=local"

# Verify OU creation
Get-ADOrganizationalUnit -Filter * |
    Select-Object Name