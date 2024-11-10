### Запускаем ssh-agent
$sshAgentOutput = & ssh-agent

# Разделяем вывод на строки и ищем нужные строки
$sshAuthSockLine = $sshAgentOutput | Where-Object { $_ -match "SSH_AUTH_SOCK=" }
$sshAgentPidLine = $sshAgentOutput | Where-Object { $_ -match "SSH_AGENT_PID=" }

# Извлекаем значения из строк
if ($sshAuthSockLine -and $sshAgentPidLine) {
    $env:SSH_AUTH_SOCK = ($sshAuthSockLine -split ';')[0].Split('=')[1].Trim()
    $env:SSH_AGENT_PID = ($sshAgentPidLine -split ';')[0].Split('=')[1].Trim()

}
else {
    Write-Host "Unable to extract variables from ssh-agent output."
}

### Добавляем ключ
ssh-add C:\Users\Администратор\.ssh\id_rsa

Write-Host "Ключ успешно загружен."