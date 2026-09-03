# Guia de Uso para Windows

Este guia explica como usar os scripts PowerShell para monitorizar a sua rede local em sistemas Windows.

---

## 📌 Pré-requisitos

1. **PowerShell**: Certifique-se de que está a usar o **PowerShell 5.1 ou superior**.
   - Para verificar a versão, execute:
     ```powershell
     $PSVersionTable.PSVersion
     ```

2. **Permissões**: Execute o PowerShell como **Administrador** para garantir que os comandos `ping` e `tracert` funcionam corretamente.

---

## 🚀 Como Usar os Scripts

### 1. Clone o Repositório
Clone o repositório para a sua máquina:
```powershell
git clone https://github.com/zBinnho/network-monitoring-scripts.git
cd network-monitoring-scripts
```

### 2. Navegue até a Pasta de Scripts
```powershell
cd scripts
```

### 3. Execute um Script
Escolha um dos scripts abaixo e execute-o:

#### 🔹 `monitor_ping.ps1` – Monitorizar Perdas de Pacotes
```powershell
.
monitor_ping.ps1
```
- **Parâmetros configuráveis**:
  - `$TARGET_IP`: IP ou host a monitorizar (ex: `192.168.1.1`).
  - `$PACKETS`: Número de pacotes a enviar (padrão: 10).
  - `$INTERVAL`: Intervalo entre verificações em segundos (padrão: 5).

#### 🔹 `monitor_traceroute.ps1` – Analisar Rotas
```powershell
.
monitor_traceroute.ps1
```
- **Parâmetros configuráveis**:
  - `$TARGET_IP`: IP ou host a analisar (ex: `192.168.1.1`).
  - `$INTERVAL`: Intervalo entre verificações em segundos (padrão: 10).

#### 🔹 `monitor_network.ps1` – Monitorizar Rede (Ping + Tracert)
```powershell
.
monitor_network.ps1
```
- Combina as funcionalidades dos dois scripts acima.

---

## 📝 Análise dos Resultados

Os logs são gerados automaticamente na pasta `logs/` com o nome:
- `packet_loss_log_<data>.txt` (para `monitor_ping.ps1`)
- `traceroute_log_<data>.txt` (para `monitor_traceroute.ps1`)
- `network_monitor_log_<data>.txt` (para `monitor_network.ps1`)

### 🔍 O que observar:
1. **Perda de Pacotes Alta**: Indica problemas no caminho entre o origem e o destino.
2. **Saltos Inconsistentes no Tracert**: Pode indicar roteadores com problemas ou configurações incorretas.
3. **Padrões de Horários**: Se a perda ocorrer em horários específicos, pode ser congestionamento na rede.

---

## 🛠 Solução de Problemas

### ❌ Erro: "Execution Policy" Bloqueia o Script
Se receber um erro relacionado à política de execução do PowerShell, execute:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### ❌ Erro: Comando `ping` ou `tracert` Não Reconhecido
Certifique-se de que está a executar o PowerShell como **Administrador**.

### ❌ Erro: Script Não Gera Logs
Verifique se a pasta `logs/` existe. Se não existir, crie-a manualmente:
```powershell
New-Item -ItemType Directory -Path "logs"
```

---

## 📚 Referências

- [Documentação Oficial do PowerShell](https://learn.microsoft.com/pt-pt/powershell/)
- [Comando `ping` no Windows](https://learn.microsoft.com/pt-pt/windows-server/administration/windows-commands/ping)
- [Comando `tracert` no Windows](https://learn.microsoft.com/pt-pt/windows-server/administration/windows-commands/tracert)