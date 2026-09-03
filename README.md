# Network Monitoring Scripts Repository

Este repositório contém scripts para monitorizar e diagnosticar problemas em redes locais, com foco em **perdas de pacotes**, **análise de rotas** e **monitorização contínua**.

## 📌 Objetivo
Facilitar a identificação de problemas de conectividade, perda de pacotes ou rotas instáveis em redes locais, fornecendo ferramentas automatizadas e documentação clara.

---

## 📂 Estrutura do Repositório
```
network-monitoring-scripts/
├── scripts/                  # Pasta com todos os scripts
│   ├── monitor_ping.sh       # Monitoriza perdas de pacotes usando `ping`
│   ├── monitor_traceroute.sh # Monitoriza rotas usando `traceroute`
│   ├── monitor_network.sh    # Combina `ping` e `traceroute` em um único script
│   └── README.md             # Documentação detalhada de cada script
├── docs/                     # Documentação adicional
│   ├── installation.md       # Como instalar e configurar dependências
│   ├── usage.md              # Como usar os scripts
│   └── analysis.md           # Como analisar os resultados
├── logs/                     # Exemplo de logs gerados pelos scripts (pasta vazia por padrão)
└── .github/ISSUE_TEMPLATE/   # Modelos para relatórios de problemas ou melhorias
```

---

## 🚀 Scripts Disponíveis

### 1. `monitor_ping.sh`
Monitoriza **perdas de pacotes** para um IP ou host específico.

**Funcionalidades:**
- Envia pacotes ICMP para um destino.
- Regista a quantidade de pacotes enviados, recebidos e a percentagem de perda.
- Salva os resultados em um arquivo de log.

**Como usar:**
1. Edite o script e substitua `TARGET_IP` pelo IP ou host que deseja monitorizar.
2. Dê permissão de execução: `chmod +x monitor_ping.sh`.
3. Execute: `./monitor_ping.sh`.
4. Os logs serão salvos em `logs/packet_loss_log.txt`.

**Exemplo de saída:**
```
[2026-09-03 08:00:00] Pacotes: 10 enviados, 8 recebidos, Perda: 20%
```

---

### 2. `monitor_traceroute.sh`
Monitoriza **rotas** para um IP ou host específico.

**Funcionalidades:**
- Regista a rota percorrida pelos pacotes até o destino.
- Ajuda a identificar onde os pacotes estão sendo perdidos ou onde há atrasos.
- Salva os resultados em um arquivo de log.

**Como usar:**
1. Edite o script e substitua `TARGET_IP` pelo IP ou host que deseja monitorizar.
2. Dê permissão de execução: `chmod +x monitor_traceroute.sh`.
3. Execute: `./monitor_traceroute.sh`.
4. Os logs serão salvos em `logs/traceroute_log.txt`.

**Exemplo de saída:**
```
[2026-09-03 08:00:00] Rota para 192.168.1.1:
1  192.168.1.1  1.234 ms
2  10.0.0.1     5.678 ms
3  200.1.1.1    10.123 ms
```

---

### 3. `monitor_network.sh`
Combina **`ping` e `traceroute`** em um único script para uma análise mais completa.

**Funcionalidades:**
- Monitoriza perdas de pacotes e rotas simultaneamente.
- Salva os resultados em um único arquivo de log.
- Ideal para diagnósticos rápidos e detalhados.

**Como usar:**
1. Edite o script e substitua `TARGET_IP` pelo IP ou host que deseja monitorizar.
2. Dê permissão de execução: `chmod +x monitor_network.sh`.
3. Execute: `./monitor_network.sh`.
4. Os logs serão salvos em `logs/network_monitor_log.txt`.

**Exemplo de saída:**
```
[2026-09-03 08:00:00] Ping: 10 enviados, 8 recebidos, Perda: 20%
[2026-09-03 08:00:00] Rota para 192.168.1.1:
1  192.168.1.1  1.234 ms
2  10.0.0.1     5.678 ms
3  200.1.1.1    10.123 ms
```

---

## 📖 Documentação

### Instalação
Para usar os scripts, certifique-se de que as seguintes ferramentas estão instaladas no seu sistema:

- **Linux (Debian/Ubuntu):**
  ```bash
  sudo apt-get update
  sudo apt-get install -y traceroute
  ```

- **Linux (CentOS/RHEL):**
  ```bash
  sudo yum install -y traceroute
  ```

- **macOS:**
  ```bash
  brew install traceroute
  ```

- **Windows:**
  Use o **PowerShell** ou instale o **Windows Subsystem for Linux (WSL)**.

---

### Análise dos Resultados
Após executar os scripts, analise os logs para identificar:

1. **Perda de pacotes alta:**
   - Indica problemas no caminho entre o origem e o destino.
   - Verifique se há congestionamento ou falhas em roteadores intermediários.

2. **Saltos inconsistentes no `traceroute`:**
   - Pode indicar roteadores com problemas ou configurações incorretas.
   - Verifique a estabilidade de cada salto na rota.

3. **Padrões de horários:**
   - Se a perda ocorrer em horários específicos, pode ser congestionamento na rede.

---

## 🛠 Ferramentas Adicionais (Opcionais)

### `mtr`
Combina `ping` e `traceroute` em uma única ferramenta.

**Instalação:**
- **Linux (Debian/Ubuntu):**
  ```bash
  sudo apt-get install -y mtr
  ```
- **Linux (CentOS/RHEL):**
  ```bash
  sudo yum install -y mtr
  ```

**Uso:**
```bash
mtr --report --report-cycles 10 192.168.1.1
```

### Grafana + Prometheus
Para uma solução mais avançada, configure o **Prometheus** para coletar métricas de rede e visualize os dados no **Grafana**.

---

## 🤝 Contribuições
Se você deseja contribuir com melhorias, correções ou novos scripts:

1. **Abra uma *Issue*** para discutir a sua ideia.
2. **Crie um *Pull Request*** com as suas alterações.
3. **Siga as boas práticas** de documentação e código.

---

## 📄 Licença
Este projeto está sob a licença **MIT**. Sinta-se à vontade para usar, modificar e distribuir os scripts.

---

## 📞 Suporte
Se tiver dúvidas ou problemas, abra uma **Issue** neste repositório.

---

**Happy Monitoring! 🚀**
