# Micro Etapa 029: Autonomous Capability Discovery, Verification Engine & Provider Lifecycle Management

## 1. Contexto & Escopo da Etapa
- **Fase de Atuação:** Fase 9 — Autonomous Capability Discovery & Provider Lifecycle.
- **Objetivo Arquitetural:** Construir uma infraestrutura física compilável, estritamente tipada com Zod, e integrada às Fases 1–8 para ingestão controlada de providers e capabilities (Discovery $\to$ Validation $\to$ Registration $\to$ Health $\to$ Verification $\to$ Activation $\to$ Degradation $\to$ Revocation).
- **Invariantes Fundamentais:**
  - *Discovery $\neq$ Trust*: O parsing de um descriptor não concede autoridade de execução.
  - *Observation $\neq$ Authority*: A sondagem de um nó externo é estritamente observacional e não modifica políticas de segurança.
  - *NOT_VERIFIABLE é Fail-Closed*: Ausência de adaptador ou credencial inválida impede a transição para `VERIFIED`.
  - *Zero Arbitrary Execution*: Sem `eval`, `new Function` ou subshells durante o discovery.

---

## 2. Subsistemas Físicos Implementados

### 2.1. Discovery Engine (`src/capabilities/discovery/`)
- `discoverySource.ts`: Taxonomia de fontes (`LOCAL_MANIFEST`, `MCP_SERVER`, `REST_DESCRIPTOR`, etc.) e níveis de confiança (`INTERNAL`, `CONFIGURED`, `UNTRUSTED`).
- `discoverySanitizer.ts`: Sanitização recursiva e canônica de credenciais (API keys, JWT, Bearer tokens, private keys, URIs com auth) antes do hashing.
- `discoverySchema.ts`: Schemas Zod para `DiscoverySource`, `DiscoveryCandidate`, `ProviderObservation`, `CapabilityObservation` e `DiscoveryResult`.
- `manifestValidator.ts`: Validação estrita de manifestos, integridade de tipos e detecção de ciclos topológicos em dependências ($A \to B \to A$).
- `providerProbe.ts` & `capabilityProbe.ts`: Observação não-destrutiva de conectividade e metadados.
- `discoveryEngine.ts`: Coordenador autônomo com emissão de eventos criptográficos no Evidence Fabric (`DISCOVERY_STARTED`, `DISCOVERY_COMPLETED`, `DISCOVERY_REJECTED`) e aprendizado na Semantic Memory.
- `discoveryReplay.ts`: Motor de replay determinístico e somente leitura (`READ-ONLY`) com verificação de digest SHA-256.

### 2.2. Verification Engine (`src/capabilities/verification/`)
- `verificationAxes.ts`: Definição dos 8 eixos ortogonais de verificação: `IDENTITY`, `TRANSPORT`, `SCHEMA`, `ADAPTER`, `HEALTH`, `AUTH`, `SCOPE`, `DEPENDENCIES`.
- `verificationDiagnostics.ts`: Códigos de diagnóstico padronizados (`IDENTITY_INVALID`, `ADAPTER_NOT_FOUND`, `HEALTH_CHECK_FAILED`, etc.).
- `verificationSchema.ts`: Schemas Zod para resultados de verificação e replay.
- `verificationEngine.ts`: Avaliador dos 8 eixos que calcula o `verificationDigest` SHA-256 e emite eventos `VERIFICATION_COMPLETED` e `VERIFICATION_REJECTED`.
- `verificationReplay.ts`: Motor forense de replay para validação de integridade e detecção de divergências.

### 2.3. Provider Lifecycle Manager (`src/capabilities/lifecycle/`)
- `lifecycleTransitions.ts`: Matriz de adjacência de transições de estado legais (`LEGAL_LIFECYCLE_TRANSITIONS`) impedindo saltos ilegais (`DISCOVERED` $\to$ `VERIFIED`).
- `lifecycleSchema.ts`: Schemas de transições, snapshots de saúde e registros de revogação.
- `lifecycleManager.ts`: Máquina de estados finitos (FSM) progressiva e com fail-closed.
- `healthMonitor.ts`: Monitor de telemetria operacional com thresholds de degradação (3 falhas consecutivas $\to$ `DEGRADED`, 5 falhas consecutivas $\to$ `DISABLED`) e recuperação com probe real.
- `revocationManager.ts`: Gerenciador de revogação imediata e atômica com invalidação no `ProviderRegistry`, `CapabilityRegistry`, `ProviderLifecycleManager`, injeção de alerta na `MemoryStore` e emissão no `EvidenceStore`.

---

## 3. Matriz de Testes Adversariais & Validação Física

### 3.1. 25 Cenários de Segurança Validados (`tests/discovery/security_25_scenarios.test.js`)
1. **API Key Discovery:** Sanitizada e redigida para `[REDACTED_SECRET]`.
2. **JWT Discovery:** Token JWT sanitizado para `[REDACTED_SECRET]`.
3. **Bearer Token Discovery:** Sanitizado para `[REDACTED_SECRET]`.
4. **Private Key Discovery:** Chave RSA sanitizada para `[REDACTED_SECRET]`.
5. **Manifest Malformado:** Rejeitado com `valid: false`.
6. **Capability de Alto Risco:** Avaliada como `CRITICAL` com exigência de aprovação humana.
7. **Dependência Circular:** Detectada via DFS e rejeitada (`CIRCULAR_DEPENDENCY`).
8. **Provider sem Adapter:** Verdict `NOT_VERIFIABLE` (Eixo Adapter = `false`).
9. **Auth não-verificada:** Verdict `NOT_VERIFIABLE`.
10. **Provider Unhealthy:** Verdict `REJECTED`.
11. **Provider Revogado:** Verdict `REJECTED`.
12. **Salto Ilegal DISCOVERED $\to$ VERIFIED:** Lança `ILLEGAL_LIFECYCLE_TRANSITION`.
13. **Salto Ilegal UNKNOWN $\to$ VERIFIED:** Lança `ILLEGAL_LIFECYCLE_TRANSITION`.
14. **Salto Ilegal REVOKED $\to$ VERIFIED:** Lança `ILLEGAL_LIFECYCLE_TRANSITION`.
15. **Weaver bloqueado em provider revogado:** Execução rejeitada fail-closed.
16. **Resolver bloqueado em provider desabilitado:** Resolução rejeitada fail-closed (`ALL_PROVIDERS_DISABLED` / `POLICY_DENIED`).
17. **Shell Injection no Descriptor:** Tratado como string inerte, zero execução.
18. **eval / new Function no Descriptor:** Tratado como dado inerte, zero execução.
19. **Execução arbitrária de código:** Descritor sem adaptador bloqueado de registro.
20. **Elevação de autoridade via Memória:** Registro de memória não sobrepõe o `VerificationEngine`.
21. **Mutação de estado no Replay:** Replay é estritamente `READ-ONLY`.
22. **Recuperação de Saúde Incorreta:** Não recupera sem probe real de execução.
23. **Threshold de 3 Falhas:** Provider transiciona para `DEGRADED`.
24. **Threshold de 5 Falhas:** Provider transiciona para `DISABLED`.
25. **Bypass de Fallback:** Provedores revogados excluídos da seleção de fallback do Weaver.

---

## 4. Resultados da Suite de Testes & Singularity Doctor

- **Total de Testes Físicos:** 116/116 PASS (0 falhas).
- **Tempo de Execução:** 5.37s.
- **Singularity Doctor Health Score:** 100.0% (31/31 checks aprovados em 8 eixos de saúde).
- **Status do Sistema:** 100% OPERACIONAL.
