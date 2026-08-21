# DETERMINISTIC ROUTING SPECIFICATION (v1.0)
## Algoritmo Matemático de Scoring, Tie-Breaking e Reprodutibilidade no Weaver Router

---

### 1. O PRINCÍPIO DO DETERMINISMO ABSOLUTO
Duas requisições com a mesma intenção, a mesma capability e o mesmo estado operacional dos provedores **DEVEM obrigatoriamente produzir a mesma decisão de roteamento**.
É estritamente proibido o uso de `Math.random()`, ordenação não determinística de `Map`/`Set`, heurísticas implícitas ou timestamps como critério de escolha.

---

### 2. A FÓRMULA DE SCORING DO WEAVER
Para cada provedor compatível com a capability solicitada, o Weaver calcula a pontuação:

$$\text{TotalScore} = (10 \times \text{Priority}) + (5 \times \text{HealthScore}) + (5 \times \text{AuthScore}) + (2 \times \text{RiskScore}) + \text{LatencyScore}$$

#### Tabelas de Pesos de Componentes:
- **Priority:** Valor numérico declarado no `ProviderDefinition` ($0$ a $1000$).
- **HealthScore:**
  - `HEALTHY`: 100 pontos
  - `DEGRADED`: 50 pontos
  - `UNKNOWN`: 20 pontos
  - `UNHEALTHY` / `DISABLED`: 0 pontos (desqualificado)
- **AuthScore:**
  - `VERIFIED`: 100 pontos
  - `AUTHENTICATED`: 90 pontos
  - `CONFIGURED`: 50 pontos
  - `DISCOVERED`: 10 pontos
  - `REVOKED`: 0 pontos (desqualificado)
- **RiskScore:**
  - `ZERO`: 100 pontos
  - `LOW`: 80 pontos
  - `MEDIUM`: 50 pontos
  - `HIGH`: 20 pontos
  - `CRITICAL`: 0 pontos
- **LatencyScore:**
  - $\max(0, 100 - \lfloor\text{timeoutMs} / 100\rfloor)$

---

### 3. PROTOCOLO DE DESEMPATE (TIE-BREAKING ORDER)
Em caso de igualdade de `TotalScore`, o Weaver aplica uma cascata determinística de ordenação léxica e estrutural:

$$\text{TotalScore} \downarrow \;\longrightarrow\; \text{Priority} \downarrow \;\longrightarrow\; \text{Provider ID (A-Z)} \;\longrightarrow\; \text{Adapter ID (A-Z)}$$

Isso garante que mesmo diante de múltiplos provedores com configurações idênticas, a escolha é 100% reproduzível e auditável.

---

### 4. FLUXO DE EVENTOS ESTRUTURADOS DE OBSERVABILIDADE
O Weaver Router emite um stream de eventos tipados (`WeaverEvent`):

1. `WEAVER_REQUESTED`: Registra a recepção da intenção e parâmetros de contexto.
2. `WEAVER_VALIDATED`: Confirmação da conformidade do schema Zod.
3. `WEAVER_POLICY_ALLOWED` / `WEAVER_POLICY_DENIED`: Parecer determinístico do Policy Engine.
4. `WEAVER_CANDIDATES_DISCOVERED`: Lista de candidatos identificados e pontuados.
5. `WEAVER_ROUTE_SELECTED`: Seleção do provedor primário e montagem da fallback chain.
6. `WEAVER_EXECUTION_STARTED`: Início do despacho físico para o adaptador.
7. `WEAVER_FALLBACK_STARTED`: Disparo de contingência em caso de falha primária.
8. `WEAVER_EXECUTION_SUCCEEDED` / `WEAVER_EXECUTION_FAILED`: Conclusão da operação e registro no SQLite AmnesiaDB WAL.

---

*Especificação do algoritmo de roteamento determinístico validada por 50 iterações em suíte de testes.*
