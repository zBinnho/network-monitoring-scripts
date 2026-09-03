#!/bin/bash

# Monitor de Perdas de Pacotes com Ping
#
# Este script monitoriza a perda de pacotes para um IP ou host específico usando o comando `ping`.
# Os resultados são registados em um arquivo de log para análise posterior.
#
# Autor: Assistente de IA
# Data: 2026-09-03
# Versão: 1.0

# Configurações
TARGET_IP="192.168.1.1"  # Substitua pelo IP ou host que deseja monitorizar
PACKETS=10               # Número de pacotes a enviar
INTERVAL=5               # Intervalo entre cada verificação (segundos)
LOG_FILE="logs/packet_loss_log.txt"  # Caminho do arquivo de log

# Cria o diretório de logs se não existir
mkdir -p logs

# Cabeçalho do log
echo "Data/Hora,Pacotes Enviados,Pacotes Recebidos,Perdas (%)" >> "$LOG_FILE"

# Loop principal
while true; do
    # Captura a saída do ping
    PING_OUTPUT=$(ping -c $PACKETS $TARGET_IP 2>&1)

    # Extrai informações de perda de pacotes
    PACKETS_SENT=$(echo "$PING_OUTPUT" | grep -oP '\d+(?= packets transmitted)')
    PACKETS_RECEIVED=$(echo "$PING_OUTPUT" | grep -oP '\d+(?= received)')
    PACKET_LOSS=$(echo "$PING_OUTPUT" | grep -oP '\d+(?=%)')

    # Obtém data e hora atual
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Registra no log
    echo "$TIMESTAMP,$PACKETS_SENT,$PACKETS_RECEIVED,$PACKET_LOSS" >> "$LOG_FILE"

    # Exibe no terminal
    echo "[$TIMESTAMP] Pacotes: $PACKETS_SENT enviados, $PACKETS_RECEIVED recebidos, Perda: $PACKET_LOSS%"

    # Aguarda o próximo intervalo
    sleep $INTERVAL
done