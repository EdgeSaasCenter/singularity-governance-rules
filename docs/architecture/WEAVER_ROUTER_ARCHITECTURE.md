# WEAVER ROUTER ARCHITECTURE (v1.0)
## Arquitetura de Roteamento Determinístico e Orquestração de Execução no Singularity Workbench

---

### 1. VISÃO GERAL DO WEAVER ROUTER
O **Weaver Router** é o núcleo de orquestração cognitiva e execução física do Singularity Workbench. Ele transforma uma intenção de alto nível no menor grafo determinístico e seguro de capacidades, provedores e adaptadores necessários para cumprir o objetivo sem sobrecarga de contexto.

```
                          INTENT / REQUEST
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │  ZOD SCHEMA VALIDATOR │
                     └───────────┬───────────┘
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │ LOOP & DEPTH DETECTOR │ (Anti-Recursion / MaxDepth Guard)
                     └───────────┬───────────┘
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │     POLICY ENGINE     │ (Autoridade Única Fail-Closed)
                     └───────────┬───────────┘
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │  DETERMINISTIC SCORER │ (Priority, Health, Auth, Risk, Latency)
                     └───────────┬───────────┘
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │     ROUTING GRAPH     │ ──► [DECISION: Primary + Fallback Chain]
                     └───────────┬───────────┘
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │ EXECUTION ORCHESTRATOR│ ──► [PRIMARY ADAPTER EXECUTION]
                     └───────────┬───────────┘
                                 │ (Em caso de falha controlada)
                                 ▼
                     ┌───────────────────────┐
                     │    FALLBACK RUNNER    │ ──► [FALLBACK ADAPTER CANDIDATE]
                     └───────────┬───────────┘
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │  AMNESIA WAL & EVENTS │ ──► [EVIDENCE + SANITIZED AUDIT TRAIL]
                     └───────────────────────┘
```

---

### 2. PRINCÍPIO DO MINIMUM SUFFICIENT EXECUTION GRAPH (ANTI-BLOAT)
O Weaver Router não despeja todas as ferramentas e capacidades disponíveis no prompt. Ele calcula a menor cadeia estritamente necessária para executar a ação solicitada, filtrando candidatos inoperantes e expondo apenas o adaptador selecionado com sua respectiva cadeia de contingência.

---

### 3. CONTRATO FORMAL DO WEAVER (Zod + TypeScript)

```typescript
export const WeaverRequestSchema = z.object({
  requestId: z.string().uuid(),
  intent: z.string().min(3),
  capabilityId: z.string().regex(/^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$/),
  input: z.record(z.string(), z.unknown()).default({}),
  context: z.record(z.string(), z.unknown()).default({}),
  constraints: WeaverConstraintsSchema.default({
    allowFallback: true,
    maxDepth: 10,
    environment: "development"
  }),
  parentExecutionId: z.string().uuid().nullable().default(null),
  callStack: z.array(z.string()).default([])
});
```

---

### 4. DETECTOR DE LOOPS E GUARDA DE PROFUNDIDADE (ANTI-RECURSION)
- **Detecção de Ciclos:** O Weaver inspeciona o `callStack` recebido. Se o `capabilityId` já estiver presente na árvore de chamadas ancestrais ($A \to A$, $A \to B \to A$, $A \to B \to C \to A$), a execução é imediatamente rejeitada com `WEAVER_LOOP_DETECTED`.
- **Limite de Profundidade:** Se `callStack.length >= constraints.maxDepth`, a execução é abortada com `WEAVER_DEPTH_OVERFLOW`.

---

### 5. FALLBACK DETERMINÍSTICO E RECUPERAÇÃO DE FALHAS
1. O Weaver ordena todos os provedores operacionais pelo `totalScore` determinístico.
2. O candidato de maior pontuação é selecionado como Primário. Os demais compõem a `fallbackChain`.
3. Na orquestração (`orchestrate()`):
   - Executa o adaptador primário.
   - Se retornar `success: false` ou lançar exceção não crítica e `allowFallback === true`:
     - Dispara o evento `WEAVER_FALLBACK_STARTED`.
     - Tenta o próximo provedor da `fallbackChain` em ordem estrita.
   - Se todos os provedores falharem:
     - Emite `WEAVER_EXECUTION_FAILED`.
     - Retorna diagnóstico estruturado com histórico de tentativas (`fallbackAttempts`) sem quebrar o processo.

---

### 6. BLINDAGEM CONTRA VAZAMENTO DE SEGREDOS (SANITIZER)
O subsistema `sanitizeSecrets` inspeciona recursivamente todas as cargas de eventos, inputs e evidências:
- Chaves identificadas como sensíveis (`apiKey`, `token`, `secret`, `password`, `authorization`, `privateKey`, `cookie`, etc.) e padrões de valores (JWT, Bearer, tokens `ghp_` e `sk_live_`) são substituídos por `"[REDACTED_SECRET]"`.
- Protegido contra referências circulares via `WeakSet`.

---

*Especificação formal do Weaver Router comprovada por 51 testes automatizados.*
