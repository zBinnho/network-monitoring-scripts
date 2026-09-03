# PowerShell Script para Monitorizar Perdas de Pacotes
# Autor: Assistente
# Data: 2026-09-03
# Descrição: Monitoriza a perda de pacotes para um IP/host específico em uma rede local.

# Configurações
$TARGET_IP = "192.168.1.1"  # Substitua pelo IP ou host que deseja monitorar
$PACKETS = 10                # Número de pacotes a enviar
$INTERVAL = 5               # Intervalo entre cada verificação (segundos)
$LOG_FILE = "logs\\packet_loss_log_$(Get-Date -Format 'yyyyMMdd').txt"

# Criar diretório de logs se não existir
if (!(Test-Path -Path "logs")) {
    New-Item -ItemType Directory -Path "logs" | Out-Null
}

# Cabeçalho do log
"Data/Hora,Pacotes Enviados,Pacotes Recebidos,Perdas (%)" | Out-File -FilePath $LOG_FILE -Append

Write-Host "Monitorizando perdas de pacotes para $TARGET_IP... (Pressione Ctrl+C para parar)"

while ($true) {
    # Captura a saída do ping
    $PING_OUTPUT = ping -n $PACKETS $TARGET_IP

    # Extrai informações de perda de pacotes
    $PACKETS_SENT = ($PING_OUTPUT | Select-String -Pattern "(\d+) pacotes transmitidos").Matches.Groups[1].Value
    $PACKETS_RECEIVED = ($PING_OUTPUT | Select-String -Pattern "(\d+) recebidos").Matches.Groups[1].Value
    $PACKET_LOSS = ($PING_OUTPUT | Select-String -Pattern "(\d+)%").Matches.Groups[1].Value

    # Obtém data e hora atual
    $TIMESTAMP = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Registra no log
    "$TIMESTAMP,$PACKETS_SENT,$PACKETS_RECEIVED,$PACKET_LOSS" | Out-File -FilePath $LOG_FILE -Append

    # Exibe no terminal
    Write-Host "[$TIMESTAMP] Pacotes: $PACKETS_SENT enviados, $PACKETS_RECEIVED recebidos, Perda: $PACKET_LOSS%"

    # Aguarda o próximo intervalo
    Start-Sleep -Seconds $INTERVAL
}