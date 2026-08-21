# CAPABILITY REGISTRY & CONTRACT FOUNDATION (v1.0)
## Especificação Formal da Camada de Capacidades do Singularity Workbench

---

### 1. O QUE É UMA CAPABILITY
No ecossistema da Singularidade, uma **Capability** é uma entidade de primeira classe do sistema que define um contrato declarativo, determinístico e tipado para uma ação executável. Uma capability encapsula a intenção cognitiva, o provedor, o mecanismo de transporte, as restrições de execução, o nível de risco, a política de segurança, os requisitos de evidência e as estratégias de recuperação em caso de falha.

O fluxo de vida de uma capability segue o ciclo canônico:
$$\text{Intenção} \longrightarrow \text{Capability} \longrightarrow \text{Provider} \longrightarrow \text{Transporte} \longrightarrow \text{Operação} \longrightarrow \text{Política} \longrightarrow \text{Risco} \longrightarrow \text{Execução} \longrightarrow \text{Evidência} \longrightarrow \text{Fallback}$$

---

### 2. DIFERENÇA ENTRE CAPABILITY E TOOL

```
┌───────────────────────────────────────────────────┬───────────────────────────────────────────────────┐
│ Tool MCP (Primitivo de Baixo Nível)               │ Capability (Entidade de Primeira Classe)          │
├───────────────────────────────────────────────────┼───────────────────────────────────────────────────┤
│ Função atômica exposta via JSON-RPC.              │ Contrato completo de governança e ciclo de vida.  │
│ Sem conhecimento de risco, contexto ou política.  │ Possui modelo de risco, permissão e idempotência. │
│ Eletrocuta o prompt se 100+ forem injetadas.      │ Fica no Registry; exposta dinamicamente on-demand.│
│ Acoplada a um servidor específico.                │ Abstrata de provedor com fallback e fail-closed.  │
│ Apenas executa e retorna bytes/JSON.              │ Exige nível de evidência e auditoria formal.      │
└───────────────────────────────────────────────────┴───────────────────────────────────────────────────┘
```

---

### 3. SCHEMA FORMAL (Zod & TypeScript)

A definição canônica de uma capability é validada estritamente via Zod (`src/capabilities/schema.ts`):

```typescript
export const CapabilityDefinitionSchema = z.object({
  identity: z.object({
    id: z.string().regex(/^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$/), // Ex: "memory.read_working_context"
    version: z.string().regex(SEMVER_REGEX),                         // Ex: "1.0.0"
    name: z.string().min(3),
    description: z.string().min(10),
    domain: z.nativeEnum(CapabilityDomain)
  }),
  provider: z.object({
    provider: z.string().min(2),
    transport: z.nativeEnum(CapabilityTransport)
  }),
  execution: z.object({
    operation: z.nativeEnum(CapabilityOperation),
    timeoutMs: z.number().int().min(100).max(300000).default(5000),
    retryPolicy: RetryPolicySchema.default({ maxRetries: 3, backoffMs: 500, exponential: true }),
    idempotent: z.boolean().default(false)
  }),
  security: z.object({
    riskLevel: z.nativeEnum(CapabilityRisk),
    destructive: z.boolean().default(false),
    requiredScopes: z.array(z.string()).default([]),
    humanApprovalRequired: z.boolean().default(false),
    secretRequirements: z.array(z.string()).default([]),
    authMechanism: z.nativeEnum(AuthMechanism).default(AuthMechanism.NONE)
  }),
  availability: z.object({
    status: z.nativeEnum(CapabilityStatus).default(CapabilityStatus.UNKNOWN),
    healthCheckSupported: z.boolean().default(false),
    dependencies: z.array(z.string()).default([])
  }),
  failure: z.object({
    fallbackStrategy: z.nativeEnum(FallbackStrategy).default(FallbackStrategy.NONE),
    failureMode: z.nativeEnum(FailureMode).default(FailureMode.FAIL_CLOSED),
    circuitBreakerPolicy: CircuitBreakerPolicySchema.default({ failureThreshold: 5, resetTimeoutMs: 30000 })
  }),
  evidence: z.object({
    requiresEvidence: z.boolean().default(true),
    evidenceLevel: z.nativeEnum(EvidenceLevel).default(EvidenceLevel.STANDARD),
    auditRequirement: z.boolean().default(false)
  }),
  context: z.object({
    contextCost: z.nativeEnum(ContextCost).default(ContextCost.MINIMAL),
    estimatedLatencyMs: z.number().int().min(0).max(60000).default(100)
  })
});
```

---

### 4. RISK MODEL DETERMINÍSTICO

O risco representa o impacto potencial da ação no ecossistema:

- **`ZERO`**: Leitura de estado volátil ou status interno sem efeitos colaterais.
- **`LOW`**: Operações de leitura/escrita em storage local efêmero ou testes controlados.
- **`MEDIUM`**: Operações de escrita em serviços externos (Linear, PostHog flags, Canva).
- **`HIGH`**: Execução de scripts locais no host ou mutações com dependências cruzadas.
- **`CRITICAL`**: Operações destrutivas em banco de dados (`DROP`, `DELETE`), alterações em infraestrutura de produção ou manipulação de segredos.

---

### 5. STATUS MODEL (HEALTH & VERIFICATION)

Uma capability transita pelos seguintes estados formais:

```text
UNKNOWN ──► DISCOVERED ──► CONFIGURED ──► AUTHENTICATED ──► VERIFIED
                                                                │
                                              ┌─────────────────┴─────────────────┐
                                              ▼                                   ▼
                                           DEGRADED                            DISABLED / REVOKED
```

*Nota:* O status `VERIFIED` no Registry indica que a capacidade foi comprovada por uma rotina de health check operacional (execução real com asserção de retorno).

---

### 6. VERSIONAMENTO SEMÂNTICO (SemVer)
Todas as capabilities possuem versionamento estrito (ex: `1.0.0`). Mudanças de assinatura, schema de entrada/saída ou comportamento de risco exigem nova versão para prevenir breaking changes silenciosas.

---

### 7. DEPENDÊNCIAS & DETECÇÃO DE CICLOS
O Registry constrói o grafo direcionado de dependências e aplica validação por DFS para detecção de ciclos:
- Dependências ausentes são identificadas e rejeitadas.
- Dependências circulares ($A \to B \to A$ ou $A \to B \to C \to A$) são bloqueadas em tempo de registro com falha imediata.

---

### 8. REGISTRY API & IMUTABILIDADE

A classe `CapabilityRegistry` garante imutabilidade total através de `deepFreeze`:

```typescript
const registry = new CapabilityRegistry();

// Registro validado e congelado
registry.register(capabilityDefinition);

// Consultas fortemente tipadas
const cap = registry.get("memory.read_working_context");
const allMem = registry.findByDomain(CapabilityDomain.MEMORY);
const writes = registry.findByOperation(CapabilityOperation.WRITE);
const highRisk = registry.findByRisk(CapabilityRisk.HIGH);

// Validação de integridade do grafo
const health = registry.validateDependencies(); // { valid: true, errors: [] }
```

---

### 9. AS 5 CAPABILITIES CANÔNICAS DE SEED (INSTANCIADAS)

1. `system.read_status` (v1.0.0, SYSTEM, read, ZERO risk) — Leitura de status de runtime.
2. `memory.read_working_context` (v1.0.0, MEMORY, read, LOW risk) — Leitura de contexto volátil no Amnesia WAL.
3. `memory.append_working_event` (v1.0.0, MEMORY, write, LOW risk) — Registro transacional em memória de trabalho.
4. `system.run_health_check` (v1.0.0, SYSTEM, exec, LOW risk) — Diagnóstico 8-eixos via Singularity Doctor.
5. `system.write_evidence` (v1.0.0, SYSTEM, write, LOW risk) — Persistência de evidências atômicas no disco.

---

### 10. O QUE AINDA NÃO ESTÁ IMPLEMENTADO (ROADMAP)

- ⏳ **Weaver Router Completo:** Seleção dinâmica com base em NLP e anexação sob demanda.
- ⏳ **Policy Engine Completo:** Interceptores de contexto de produção em runtime.
- ⏳ **Provider Adapters:** Conexões externas reais com Linear, Supabase, PostHog, Gumloop, Granola, Canva, n8n e Gemini.
- ⏳ **Health Check Verification Runners:** Testes periódicos de conectividade com endpoints remotos.

---

*Especificação formal aprovada com 100% de testes automatizados unitários.*
