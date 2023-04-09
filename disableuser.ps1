# Set up Perforce Helix connection
$p4port = "p4server:1666"

# if enviroment variables are set this shouldn't be needed, this is also bad practice
$p4user = "your_username"
$p4password = "your_password"
$workspace = "your_workspace"

# connection
$p4 = New-Object -TypeName Perforce.P4 -ArgumentList @($p4port)
$p4.Login($p4password)
$p4.Client = $workspace

# Set the user to disable
$user = "user_to_disable"

# Disable the user
$p4.Run("user", "-f", "-d", $user)

# Log out of Perforce Helix
$p4.Logout()
