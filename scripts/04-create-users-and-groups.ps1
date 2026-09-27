# ============================================
# Active Directory Users and Security Groups
# Domain: lab.local
# ============================================

# Step 1 — create department security groups
New-ADGroup -Name "IT_Admins" `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "OU=IT,DC=lab,DC=local"

New-ADGroup -Name "Finance_Users" `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "OU=Finance,DC=lab,DC=local"

New-ADGroup -Name "HR_Users" `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "OU=HR,DC=lab,DC=local"

New-ADGroup -Name "Sales_Users" `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "OU=Sales,DC=lab,DC=local"


# Step 2 — securely request the temporary user password
$password = Read-Host "Enter temporary lab user password" -AsSecureString


# Step 3 — create the four lab users
New-ADUser -Name "alice.chen" `
    -GivenName "Alice" `
    -Surname "Chen" `
    -SamAccountName "alice.chen" `
    -UserPrincipalName "alice.chen@lab.local" `
    -Path "OU=IT,DC=lab,DC=local" `
    -AccountPassword $password `
    -Enabled $true

New-ADUser -Name "bob.patel" `
    -GivenName "Bob" `
    -Surname "Patel" `
    -SamAccountName "bob.patel" `
    -UserPrincipalName "bob.patel@lab.local" `
    -Path "OU=Finance,DC=lab,DC=local" `
    -AccountPassword $password `
    -Enabled $true

New-ADUser -Name "carol.jones" `
    -GivenName "Carol" `
    -Surname "Jones" `
    -SamAccountName "carol.jones" `
    -UserPrincipalName "carol.jones@lab.local" `
    -Path "OU=HR,DC=lab,DC=local" `
    -AccountPassword $password `
    -Enabled $true

New-ADUser -Name "david.smith" `
    -GivenName "David" `
    -Surname "Smith" `
    -SamAccountName "david.smith" `
    -UserPrincipalName "david.smith@lab.local" `
    -Path "OU=Sales,DC=lab,DC=local" `
    -AccountPassword $password `
    -Enabled $true


# Step 4 — assign users to their department security groups
Add-ADGroupMember -Identity "IT_Admins" `
    -Members "alice.chen"

Add-ADGroupMember -Identity "Finance_Users" `
    -Members "bob.patel"

Add-ADGroupMember -Identity "HR_Users" `
    -Members "carol.jones"

Add-ADGroupMember -Identity "Sales_Users" `
    -Members "david.smith"


# Step 5 — verify
Get-ADUser -Filter * |
    Select-Object Name, SamAccountName, Enabled

Get-ADGroupMember -Identity "IT_Admins" |
    Select-Object Name