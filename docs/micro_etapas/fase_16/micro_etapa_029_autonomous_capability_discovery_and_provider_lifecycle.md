# Micro-Etapa 029: Autonomous Capability Discovery & Provider Lifecycle

## 1. Contexto e Objetivo Arquitetural
A Fase 9 do **Singularity Workbench** estabelece o subsistema autônomo de descoberta de capabilities e gestão de ciclo de vida de providers (`src/capabilities/discovery/`). O objetivo foi transformar a integração de componentes externos em um pipeline determinístico e fail-closed com base no axioma inegociável:

$$\text{DISCOVERY} \neq \text{TRUST}$$

O subsistema garante que a observação de um provider ou manifesto jamais conceda privilégios de execução imediatos, exigindo uma esteira rigorosa de validação sintática, verificação em 8 eixos, transições em máquina de estados finitos (FSM), monitoramento de degradação e revogação auditada.

---

## 2. Destruição da Solução Óbvia (Máquina de Divergência)

### A Solução Ingênua (Descartada):
- *Abordagem:* Importar dinamicamente scripts de providers via `import()` ou invocar comandos de shell arbitrários definidos em manifestos YAML/JSON, registrando-os imediatamente no `CapabilityRegistry` e `ProviderRegistry` como operacionais.
- *Por que Falha:* Cria um vetor crítico de Execução Remota de Código (RCE) e escalação de privilégios. Manifestos adulterados poderiam declarar `riskLevel: ZERO` para operações destrutivas de disco, introduzir loops circulares de dependência que travam o runtime, ou ocultar credenciais/chaves privadas em metadados sem sanitização. Além disso, a falta de uma máquina de estados explícita permitiria saltos ilegais de `DISCOVERED` diretamente para `VERIFIED`.

### A Solução Resiliente Implementada:
1. **Manifest Validator & Sanitizer:** Validação Zod estrita de candidatos contra injeção de esquemas inválidos, detecção topológica de dependências circulares em grafos orientados ($A \to B \to A$), e sanitização profunda de segredos em metadados.
2. **Probing Não Destrutivo:** `ProviderProbe` e `CapabilityProbe` inspecionam identificadores, conformidade de transporte e existência de adaptadores sem executar código arbitrário.
3. **Verification Engine em 8 Eixos:** Avaliação ortogonal de Identidade, Transporte, Esquema, Adaptador, Saúde, Autenticação, Escopo e Dependências. O veredito `NOT_VERIFIABLE` é estritamente fail-closed e nunca se transforma em `VERIFIED`.
4. **Finite State Machine (FSM):** Gestão rigorosa de estados (`UNKNOWN` $\to$ `DISCOVERED` $\to$ `CONFIGURED` $\to$ `AUTHENTICATED` $\to$ `VERIFIED` $\to$ `DEGRADED` $\to$ `DISABLED` $\to$ `REVOKED`) com emissão de eventos criptográficos para o `EvidenceFabric`.
5. **Revogação Imediata & Blindagem do Weaver:** `RevocationManager` invalida registros no `ProviderRegistry` e atualiza o estado para `REVOKED`. O `WeaverRouter` e o `CapabilityResolver` bloqueiam qualquer execução direcionada a providers revogados (`ALL_PROVIDERS_DISABLED`).
6. **Deterministic Discovery Replay:** Motor de replay em modo estritamente *Read-Only* que valida a reprodutibilidade forense das decisões de descoberta sem mutações em disco.

---

## 3. Implementação Física dos Componentes

Os seguintes módulos foram construídos em `repos/singularity-mcp/src/capabilities/discovery/`:

1. `types.ts`: Taxonomias e tipos formais para fontes de descoberta, vereditos de verificação, motivos de revogação e resultados de replay.
2. `discoverySchema.ts`: Contratos Zod para `DiscoverySourceSchema`, `DiscoveryCandidateSchema`, `ProviderObservationSchema`, `CapabilityObservationSchema`, `VerificationResultSchema`, `LifecycleTransitionSchema`, `HealthSnapshotSchema`, `RevocationRecordSchema` e `DiscoveryReplayResultSchema`.
3. `manifestValidator.ts`: Validador sintático e semântico com sanitização de segredos e detecção de dependências circulares.
4. `providerProbe.ts`: Sonda não destrutiva para avaliação de transporte, saúde e adaptadores.
5. `capabilityProbe.ts`: Classificador de domínios, operações e níveis de risco.
6. `verificationEngine.ts`: Motor de verificação em 8 eixos ortogonais.
7. `lifecycleManager.ts`: Máquina de estados finitos com ancoragem de evidências no Evidence Fabric.
8. `healthMonitor.ts`: Monitor de saúde operacional com degradação progressiva ($N \ge 3$) e desativação ($N \ge 5$).
9. `revocationManager.ts`: Gestor de revogação auditada e invalidação de registros.
10. `discoveryReplay.ts`: Motor forense determinístico de replay em modo Read-Only.
11. `discoveryEngine.ts`: Coordenador autônomo de todo o ciclo de descoberta, ativação, registro e aprendizado semântico.
12. `index.ts`: Ponto de entrada unificado exportado pelo ecossistema de capabilities.

---

## 4. Teste Real & Auditoria Hostil (116/116 PASS)

A suíte completa de testes unitários, adversariais e E2E foi executada diretamente via `node --test`:

- `tests/discovery/schema.test.js`: Validação de contratos Zod e defaults de descoberta.
- `tests/discovery/manifest.test.js`: Validação de manifestos limpos, sanitização de segredos e rejeição de dependências circulares.
- `tests/discovery/lifecycle.test.js`: Validação de transições legais e bloqueio de saltos ilegais (`DISCOVERED` $\to$ `VERIFIED`).
- `tests/discovery/verification.test.js`: Avaliação dos 8 eixos de verificação e emissão de vereditos determinísticos.
- `tests/discovery/health.test.js`: Monitoramento de falhas consecutivas, degradação para `DEGRADED`, desativação para `DISABLED` e recuperação em sucesso.
- `tests/discovery/revocation.test.js`: Revogação formal, invalidação no `ProviderRegistry` e emissão de evidência.
- `tests/discovery/adversarial.test.js`: Injeção de manifestos maliciosos, escalação de privilégios de ciclo de vida e bloqueio de execução de providers revogados no `WeaverRouter`.
- `tests/discovery/replay.test.js`: Avaliação de determinismo em modo Read-Only com vereditos `IDENTICAL` e `DIVERGENT`.
- `tests/discovery/e2e.test.js`: Pipeline completo e físico conectando Descoberta $\to$ Validação $\to$ Verificação $\to$ Ativação FSM $\to$ Execução Real Weaver $\to$ Emissão de Evidência $\to$ Aprendizado Semântico $\to$ Replay.

### Resultado Consolidado:
```
ℹ tests 116
ℹ suites 0
ℹ pass 116
ℹ fail 0
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 5360.496441
```

### Diagnóstico Singularity Doctor:
```
================================================================
  HEALTH SCORE: 100.0% — 100% OPERATIONAL (ALL 31 CHECKS PASSED) ✓
================================================================
```
