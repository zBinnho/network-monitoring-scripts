#!/bin/bash

# Monitor de Rotas com Traceroute
#
# Este script monitoriza a rota para um IP ou host específico usando o comando `traceroute`.
# Os resultados são registados em um arquivo de log para análise posterior.
#
# Autor: Assistente de IA
# Data: 2026-09-03
# Versão: 1.0

# Configurações
TARGET_IP="192.168.1.1"  # Substitua pelo IP ou host que deseja monitorizar
INTERVAL=10              # Intervalo entre cada verificação (segundos)
LOG_FILE="logs/traceroute_log.txt"  # Caminho do arquivo de log

# Cria o diretório de logs se não existir
mkdir -p logs

# Cabeçalho do log
echo "Data/Hora,Rota" >> "$LOG_FILE"

# Loop principal
while true; do
    # Captura a saída do traceroute
    TRACEROUTE_OUTPUT=$(traceroute $TARGET_IP 2>&1)

    # Obtém data e hora atual
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Registra no log
    echo "$TIMESTAMP,$TRACEROUTE_OUTPUT" >> "$LOG_FILE"

    # Exibe no terminal
    echo "[$TIMESTAMP] Rota para $TARGET_IP:"
    echo "$TRACEROUTE_OUTPUT"
    echo "----------------------------------------"

    # Aguarda o próximo intervalo
    sleep $INTERVAL
done