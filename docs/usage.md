# Guia de Uso dos Scripts

Este documento descreve como usar os scripts de monitorização de rede disponíveis neste repositório.

---

## 📌 Pré-requisitos

Antes de usar os scripts, certifique-se de que:

1. As dependências (`ping`, `traceroute` ou `mtr`) estão instaladas. Consulte o guia de [instalação](./installation.md).
2. Os scripts têm permissão de execução. Se não tiverem, use:
   ```bash
   chmod +x monitor_ping.sh
   chmod +x monitor_traceroute.sh
   chmod +x monitor_network.sh
   ```

---

## 📂 Estrutura dos Scripts

Os scripts estão localizados na pasta `scripts/` e são:

| Script | Descrição |
|--------|-----------|
| `monitor_ping.sh` | Monitoriza perdas de pacotes usando `ping`. |
| `monitor_traceroute.sh` | Monitoriza rotas usando `traceroute`. |
| `monitor_network.sh` | Combina `ping` e `traceroute` em um único script. |

---

## 🚀 Como Usar Cada Script

### 1. `monitor_ping.sh`

**Objetivo:** Monitorizar perdas de pacotes para um IP ou host específico.

**Passos:**

1. **Edite o script:**
   Abra o arquivo `monitor_ping.sh` e substitua `TARGET_IP="192.168.1.1"` pelo IP ou host que deseja monitorizar.

2. **Execute o script:**
   ```bash
   ./monitor_ping.sh
   ```

3. **Resultados:**
   - Os logs serão salvos no arquivo `logs/packet_loss_log.txt`.
   - Exemplo de saída:
     ```
     [2026-09-03 08:00:00] Pacotes: 10 enviados, 8 recebidos, Perda: 20%
     ```

---

### 2. `monitor_traceroute.sh`

**Objetivo:** Monitorizar a rota para um IP ou host específico.

**Passos:**

1. **Edite o script:**
   Abra o arquivo `monitor_traceroute.sh` e substitua `TARGET_IP="192.168.1.1"` pelo IP ou host que deseja monitorizar.

2. **Execute o script:**
   ```bash
   ./monitor_traceroute.sh
   ```

3. **Resultados:**
   - Os logs serão salvos no arquivo `logs/traceroute_log.txt`.
   - Exemplo de saída:
     ```
     [2026-09-03 08:00:00] Rota para 192.168.1.1:
     1  192.168.1.1  1.234 ms
     2  10.0.0.1     5.678 ms
     3  200.1.1.1    10.123 ms
     ```

---

### 3. `monitor_network.sh`

**Objetivo:** Combinar `ping` e `traceroute` em um único script para uma análise mais completa.

**Passos:**

1. **Edite o script:**
   Abra o arquivo `monitor_network.sh` e substitua `TARGET_IP="192.168.1.1"` pelo IP ou host que deseja monitorizar.

2. **Execute o script:**
   ```bash
   ./monitor_network.sh
   ```

3. **Resultados:**
   - Os logs serão salvos no arquivo `logs/network_monitor_log.txt`.
   - Exemplo de saída:
     ```
     [2026-09-03 08:00:00] Ping: 10 enviados, 8 recebidos, Perda: 20%
     [2026-09-03 08:00:00] Rota para 192.168.1.1:
     1  192.168.1.1  1.234 ms
     2  10.0.0.1     5.678 ms
     3  200.1.1.1    10.123 ms
     ```

---

## 📝 Personalização dos Scripts

### Alterar o Intervalo de Monitorização

- **No `monitor_ping.sh`:**
  Altere a variável `INTERVAL` para definir o tempo (em segundos) entre cada verificação.
  Exemplo:
  ```bash
  INTERVAL=10  # Verifica a cada 10 segundos
  ```

- **No `monitor_traceroute.sh`:**
  Altere a variável `INTERVAL` para definir o tempo (em segundos) entre cada verificação.
  Exemplo:
  ```bash
  INTERVAL=15  # Verifica a cada 15 segundos
  ```

- **No `monitor_network.sh`:**
  Altere a variável `INTERVAL` para definir o tempo (em segundos) entre cada verificação.
  Exemplo:
  ```bash
  INTERVAL=20  # Verifica a cada 20 segundos
  ```

### Alterar o Número de Pacotes

- **No `monitor_ping.sh` e `monitor_network.sh`:**
  Altere a variável `PACKETS` para definir quantos pacotes serão enviados em cada verificação.
  Exemplo:
  ```bash
  PACKETS=20  # Envia 20 pacotes
  ```

---

## 🔍 Análise dos Resultados

Após executar os scripts, analise os logs para identificar problemas:

1. **Perda de pacotes alta:**
   - Se a perda for superior a **10%**, pode indicar problemas na rede.
   - Verifique se há congestionamento ou falhas em roteadores intermediários.

2. **Saltos inconsistentes no `traceroute`:**
   - Se algum salto apresentar tempo de resposta muito alto ou perda de pacotes, pode indicar um problema naquele roteador.

3. **Padrões de horários:**
   - Se a perda ocorrer em horários específicos (ex: horário comercial), pode ser congestionamento na rede.

---

## 🛠 Ferramentas Adicionais

### Usando `mtr`

O `mtr` combina `ping` e `traceroute` em uma única ferramenta. Para usá-lo:

1. **Instale o `mtr`:** Consulte o guia de [instalação](./installation.md).
2. **Execute o comando:**
   ```bash
   mtr --report --report-cycles 10 192.168.1.1
   ```
   - `--report-cycles 10`: Define o número de verificações.
   - `192.168.1.1`: Substitua pelo IP ou host que deseja monitorizar.

---

## 📌 Dicas

- **Execute os scripts em segundo plano:**
  Para evitar que o terminal fique bloqueado, execute os scripts em segundo plano:
  ```bash
  ./monitor_ping.sh &
  ```

- **Verifique os logs em tempo real:**
  Use o comando `tail` para acompanhar os logs em tempo real:
  ```bash
  tail -f logs/packet_loss_log.txt
  ```

---

Se tiver dúvidas ou problemas, consulte a documentação ou abra uma *Issue* no repositório.