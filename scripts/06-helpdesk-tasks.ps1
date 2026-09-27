# ============================================
# Common Active Directory Help Desk Tasks
# ============================================
# IMPORTANT:
# This file documents multiple independent help-desk scenarios.
# Execute the sections individually rather than running the entire file at once.
# Some sections intentionally modify, lock, unlock, or disable lab accounts.

# --------------------------------------------
# 1. Password reset
# Run on DC01
# --------------------------------------------

$temporaryPassword = Read-Host `
    "Enter temporary password for bob.patel" `
    -AsSecureString

Set-ADAccountPassword `
    -Identity "bob.patel" `
    -Reset `
    -NewPassword $temporaryPassword

Set-ADUser `
    -Identity "bob.patel" `
    -ChangePasswordAtLogon $true

Get-ADUser `
    -Identity "bob.patel" `
    -Properties PasswordLastSet, PasswordExpired |
    Select-Object Name, PasswordLastSet, PasswordExpired


# --------------------------------------------
# 2. Simulate an account lockout
# Run this section from WS01
# --------------------------------------------

# Enter an intentionally incorrect password to generate failed logon attempts.
$badPassword = Read-Host `
    "Enter an intentionally incorrect password for the lockout test" `
    -AsSecureString

1..6 | ForEach-Object {

    $credential = New-Object `
        System.Management.Automation.PSCredential(
            "LAB\carol.jones",
            $badPassword
        )

    Start-Process `
        cmd.exe `
        -Credential $credential `
        -ArgumentList '/c exit' `
        -ErrorAction SilentlyContinue

    Start-Sleep -Milliseconds 500
}


# --------------------------------------------
# 3. Find and unlock the account
# Run on DC01
# --------------------------------------------

Search-ADAccount -LockedOut |
    Select-Object Name, SamAccountName, LastLogonDate

Unlock-ADAccount -Identity "carol.jones"

Get-ADUser `
    -Identity "carol.jones" `
    -Properties LockedOut |
    Select-Object Name, LockedOut


# --------------------------------------------
# 4. Disable a departing user's account
# --------------------------------------------

Disable-ADAccount -Identity "david.smith"

Search-ADAccount -AccountDisabled -UsersOnly |
    Select-Object Name, SamAccountName


# --------------------------------------------
# 5. Inactive account audit
# --------------------------------------------

Search-ADAccount `
    -AccountInactive `
    -UsersOnly `
    -TimeSpan 90.00:00:00 |
    Select-Object Name, SamAccountName, LastLogonDate


# --------------------------------------------
# 6. Group-membership audit
# --------------------------------------------

Get-ADPrincipalGroupMembership `
    -Identity "alice.chen" |
    Select-Object Name