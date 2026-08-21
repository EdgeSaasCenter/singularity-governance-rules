# PROVIDER ADAPTER ARCHITECTURE (v1.0)
## Arquitetura Desacoplada de Provedores e Adaptadores de Execução no Singularity Workbench

---

### 1. O PAPEL DO PROVIDER ADAPTER
No Singularity Workbench, um **Provider** representa a entidade lógica fornecedora de um conjunto de capacidades, enquanto o **Provider Adapter** encapsula o mecanismo concreto de comunicação com o substrato de execução (native, SQLite, CLI, MCP HTTP, REST API, etc.).

O Adapter é deliberadamente desprovido de lógica de governança:
- **O que o Adapter NÃO faz:** Não decide políticas, não calcula nível de risco, não seleciona arbitrariamente capabilities e não realiza fallbacks silenciosos.
- **O que o Adapter FAZ:** Inicializa recursos físicos, executa health checks determinísticos, autentica o canal e despacha chamadas estritamente dentro do `ExecutionPlan`.

---

### 2. O CONTRATO FORMAL DO PROVIDER (Zod + TypeScript)

```typescript
export const ProviderDefinitionSchema = z.object({
  identity: z.object({
    id: z.string().regex(/^[a-z][a-z0-9_-]+$/),
    name: z.string().min(2),
    version: z.string().regex(SEMVER_REGEX),
    description: z.string().min(5)
  }),
  transport: z.nativeEnum(CapabilityTransport),
  capabilitiesProvided: z.array(z.string()).min(1),
  status: z.nativeEnum(CapabilityStatus).default(CapabilityStatus.UNKNOWN),
  healthStatus: z.nativeEnum(HealthStatus).default(HealthStatus.UNKNOWN),
  authStatus: z.nativeEnum(AuthStatus).default(AuthStatus.DISCOVERED),
  authMechanism: z.nativeEnum(AuthMechanism).default(AuthMechanism.NONE),
  timeoutMs: z.number().int().min(100).max(300000).default(5000),
  retryPolicy: RetryPolicySchema.default({ maxRetries: 3, backoffMs: 500, exponential: true }),
  priority: z.number().int().min(0).max(1000).default(100),
  dependencies: z.array(z.string()).default([]),
  metadata: z.record(z.string(), z.unknown()).default({})
});
```

---

### 3. O CONTRATO DO PROVIDER ADAPTER (`ProviderAdapter`)

```typescript
export interface ProviderAdapter {
  readonly id: string;
  readonly providerId: string;
  readonly transport: CapabilityTransport;

  initialize(): Promise<void>;
  healthCheck(): Promise<HealthCheckResult>;
  authenticate(): Promise<AuthResult>;
  supports(capabilityId: string): boolean;
  execute(plan: ExecutionPlan, input?: unknown): Promise<ExecutionResult>;
  shutdown(): Promise<void>;
}
```

---

### 4. ABSTRAÇÕES DE HEALTH E AUTHENTICATION

Diferenciação formal entre estados operacionais:

```
HEALTH STATES:
UNKNOWN ──► HEALTHY ──► DEGRADED ──► UNHEALTHY ──► DISABLED

AUTH STATES:
DISCOVERED ──► CONFIGURED ──► AUTHENTICATED ──► VERIFIED ──► REVOKED
```

*Regra de Segurança de Segredos:* Secrets, chaves de API e tokens **NUNCA** são registrados em logs, exceções, evidências ou planos de execução.

---

### 5. OS DOIS ADAPTERS LOCAIS REAIS (PHYSICAL IMPLEMENTATION)

1. **`LocalSystemAdapter` (`singularity_local`):**
   - Executa via `CapabilityTransport.NATIVE`.
   - Implementa `system.read_status` (telemetria real de memória, processador e Node.js).
   - Implementa `system.run_health_check` (verificação física de capacidade).
   - Implementa `system.write_evidence` (persistência atômica no disco).

2. **`LocalMemoryAdapter` (`amnesia_sqlite`):**
   - Executa via `CapabilityTransport.NATIVE` sobre SQLite WAL físico (`.amnesia.db`).
   - Implementa `memory.read_working_context` (leitura transacional da tabela `tasks`).
   - Implementa `memory.append_working_event` (escrita transacional com `ON CONFLICT DO UPDATE`).

---

### 6. PROVIDERS EXTERNOS (STATUS OPERACIONAL ATUAL)

Conforme a Regra Anti-Alucinação Arquitetural, os provedores externos permanecem formalmente classificados como:

| Provider | Status Atual | Justificativa Operacional |
|---|---|---|
| `linear` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer isolamento de credenciais e endpoint MCP/GraphQL verificado. |
| `supabase` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer configuração de branch segura e client OAuth 2.1. |
| `posthog` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer adapter scoped e token de ingestão. |
| `gumloop` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer conector Gateway Hub. |
| `granola` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer client REST com API Key. |
| `canva` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer app OAuth no Canva Dev Portal. |
| `n8n` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer webhook receiver assíncrono. |
| `gemini` | `UNIMPLEMENTED` (Planejado Fase 4+) | Requer client AI Studio com Cloud Credits. |

---

*Especificação formal de Adaptadores validada por 38 testes automatizados.*
