# 🌐 Network Monitoring Scripts

Este repositório contém scripts para monitorizar e diagnosticar problemas em **redes locais**, como perdas de pacotes e rotas com problemas. São fornecidas versões para **Linux (Bash)** e **Windows (PowerShell)**.

---

## 📁 Estrutura do Repositório

```
network-monitoring-scripts/
│
├── scripts/
│   ├── monitor_ping.sh          # Monitoriza perdas de pacotes (Linux)
│   ├── monitor_traceroute.sh    # Analisa rotas (Linux)
│   ├── monitor_network.sh       # Script integrado (Linux)
│   ├── monitor_ping.ps1         # Monitoriza perdas de pacotes (Windows)
│   ├── monitor_traceroute.ps1   # Analisa rotas (Windows)
│   └── monitor_network.ps1      # Script integrado (Windows)
│
├── docs/
│   ├── installation.md          # Como instalar dependências
│   ├── usage.md                 # Como usar os scripts (Linux)
│   └── windows_usage.md         # Como usar os scripts (Windows)
│
├── logs/                        # Pasta para armazenar logs (criada automaticamente)
│
└── README.md                    # Este arquivo
```

---

## 🚀 Como Começar

### 1. Clone o Repositório
```bash
# Clone o repositório
git clone https://github.com/zBinnho/network-monitoring-scripts.git
cd network-monitoring-scripts
```

### 2. Escolha o Sistema Operacional
- **Linux**: Use os scripts `.sh`.
- **Windows**: Use os scripts `.ps1`.

### 3. Execute o Script Desejado
#### 🔹 **Linux (Bash)**
```bash
# Dê permissão de execução
chmod +x scripts/*.sh

# Execute o script
./scripts/monitor_ping.sh
```

#### 🔹 **Windows (PowerShell)**
```powershell
# Navegue até a pasta scripts
cd scripts

# Execute o script (como Administrador)
.
monitor_ping.ps1
```

---

## 📖 Documentação

| Sistema       | Link para a Documentação          |
|---------------|-----------------------------------|
| **Linux**     | [docs/usage.md](docs/usage.md)     |
| **Windows**   | [docs/windows_usage.md](docs/windows_usage.md) |


---

## 📝 Exemplos de Uso

### 🔹 Monitorizar Perdas de Pacotes
```bash
./scripts/monitor_ping.sh
```

### 🔹 Analisar Rotas
```bash
./scripts/monitor_traceroute.sh
```

### 🔹 Monitorizar Rede (Ping + Tracert)
```bash
./scripts/monitor_network.sh
```

---

## 📊 Análise dos Resultados
Os logs são gerados automaticamente na pasta `logs/` e incluem:
- Data e hora de cada verificação.
- Número de pacotes enviados/recebidos.
- Percentual de perda de pacotes.
- Detalhes da rota (para `traceroute`/`tracert`).

---

## 🛠 Solução de Problemas
- **Linux**: Verifique se os comandos `ping` e `traceroute` estão instalados.
- **Windows**: Execute o PowerShell como **Administrador**.

---

## 🤝 Contribuir
Se encontrar um problema ou quiser adicionar uma nova funcionalidade, sinta-se à vontade para abrir uma **Issue** ou enviar um **Pull Request**!

---

## 📜 Licença
Este projeto está licenciado sob a [MIT License](LICENSE).

---

**Happy Monitoring!** 🚀

Se precisar de ajuda, abra uma **Issue** no repositório ou entre em contato!