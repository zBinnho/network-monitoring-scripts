# Script: monitor_network.ps1
# Descrição: Monitora uma rede local para identificar perdas de pacotes e problemas de conectividade.
# Autor: [Seu Nome]
# Data: 03/09/2026

# Parâmetros de configuração
$TARGET_IP = "8.8.8.8"  # Exemplo: IP do Google DNS para teste
$PACKETS_TO_SEND = 100   # Número de pacotes a enviar
$PACKET_SIZE = 56        # Tamanho do pacote em bytes
$TIMEOUT = 1000           # Timeout em milissegundos
$OUTPUT_FILE = "network_monitor_results.txt"

function Test-NetworkPacketLoss {
    param (
        [string]$TargetIP,
        [int]$PacketsToSend,
        [int]$PacketSize,
        [int]$Timeout
    )
    
    # Inicializa contadores
    $packetsSent = 0
    $packetsReceived = 0
    $packetLoss = 0
    
    # Executa o teste com Test-NetConnection (PowerShell 5.1+)
    try {
        $result = Test-NetConnection -ComputerName $TargetIP -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue
        
        if ($result) {
            Write-Host "[`$TIMESTAMP] Conexão bem-sucedida com $TargetIP.`n"
        } else {
            Write-Host "[`$TIMESTAMP] Não foi possível conectar a $TargetIP.`n"
            return
        }
    } catch {
        Write-Host "[`$TIMESTAMP] Erro ao testar conexão com $TargetIP: $_`n"
        return
    }
    
    # Loop para enviar pacotes (simulação)
    for ($i = 0; $i -lt $PacketsToSend; $i++) {
        $packetsSent++
        
        # Simula um ping (substitua pelo comando real se necessário)
        $pingResult = Test-NetConnection -ComputerName $TargetIP -Count 1 -TimeoutMilliseconds $Timeout -WarningAction SilentlyContinue
        
        if ($pingResult.TcpTestSucceeded) {
            $packetsReceived++
        } else {
            $packetLoss++
        }
    }
    
    # Calcula a porcentagem de perda de pacotes
    if ($packetsSent -gt 0) {
        $packetLossPercentage = ($packetLoss / $packetsSent) * 100
    } else {
        $packetLossPercentage = 0
    }
    
    # Exibe resultados
    Write-Host "[`$TIMESTAMP] Teste concluído para $TargetIP:`n"
    Write-Host "Pacotes enviados: $packetsSent`nPacotes recebidos: $packetsReceived`nPerda de pacotes: $packetLossPercentage%`n"
    
    # Retorna resultados
    return @{
        PacketsSent = $packetsSent
        PacketsReceived = $packetsReceived
        PacketLoss = $packetLossPercentage
    }
}

function Test-NetworkRoute {
    param (
        [string]$TargetIP
    )
    
    # Captura a rota para o IP de destino
    try {
        $tracertOutput = Test-NetConnection -ComputerName $TargetIP -TraceRoute -InformationLevel Detailed -WarningAction SilentlyContinue
        
        if ($tracertOutput) {
            Write-Host "[`$TIMESTAMP] Rota para $TargetIP:`n"
            $tracertOutput | Format-Table -AutoSize | Out-String | Write-Host
        } else {
            Write-Host "[`$TIMESTAMP] Não foi possível capturar a rota para $TargetIP.`n"
        }
    } catch {
        Write-Host "[`$TIMESTAMP] Erro ao capturar rota para $TargetIP: $_`n"
    }
}

# Executa os testes
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Teste de perda de pacotes
$packetLossResult = Test-NetworkPacketLoss -TargetIP $TARGET_IP -PacketsToSend $PACKETS_TO_SEND -PacketSize $PACKET_SIZE -Timeout $TIMEOUT

# Teste de rota
Test-NetworkRoute -TargetIP $TARGET_IP

# Salva resultados em arquivo
if ($packetLossResult) {
    $output = @"
[Relatório de Monitoramento de Rede - $timestamp]
===============================================

IP Alvo: $TARGET_IP
Pacotes Enviados: $($packetLossResult.PacketsSent)
Pacotes Recebidos: $($packetLossResult.PacketsReceived)
Perda de Pacotes: $($packetLossResult.PacketLoss)%

"@
    
    # Salva no arquivo
    $output | Out-File -FilePath $OUTPUT_FILE -Append
    Write-Host "Resultados salvos em: $OUTPUT_FILE`n"
}
