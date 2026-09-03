# PowerShell Script Integrado para Monitorizar Rede (Ping + Tracert)
# Autor: Assistente
# Data: 2026-09-03
# Descrição: Monitoriza perdas de pacotes e analisa rotas em uma rede local.

# Configurações
$TARGET_IP = "192.175.6.50"  # Substitua pelo IP ou host que deseja monitorizar
$PACKETS = 10                 # Número de pacotes a enviar
$INTERVAL = 10                # Intervalo entre cada verificação (segundos)
$LOG_FILE = "logs\network_monitor_log_$(Get-Date -Format 'yyyyMMdd').txt"

# Criar diretório de logs se não existir
if (!(Test-Path -Path "logs")) {
    New-Item -ItemType Directory -Path "logs" | Out-Null
}

# Cabeçalho do log
"Data/Hora,Ping - Pacotes Enviados,Ping - Pacotes Recebidos,Ping - Perda (%),Tracert - Rota" | Out-File -FilePath $LOG_FILE -Append

Write-Host "Monitorizando rede para $TARGET_IP... (Pressione Ctrl+C para parar)"

while ($true) {
    # Monitorização com Ping
    $PING_OUTPUT = ping -n $PACKETS $TARGET_IP
    $PACKETS_SENT = ($PING_OUTPUT | Select-String -Pattern "(\d+) pacotes transmitidos").Matches.Groups[1].Value
    $PACKETS_RECEIVED = ($PING_OUTPUT | Select-String -Pattern "(\d+) recebidos").Matches.Groups[1].Value
    $PACKET_LOSS = ($PACKETS_SENT - $PACKETS_RECEIVED)

    # Monitorização com Tracert
    $TRACERT_OUTPUT = tracert -h 10 $TARGET_IP

    # Obter data e hora atual
    $TIMESTAMP = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Regista no log
    "$TIMESTAMP,$PACKETS_SENT,$PACKETS_RECEIVED,$PACKET_LOSS,`"$TRACERT_OUTPUT`"" | Out-File -FilePath $LOG_FILE -Append

    # Exibe no terminal
    Write-Host "$TIMESTAMP Ping: $PACKETS_SENT enviados, $PACKETS_RECEIVED recebidos, Perda: $PACKET_LOSS%"
    Write-Host "Tracert para $TARGET_IP:"
    Write-Host $TRACERT_OUTPUT

    # Aguarda o próximo intervalo
    Start-Sleep -Seconds $INTERVAL
}
