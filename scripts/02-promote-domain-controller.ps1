# Import the AD DS deployment module
Import-Module ADDSDeployment

# Promote DC01 and create the lab.local forest
# DSRM password is requested securely instead of being stored in the script.
Install-ADDSForest `
    -DomainName "lab.local" `
    -DomainNetbiosName "LAB" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (Read-Host -AsSecureString "Enter a DSRM password") `
    -Force:$true