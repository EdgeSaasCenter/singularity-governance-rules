# CAPABILITY REALITY CHECK — SINGULARITY WORKBENCH
## Diagnóstico Forense da Infraestrutura Física vs Suposições Conceituais

---

### 1. OBJETIVO DO DIAGNÓSTICO
Realizar um reality check físico e exaustivo de todo o ambiente de engenharia do Singularity Workbench (`/home/sannchir/colorimetry`), confrontando cada componente real existente em disco contra as premissas formuladas nos documentos conceituais anteriores.

---

### 2. CLASSIFICAÇÃO NORMATIVA DOS COMPONENTES
Cada componente físico do ambiente foi inspecionado e classificado sob cinco estados estritos:

- **`EXISTENTE`** — Código, arquivo, configuração ou banco de dados fisicamente presente, compilável, testado e em operação real.
- **`PARCIAL`** — Estrutura base implementada, mas sem cobertura completa de tipagem, adapters externos ou testes de integração contínua.
- **`AUSENTE`** — Componente citado na arquitetura conceitual que ainda não possui linhas de código ou arquivos físicos correspondentes no disco.
- **`CONFLITANTE`** — Componente ou configuração existente que diverge ou colide com a arquitetura alvo (ex: poluição de ferramentas no MCP).
- **`NÃO VERIFICÁVEL`** — Dependência externa cujo estado não pode ser atestado sem credenciais ativas ou conexão remota autorizada.

---

### 3. INVENTÁRIO FORENSE DOS SUBSISTEMAS FÍSICOS

```text
/home/sannchir/colorimetry
├── .agents/
│   ├── hooks.json                      [EXISTENTE] - PreInvocation & PreToolUse (Circuit Breaker)
│   ├── memory/                         [EXISTENTE] - working_memory, cognitive_state, task_queue (JSON)
│   ├── rules/                          [EXISTENTE] - 16 regras de governança (atomic_execution, density, etc.)
│   ├── scripts/                        [EXISTENTE] - 46 suites de regressão e scripts de hooks
│   └── skills/                         [EXISTENTE] - 12 skills canônicas documentadas com SKILL.md
├── apps/
│   ├── colorimetry-ui/                 [EXISTENTE] - App React/Vite/TS com build e dependências
│   └── labs/                           [EXISTENTE] - Laboratórios de prototipação
├── docs/
│   ├── architectural/                  [EXISTENTE] - Dossiês de arquitetura, ecossistema e auditoria
│   ├── micro_etapas/                   [EXISTENTE] - Evidências físicas de execução atômica (fases 1 a 15)
│   └── routing-table.json              [EXISTENTE] - Mapa de roteamento semântico v5.0.0
├── repos/
│   ├── singularity-mcp/                [PARCIAL]   - Daemon MCP TypeScript com AmnesiaDB, Weaver e Council
│   ├── singularity-governance-rules/   [EXISTENTE] - Repositório Git das regras sincronizadas
│   └── singularity-scripts/            [EXISTENTE] - Repositório privado com 7 scripts de orquestração
├── scripts/                            [EXISTENTE] - singularity_weaver.py, singularity_doctor.py, install.sh
└── ~/.gemini/config/mcp_config.json    [CONFLITANTE] - Contém resend (80 tools) + sequential + singularity-broker
```

---

### 4. MATRIZ DETALHADA: REALIDADE FÍSICA vs SUPOSIÇÕES CONCEITUAIS

| Subsistema / Componente | O que o Documento Pressupunha | Realidade Física no Disco | Classificação | Evidência Operacional |
|---|---|---|---|---|
| **MCP: Singularity Broker** | Broker com AmnesiaDB, Weaver e Council ativo | TypeScript em `repos/singularity-mcp` compilando para `build/server/index.js` com `@modelcontextprotocol/sdk`, `better-sqlite3`, `vectra` e `zod`. | `EXISTENTE` | Registrado em `~/.gemini/config/mcp_config.json` e executando via stdio. |
| **MCP: Resend Config** | Serviço para e-mails | Conectado com 80+ tools gerando inchaço no prompt | `CONFLITANTE` | Chave ativa em `~/.gemini/config/mcp_config.json`. Deve ser removido do MCP direto. |
| **MCP: Linear Scoped** | Linear conectado via MCP oficial | Não configurado em `mcp_config.json` nem no código de providers | `AUSENTE` | Não há adapter em `/src/capabilities/` nem entrada no config. |
| **MCP: Supabase Scoped** | Supabase conectado via MCP oficial | Não configurado em `mcp_config.json` | `AUSENTE` | Não há conexão configurada. |
| **MCP: PostHog Scoped** | PostHog conectado via MCP oficial | Não configurado em `mcp_config.json` | `AUSENTE` | Não há conexão configurada. |
| **MCP: Gumloop guMCP** | Hub de 250 tools conectado | Não configurado em `mcp_config.json` | `AUSENTE` | Não há conector configurado. |
| **Capability Registry (`/src/capabilities`)** | Schema formal de capabilities em Zod | Não existe o diretório `/src/capabilities` no projeto | `AUSENTE` | Apenas schemas isolados dentro de `singularity-mcp/src/domain`. |
| **Weaver Policy Engine** | Validador determinístico de permissões | `repos/singularity-mcp/src/domain/Weaver.ts` possui `checkWeaverGate` básico com 2 regras | `PARCIAL` | Não possui classificação granular de risco, secrets, destructive, nem Zod estrito. |
| **Memory: Working Memory** | Memória volátil com SQLite WAL | `.amnesia.db` (SQLite) + `.agents/memory/working_memory.json` | `EXISTENTE` | `repos/singularity-mcp/src/domain/AmnesiaDB.ts` opera tabelas `state`, `task_queue` e `events`. |
| **Memory: Episodic (Granola)** | Histórico de reuniões conectado | Não há adapter REST nem MCP configurado | `AUSENTE` | Documentado apenas conceitualmente. |
| **Memory: Semantic (Supabase pgvector)** | RAG semântico em nuvem | Indexação local via `vectra` e `@xenova/transformers` em `singularity-mcp` | `PARCIAL` | RAG local existe; RAG em nuvem no Supabase ainda não foi construído. |
| **Memory: Procedural (Regras)** | Regras de governança no disco | 16 arquivos markdown em `.agents/rules/` | `EXISTENTE` | Validado pelo `singularity_doctor.py` com 100% de integridade. |
| **Memory: Project (Linear)** | Backlog de issues e cycles | Apenas task.md local e task_queue.json | `PARCIAL` | Memória de projeto é local; sync remoto no Linear não existe. |
| **Evidence System (`/docs/evidence`)** | Sistema de evidências com hashes e correlação | Evidências em `docs/micro_etapas/` e logs de tarefas | `PARCIAL` | Não há diretório estruturado `/docs/evidence/` com schema de auditoria formal. |
| **Failure Engineering & Anti-Loop** | Detecção de ciclos $A \to B \to A$ e deadlocks | `circuit_breaker.py` monitora tool loops simples | `PARCIAL` | Falta detecção formal de grafos de recursão com `parent_execution_id` e `depth`. |
| **Test Suites** | Baterias de testes automatizados | 46 scripts de regressão em `.agents/scripts/` | `EXISTENTE` | Suítes cobrem robustez cognitiva, interface observer e resiliência. |

---

### 5. SÍNTESE DO DIAGNÓSTICO FORENSE

1. **O que temos de sólido (Fundação Existente):**
   - Runtime Node/TS e Python robusto.
   - MCP local operacional (`singularity-broker` com SQLite WAL e Vector Embeddings locais).
   - Motor de governança e segurança com Lifecycle Hooks (`PreInvocation` e `PreToolUse`).
   - 16 repositórios Git sincronizados e testados com `singularity_doctor.py`.

2. **O que está em conflito:**
   - O `mcp_config.json` ainda contém a suite `resend` com 80+ tools gerando inchaço de prompt.

3. **O que é puramente conceitual e precisa ser construído com engenharia real:**
   - O diretório `/src/capabilities/` com o Capability Registry tipado em TypeScript + Zod.
   - O Policy Engine determinístico e desacoplado.
   - O Weaver Router que seleciona o menor conjunto de ferramentas sem sobrecarregar o modelo.
   - Os Provider Adapters desacoplados com Health Checks reais.
   - O sistema de evidência formal (`/docs/evidence/`) e o rastreador anti-loop com profundidade de grafo.

---

*Diagnóstico da FASE 1 concluído sem nenhuma alteração de código.*
