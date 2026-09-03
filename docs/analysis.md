# Guia de Análise dos Resultados

Este documento descreve como interpretar os resultados dos scripts de monitorização de rede e identificar possíveis problemas.

---

## 📌 Introdução

Os scripts de monitorização geram logs que registam:

- **Perda de pacotes** (usando `ping`).
- **Rotas e tempos de resposta** (usando `traceroute` ou `mtr`).

Esses dados são essenciais para diagnosticar problemas de conectividade, como:

- Perda de pacotes.
- Rotas instáveis ou lentas.
- Congestionamento na rede.
- Falhas em roteadores ou switches.

---

## 📊 Interpretação dos Logs

### 1. Perda de Pacotes

Os logs do `monitor_ping.sh` e `monitor_network.sh` registam:

- **Pacotes enviados:** Número total de pacotes ICMP enviados.
- **Pacotes recebidos:** Número total de pacotes ICMP recebidos.
- **Perda (%): Percentagem de pacotes perdidos.**

#### 🔍 O que observar:

| Perda (%) | Interpretação | Ação Recomendada |
|-----------|---------------|------------------|
| 0% | Sem perda de pacotes. | Nenhuma ação necessária. |
| 1% - 5% | Perda muito baixa. | Monitorize para verificar se há padrão. |
| 6% - 10% | Perda moderada. | Investigue possíveis causas, como congestionamento. |
| > 10% | Perda alta. | Identifique a causa raiz: roteador com problemas, cabo defeituoso, etc. |

#### 📌 Exemplo de Log:
```
2026-09-03 08:00:00,10,8,20%
```
- **Interpretação:** 10 pacotes enviados, 8 recebidos, 20% de perda.
- **Ação:** Verifique a rota para identificar onde os pacotes estão sendo perdidos.

---

### 2. Rotas e Tempos de Resposta

Os logs do `monitor_traceroute.sh` e `monitor_network.sh` registam:

- **Saltos (hops):** Cada linha representa um salto na rota até o destino.
- **Endereço IP:** Endereço do roteador ou dispositivo naquele salto.
- **Tempo de resposta (ms):** Tempo que o pacote levou para chegar até aquele salto.

#### 🔍 O que observar:

| Situação | Interpretação | Ação Recomendada |
|----------|---------------|------------------|
| **Tempo de resposta alto (> 100ms)** | Latência elevada. | Verifique se há congestionamento ou problemas no roteador. |
| **Saltos repetidos ou loops** | Rota instável. | Verifique a configuração dos roteadores. |
| **Perda de pacotes em um salto específico** | Problema naquele roteador. | Teste a conectividade com o roteador ou substitua-o. |
| **Saltos desconhecidos ou não respondem** | Roteador com problemas. | Contate o administrador da rede ou substitua o dispositivo. |

#### 📌 Exemplo de Log:
```
2026-09-03 08:00:00,1 192.168.1.1 1.234 ms,2 10.0.0.1 5.678 ms,3 200.1.1.1 10.123 ms
```
- **Interpretação:** A rota tem 3 saltos, todos com tempos de resposta baixos.
- **Ação:** Nenhuma ação necessária, a rota está estável.

---

## 🔎 Identificação de Problemas

### 1. Perda de Pacotes em um Salto Específico

Se a perda de pacotes ocorrer em um salto específico no `traceroute`, siga estes passos:

1. **Identifique o salto com problemas:**
   - Exemplo: `3 200.1.1.1 *` (o asterisco indica perda de pacotes).

2. **Teste a conectividade com o roteador:**
   ```bash
   ping 200.1.1.1
   ```

3. **Verifique a configuração do roteador:**
   - Acesse o roteador e verifique se há regras de firewall bloqueando pacotes.
   - Verifique a carga do roteador (CPU, memória).

4. **Substitua o roteador (se necessário):**
   - Se o roteador estiver defeituoso, substitua-o.

---

### 2. Tempos de Resposta Altos

Se os tempos de resposta estiverem altos em um ou mais saltos:

1. **Verifique o tráfego na rede:**
   - Use ferramentas como `iftop` ou `nload` para monitorizar o tráfego.
   ```bash
   sudo iftop
   ```

2. **Identifique o congestionamento:**
   - Se um salto estiver com tráfego muito alto, pode ser necessário atualizar o hardware ou otimizar a rede.

3. **Verifique a configuração dos roteadores:**
   - Certifique-se de que o **QoS (Quality of Service)** está configurado corretamente.

---

### 3. Padrões de Horários

Se a perda de pacotes ou tempos de resposta altos ocorrerem em horários específicos:

1. **Verifique o uso da rede:**
   - Pergunte aos usuários se há um aumento de tráfego em determinados horários.

2. **Analise o tráfego:**
   - Use ferramentas como `nload` ou `vnstat` para monitorizar o tráfego ao longo do dia.
   ```bash
   vnstat -d
   ```

3. **Ajuste a infraestrutura:**
   - Se o congestionamento for frequente, considere atualizar a largura de banda ou otimizar a rede.

---

## 🛠 Ferramentas Adicionais para Diagnóstico

### 1. `mtr`

O `mtr` combina `ping` e `traceroute` em uma única ferramenta e fornece uma visão mais detalhada:

```bash
mtr --report --report-cycles 10 192.168.1.1
```

- **Saída:** Mostra a perda de pacotes e tempos de resposta para cada salto.
- **Vantagem:** Mais fácil de usar e interpretar do que `ping` + `traceroute` separados.

---

### 2. `iftop`

O `iftop` monitoriza o tráfego em tempo real em uma interface de rede:

```bash
sudo iftop
```

- **Saída:** Mostra o tráfego por conexão, facilitando a identificação de congestionamentos.

---

### 3. `vnstat`

O `vnstat` monitoriza o uso da largura de banda ao longo do tempo:

```bash
vnstat -d
```

- **Saída:** Mostra o uso diário da largura de banda.

---

## 📌 Exemplo Prático

### Cenário:
- **Problema:** Perda de pacotes de 20% para o IP `192.168.1.1`.
- **Log do `traceroute`:**
  ```
  1  192.168.1.1  1.234 ms
  2  10.0.0.1     5.678 ms
  3  200.1.1.1    *
  ```

### Diagnóstico:
1. **O salto 3 (`200.1.1.1`) não responde.**
2. **Possível causa:** Roteador com problemas ou cabo defeituoso.

### Ação:
1. **Teste a conectividade com o roteador:**
   ```bash
   ping 200.1.1.1
   ```
2. **Se não houver resposta:**
   - Reinicie o roteador.
   - Verifique o cabo de conexão.
   - Substitua o roteador (se necessário).

---

## 📌 Conclusão

Os logs gerados pelos scripts são ferramentas poderosas para diagnosticar problemas de rede. Siga este guia para:

1. **Identificar perda de pacotes.**
2. **Analisar rotas e tempos de resposta.**
3. **Tomar ações corretivas.**

Se o problema persistir, consulte um especialista em redes ou abra uma *Issue* no repositório para obter ajuda.

---

**Happy Monitoring! 🚀**