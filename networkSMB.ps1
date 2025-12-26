# Initialize GUI components
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Amazing Network Drive Connection Launcher"
$form.Size = New-Object System.Drawing.Size(800, 500)
$form.StartPosition = "CenterScreen"
$form.KeyPreview = $true  # Important to capture key events

# Font size for all controls
$font = New-Object System.Drawing.Font("Arial", 14)

# Username label and input box
$usernameLabel = New-Object System.Windows.Forms.Label
$usernameLabel.Text = "Username:"
$usernameLabel.Location = New-Object System.Drawing.Point(40, 60)
$usernameLabel.Size = New-Object System.Drawing.Size(200, 40)
$usernameLabel.Font = $font
$form.Controls.Add($usernameLabel)

$usernameInput = New-Object System.Windows.Forms.TextBox
$usernameInput.Location = New-Object System.Drawing.Point(300, 60)
$usernameInput.Size = New-Object System.Drawing.Size(400, 40)
$usernameInput.Font = $font
$form.Controls.Add($usernameInput)

# Password label and input box
$passwordLabel = New-Object System.Windows.Forms.Label
$passwordLabel.Text = "Password:"
$passwordLabel.Location = New-Object System.Drawing.Point(40, 140)
$passwordLabel.Size = New-Object System.Drawing.Size(200, 40)
$passwordLabel.Font = $font
$form.Controls.Add($passwordLabel)

$passwordInput = New-Object System.Windows.Forms.TextBox
$passwordInput.Location = New-Object System.Drawing.Point(300, 140)
$passwordInput.Size = New-Object System.Drawing.Size(400, 40)
$passwordInput.Font = $font
$passwordInput.UseSystemPasswordChar = $true
$form.Controls.Add($passwordInput)

# Status label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = ""
$statusLabel.Location = New-Object System.Drawing.Point(40, 220)
$statusLabel.Size = New-Object System.Drawing.Size(700, 80)
$statusLabel.Font = $font
$form.Controls.Add($statusLabel)

# Submit button
$submitButton = New-Object System.Windows.Forms.Button
$submitButton.Text = "Login"
$submitButton.Location = New-Object System.Drawing.Point(300, 320)
$submitButton.Size = New-Object System.Drawing.Size(240, 60)
$submitButton.Font = $font

# Button click action
$submitButton.Add_Click({
    $username = $usernameInput.Text
    $password = $passwordInput.Text

    # Check if both fields are filled
    if (-not $username -or -not $password) {
        $statusLabel.Text = "Please enter both username and password!"
        return
    }

    # Execute the network drive mapping command
    $command = "net use Z: \\IP\home\Documents /user:$username $password"
    $result = cmd /c $command 2>&1

    if ($LASTEXITCODE -eq 0) {
        $statusLabel.Text = "Connect success! Please check in File Explorer`nExit in 5 seconds"
        Start-Sleep -Seconds 5
        $form.Close()
    } else {
        $statusLabel.Text = "Invalid username or password."
    }
})
$form.Controls.Add($submitButton)

# Capture the Enter key press and trigger the submit button click
$form.Add_KeyDown({
    param ($sender, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Enter) {
        $submitButton.PerformClick()
    }
})

# Show the form
[void]$form.ShowDialog()
