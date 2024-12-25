$ComputerName = "TargetComputerName"  # Replace with the remote computer's name or IP
$Username = "AdminUsername"           # Replace with an admin username
$Password = "AdminPassword"           # Replace with the admin password
$ProductKey = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"  # Replace with your Windows 11 product key

# Create a PSCredential object
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

# Define the WMI command
$Command = "cscript.exe c:\windows\system32\slmgr.vbs /ipk $ProductKey"

# Execute the command remotely
Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    param ($Command)
    Invoke-Expression $Command
} -ArgumentList $Command

$ActivationCommand = "cscript.exe c:\windows\system32\slmgr.vbs /ato"

Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    param ($ActivationCommand)
    Invoke-Expression $ActivationCommand
} -ArgumentList $ActivationCommand
