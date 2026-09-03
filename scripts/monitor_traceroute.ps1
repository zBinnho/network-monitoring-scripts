# PowerShell Script para Analisar Rotas com Tracert
# Autor: Assistente
# Data: 2026-09-03
# Descrição: Analisa a rota para um IP/host específico em uma rede local.

# Configurações
$TARGET_IP = "192.168.1.1"  # Substitua pelo IP ou host que deseja monitorar
$INTERVAL = 10              # Intervalo entre cada verificação (segundos)
$LOG_FILE = "logs\\traceroute_log_$(Get-Date -Format 'yyyyMMdd').txt"

# Criar diretório de logs se não existir
if (!(Test-Path -Path "logs")) {
    New-Item -ItemType Directory -Path "logs" | Out-Null
}

# Cabeçalho do log
"Data/Hora,Rota" | Out-File -FilePath $LOG_FILE -Append

Write-Host "Analisando rotas para $TARGET_IP... (Pressione Ctrl+C para parar)"

while ($true) {
    # Captura a saída do tracert
    $TRACERT_OUTPUT = tracert -h 10 $TARGET_IP

    # Obtém data e hora atual
    $TIMESTAMP = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Registra no log
    "$TIMESTAMP,\"$TRACERT_OUTPUT\"" | Out-File -FilePath $LOG_FILE -Append

    # Exibe no terminal
    Write-Host "[$TIMESTAMP] Rota para $TARGET_IP:"
    Write-Host $TRACERT_OUTPUT
    Write-Host "----------------------------------------"

    # Aguarda o próximo intervalo
    Start-Sleep -Seconds $INTERVAL
}