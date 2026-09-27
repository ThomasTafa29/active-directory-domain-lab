# Create a Fine-Grained Password Policy for the IT administrators

New-ADFineGrainedPasswordPolicy `
    -Name "IT-Admins-PSO" `
    -Precedence 10 `
    -MinPasswordLength 12 `
    -ComplexityEnabled $true `
    -PasswordHistoryCount 24 `
    -MinPasswordAge 0.00:00:00 `
    -MaxPasswordAge 90.00:00:00 `
    -LockoutThreshold 5 `
    -LockoutDuration 00:15:00 `
    -LockoutObservationWindow 00:15:00

# Apply the PSO to the IT_Admins security group
Add-ADFineGrainedPasswordPolicySubject `
    -Identity "IT-Admins-PSO" `
    -Subjects "IT_Admins"

# Verify the resultant password policy for Alice
Get-ADUserResultantPasswordPolicy -Identity "alice.chen" |
    Select-Object Name,
                  MinPasswordLength,
                  PasswordHistoryCount,
                  ComplexityEnabled,
                  MinPasswordAge,
                  MaxPasswordAge,
                  LockoutThreshold,
                  LockoutDuration,
                  LockoutObservationWindow