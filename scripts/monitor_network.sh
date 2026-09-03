#!/bin/bash

# Monitor de Rede (Combina Ping e Traceroute)
#
# Este script monitoriza tanto a perda de pacotes quanto a rota para um IP ou host específico.
# Os resultados são registados em um único arquivo de log para análise posterior.
#
# Autor: Assistente de IA
# Data: 2026-09-03
# Versão: 1.0

# Configurações
TARGET_IP="192.168.1.1"  # Substitua pelo IP ou host que deseja monitorizar
PACKETS=10               # Número de pacotes a enviar
INTERVAL=10              # Intervalo entre cada verificação (segundos)
LOG_FILE="logs/network_monitor_log.txt"  # Caminho do arquivo de log

# Cria o diretório de logs se não existir
mkdir -p logs

# Cabeçalho do log
echo "Data/Hora,Ping - Pacotes Enviados,Ping - Pacotes Recebidos,Ping - Perda (%),Traceroute - Rota" >> "$LOG_FILE"

# Loop principal
while true; do
    # Monitoramento com ping
    PING_OUTPUT=$(ping -c $PACKETS $TARGET_IP 2>&1)
    PACKETS_SENT=$(echo "$PING_OUTPUT" | grep -oP '\d+(?= packets transmitted)')
    PACKETS_RECEIVED=$(echo "$PING_OUTPUT" | grep -oP '\d+(?= received)')
    PACKET_LOSS=$(echo "$PING_OUTPUT" | grep -oP '\d+(?=%)')

    # Monitoramento com traceroute
    TRACEROUTE_OUTPUT=$(traceroute $TARGET_IP 2>&1)

    # Obtém data e hora atual
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Registra no log
    echo "$TIMESTAMP,$PACKETS_SENT,$PACKETS_RECEIVED,$PACKET_LOSS,\"$TRACEROUTE_OUTPUT\"" >> "$LOG_FILE"

    # Exibe no terminal
    echo "[$TIMESTAMP] Ping: $PACKETS_SENT enviados, $PACKETS_RECEIVED recebidos, Perda: $PACKET_LOSS%"
    echo "[$TIMESTAMP] Rota para $TARGET_IP:"
    echo "$TRACEROUTE_OUTPUT"
    echo "----------------------------------------"

    # Aguarda o próximo intervalo
    sleep $INTERVAL
done