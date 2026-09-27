# Install Active Directory Domain Services and management tools
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Confirm/install Group Policy Management Console
Install-WindowsFeature -Name GPMC