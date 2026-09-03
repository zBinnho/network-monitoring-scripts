# Instruções de Instalação

Este documento descreve como instalar e configurar as dependências necessárias para executar os scripts de monitorização de rede.

## Pré-requisitos

- **Sistema Operacional:** Linux (Debian/Ubuntu, CentOS/RHEL), macOS ou Windows (com WSL).
- **Permissões:** Acesso de administrador para instalar pacotes.
- **Ferramentas:** `ping`, `traceroute` (ou `mtr`).

---

## Instalação no Linux (Debian/Ubuntu)

1. **Atualize os pacotes:**
   ```bash
   sudo apt-get update
   ```

2. **Instale o `traceroute`:**
   ```bash
   sudo apt-get install -y traceroute
   ```

3. **Instale o `mtr` (opcional):**
   ```bash
   sudo apt-get install -y mtr
   ```

---

## Instalação no Linux (CentOS/RHEL)

1. **Atualize os pacotes:**
   ```bash
   sudo yum update -y
   ```

2. **Instale o `traceroute`:**
   ```bash
   sudo yum install -y traceroute
   ```

3. **Instale o `mtr` (opcional):**
   ```bash
   sudo yum install -y mtr
   ```

---

## Instalação no macOS

1. **Instale o `traceroute` usando o Homebrew:**
   ```bash
   brew install traceroute
   ```

2. **Instale o `mtr` (opcional):**
   ```bash
   brew install mtr
   ```

---

## Instalação no Windows

### Opção 1: Usar o PowerShell
1. O PowerShell já inclui o comando `ping`.
2. Para o `traceroute`, use:
   ```powershell
   Test-NetConnection -ComputerName "192.168.1.1" -TraceRoute
   ```

### Opção 2: Usar o WSL (Windows Subsystem for Linux)
1. **Ative o WSL:**
   ```powershell
   wsl --install
   ```
2. **Instale uma distribuição Linux (ex: Ubuntu):**
   ```powershell
   wsl --install -d Ubuntu
   ```
3. **Abra o WSL e instale as dependências:**
   ```bash
   sudo apt-get update
   sudo apt-get install -y traceroute
   ```

---

## Verificação das Instalações

Após instalar as dependências, verifique se estão funcionando corretamente:

- **Para `ping`:**
  ```bash
  ping -c 4 8.8.8.8
  ```

- **Para `traceroute`:**
  ```bash
  traceroute 8.8.8.8
  ```

- **Para `mtr` (opcional):**
  ```bash
  mtr --version
  ```

---

## Solução de Problemas

- **Erro: `traceroute` não encontrado:**
  Certifique-se de que o pacote foi instalado corretamente. Tente reinstalar:
  ```bash
  sudo apt-get install --reinstall traceroute  # Debian/Ubuntu
  sudo yum reinstall traceroute               # CentOS/RHEL
  ```

- **Permissão negada:**
  Execute os scripts com privilégios de administrador ou use `sudo`.

---

Se encontrar problemas, consulte a documentação oficial das ferramentas ou abra uma *Issue* no repositório.