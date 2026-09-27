Write-Host "=== DOMAIN CONTROLLER ===" -ForegroundColor Cyan
Get-ADDomainController |
    Format-Table Name, Domain, Forest, IPv4Address -AutoSize


Write-Host "=== ORGANIZATIONAL UNITS ===" -ForegroundColor Cyan
(Get-ADOrganizationalUnit -Filter *).Name -join ", "


Write-Host "`n=== USERS ===" -ForegroundColor Cyan
Get-ADUser -Filter * |
    Format-Table Name, SamAccountName, Enabled -AutoSize


Write-Host "=== IT_ADMINS MEMBERS ===" -ForegroundColor Cyan
(Get-ADGroupMember "IT_Admins").Name -join ", "


Write-Host "`n=== GPO LINK ===" -ForegroundColor Cyan
(Get-GPInheritance `
    -Target "OU=IT,DC=lab,DC=local").GpoLinks |
    Format-Table DisplayName, Enabled -AutoSize


Write-Host "=== FINE-GRAINED PASSWORD POLICY ===" -ForegroundColor Cyan
Get-ADUserResultantPasswordPolicy "alice.chen" |
    Format-Table Name,
                 MinPasswordLength,
                 ComplexityEnabled `
                 -AutoSize


Write-Host "=== DOMAIN LOCKOUT POLICY ===" -ForegroundColor Cyan
Get-ADDefaultDomainPasswordPolicy |
    Format-Table LockoutThreshold,
                 LockoutDuration `
                 -AutoSize