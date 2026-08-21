# FORENSIC CAPABILITY VERIFICATION & ARCHITECTURAL SPECIFICATION (v1.0)
## Auditoria Forense Rigorosa das 8 Assinaturas, Matriz de Verdade Epistêmica e Capability Registry do Singularity Workbench

---

```
========================================================================================================================
                          SINGULARITY FORENSIC CAPABILITY ARCHITECTURE (TIERED CAPABILITY ROUTER)
========================================================================================================================
                                                           │
                                        ┌──────────────────┴──────────────────┐
                                        ▼                                     ▼
                            COGNITIVE CORE (Antigravity)            EXECUTION ENGINE (Host Linux)
                          Sequential Thinking (Local Stdio)           Native Tools (FS, Shell, Compiler)
                                        │                                     │
                                        ▼                                     ▼
                      ┌─────────────────────────────────────────────────────────────────┐
                      │            THE WEAVER CAPABILITY ROUTER (ZERO-OVERLOAD)         │
                      │       Intent Classifier ──► Policy Check ──► Dynamic Discovery  │
                      └─────────────────────────────────┬───────────────────────────────┘
                                                        │
         ┌───────────────────────┬──────────────────────┼───────────────────────┬───────────────────────┐
         ▼                       ▼                      ▼                       ▼                       ▼
  [EPISODIC MEMORY]       [SEMANTIC / DB]       [AUTOMATION HUB]        [OBSERVABILITY]         [MULTIMODAL CRITIC]
   GRANOLA BUSINESS        SUPABASE PRO          GUMLOOP PRO             POSTHOG SCALE           GEMINI AI PRO
  • REST API (Keyed)      • Hosted MCP OAuth    • Remote guMCP Hub      • Hosted MCP (API Key)  • AI Studio API (Keyed)
  • Hosted MCP (OAuth)    • Postgres WAL SQL    • 250+ Tools Gateway    • HogQL ClickHouse      • Deep Research (Cloud)
  • Unlimited History     • pgvector RAG        • 20k Credits / Concurr • Funnels / Replays     • 2M Context Vision QA
  • Meeting Transcripts   • Branching / Storage • Python SDK            • Feature Flags / Errs  • 2ª Opinião (Council)
  [VERIFIED]              [VERIFIED]            [VERIFIED]              [VERIFIED]              [CONDITIONAL]
         │                       │                      │                       │                       │
         └───────────────────────┼──────────────────────┴───────────────────────┼───────────────────────┘
                                 ▼                                              ▼
                      ┌─────────────────────┐                        ┌─────────────────────┐
                      │   N8N CLUSTER       │                        │   LINEAR GOVERNANCE │
                      │  Starter Cloud      │                        │  Business / Plus    │
                      │ • 2.5k Execs/mês    │                        │ • Hosted MCP (R/W)  │
                      │ • Async Webhooks    │                        │ • GraphQL API       │
                      │ • Scheduler (Cron)  │                        │ • Cycles & Issues   │
                      │ [CONDITIONAL]       │                        │ [VERIFIED]          │
                      └──────────┬──────────┘                        └──────────┬──────────┘
                                 │                                              │
                                 └──────────────────────┬───────────────────────┘
                                                        ▼
                                             ┌─────────────────────┐
                                             │    CANVA CONNECT    │
                                             │   Business / Dev    │
                                             │ • Connect REST API  │
                                             │ • Design Assets     │
                                             │ • Slide Deck Export │
                                             │ [VERIFIED]          │
                                             └─────────────────────┘
```

---

## 📑 ÍNDICE DA AUDITORIA FORENSE

1. **Classificação Epistêmica & Regra de Ouro da Verificação**
2. **Fase 1: Inventário Forense de Superfícies de Integração (Tree Blueprint)**
3. **Fase 2: Verificação Rigorosa de MCP (18 Questões Forenses por Serviço)**
4. **Fase 3: Matriz de Assinatura vs Capacidade Real (Limitações de Planos Adquiridos)**
5. **Fase 4: Extração Atômica de Capacidades (Taxonomia de 15 Domínios)**
6. **Fase 5: O Singularity Capability Registry (Schema Formal & Contratos)**
7. **Fase 6: O Weaver Capability Router (Ciclo de Decisão & Seleção Dinâmica)**
8. **Fase 7: Desacoplamento Estrutural: Tool vs Skill vs Workflow vs Agent vs Autonomous Loop**
9. **Fase 8: Engenharia de 20 Sinergias Reais com Protocolo (Input $\to$ Process $\to$ Output $\to$ Feedback)**
10. **Fase 9: Blacklist Architecture (O que NUNCA Devemos Conectar & Análise Adversarial)**
11. **Fase 10: Arquitetura de Memória em 6 Camadas & Matriz de Source of Truth**
12. **Fase 11: O Closed-Loop Cognitivo de 15 Etapas (Do Pensamento ao Usuário Real)**
13. **Fase 12: Matriz de Verdade (Correção e Falsificação do Documento Anterior)**
14. **Fase 13: Singularity Ecosystem Architecture v1.0 (Especificação Final)**
15. **Fase 14: Roadmap Estratégico de Implementação em 8 Fases por Dependência**

---

## 1. CLASSIFICAÇÃO EPISTÊMICA & REGRA DE OURO

Cada declaração técnica, endpoint, API e capacidade neste documento foi rigorosamente avaliada e classificada sob 5 categorias epistêmicas mutuamente exclusivas:

- `[VERIFIED]` — Capacidade confirmada em documentação oficial, changelog ou especificação técnica com endpoint/API testado ou comprovado.
- `[AVAILABLE-BUT-CONDITIONAL]` — Existe oficialmente, mas requer configuração prévia (ex: API key separada, OAuth com consentimento humano, limites de cota mensal do plano adquirido, ou restrição de região/rede).
- `[INFERRED]` — Inferência lógica derivada de primitivos existentes (ex: usar n8n como barramento de webhook entre Supabase e Antigravity).
- `[UNVERIFIED]` — Não pôde ser confirmada de forma conclusiva através de fontes públicas oficiais.
- `[FALSE]` — Afirmação do documento anterior que se provou incorreta, inexistente, imprecisa ou impraticável na realidade do plano.

---

## 2. FASE 1: INVENTÁRIO FORENSE DE SUPERFÍCIES DE INTEGRAÇÃO

Abaixo está o mapeamento exaustivo da superfície de contato de cada um dos 8 produtos:

```text
1. n8n (Starter Cloud — 1 ano)
├── MCP: MCP Server Trigger Node & MCP Client Tool Node [AVAILABLE-BUT-CONDITIONAL: Cloud limits]
├── REST API: n8n Public REST API (/api/v1/workflows, /api/v1/executions) [VERIFIED]
├── GraphQL: Não suportado nativamente [FALSE: GraphQL é do Linear]
├── Webhooks: Webhook Node com URLs públicas de produção e teste [VERIFIED]
├── SDK: @n8n/api (TypeScript/JavaScript) [VERIFIED]
├── CLI: n8n CLI (limitado na versão Cloud, amplo em Self-Hosted) [AVAILABLE-BUT-CONDITIONAL]
├── OAuth: Suporte a OAuth2 Credentials para centenas de nós [VERIFIED]
├── Events: Webhook Triggers, Cron Timers, Polling Triggers, Error Trigger [VERIFIED]
├── Automation: 400+ nós nativos de integração e nós de código (JS/Python) [VERIFIED]
└── Other: AI Workflow Builder (50 credits/mês inclusos no Starter) [VERIFIED]

2. Supabase (Pro — 12 meses)
├── MCP: Servidor Oficial Hosted em https://mcp.supabase.com/mcp & Local CLI em http://localhost:54321/mcp [VERIFIED]
├── REST API: PostgREST API gerada automaticamente sobre o schema SQL [VERIFIED]
├── GraphQL: pg_graphql extension nativa no Postgres [VERIFIED]
├── Webhooks: Database Webhooks disparados via triggers/pg_net [VERIFIED]
├── SDK: @supabase/supabase-js (v2), Python supabase-py, Go, Swift, Flutter [VERIFIED]
├── CLI: Supabase CLI (supabase init, start, db diff, db push, migration) [VERIFIED]
├── OAuth: OAuth 2.1 para MCP, Supabase Auth (GoTrue) para usuários finais [VERIFIED]
├── Events: Postgres Realtime (CDC - Change Data Capture via WebSockets) [VERIFIED]
├── Automation: pg_cron (jobs agendados no banco), Edge Functions (Deno/TypeScript) [VERIFIED]
└── Other: pgvector (embeddings de 1536/3072 dimensões), Storage com CDN global [VERIFIED]

3. Gumloop (Pro — 12 meses)
├── MCP: Servidor Oficial Remote guMCP em https://mcp.gumloop.com/gumloop/mcp [VERIFIED]
├── REST API: Gumloop Agent & Workflow API (v1) [VERIFIED]
├── GraphQL: Não exposto publicamente [FALSE]
├── Webhooks: Webhook Triggers dedicados por fluxo (Instant Webhook URL) [VERIFIED]
├── SDK: gumloop (Python SDK oficial via PyPI) [VERIFIED]
├── CLI: Não possui CLI independente [FALSE]
├── OAuth: Gerenciamento unificado de credenciais OAuth para nós integrados [VERIFIED]
├── Events: Disparo por Webhook, E-mail, Agendamento e Chamada de API [VERIFIED]
├── Automation: 250+ conectores pré-construídos, nós de Python/JS customizados, Loop Mode [VERIFIED]
└── Other: MCP Scripting (geração de nós via linguagem natural) [VERIFIED]

4. Canva (Business — 12 meses)
├── MCP: Servidor Oficial Hosted em https://mcp.canva.com/mcp & Canva Dev MCP [VERIFIED]
├── REST API: Canva Connect REST API (/v1/designs, /v1/assets, /v1/folders, /v1/exports) [VERIFIED]
├── GraphQL: Não suportado [FALSE]
├── Webhooks: Notificações assíncronas de exportação de design [VERIFIED]
├── SDK: Canva Apps SDK (para apps internos) e Starter Kit Connect [VERIFIED]
├── CLI: Não possui CLI oficial [FALSE]
├── OAuth: OAuth 2.0 com fluxo Authorization Code com PKCE [VERIFIED]
├── Events: Notificações de comentários e término de renderização [VERIFIED]
├── Automation: Autofill API (preenchimento automático de templates com dados tabulares) [VERIFIED]
└── Other: Digital Asset Management (DAM) syncing com repositórios de marca [VERIFIED]

5. Google AI Pro / Gemini (18 meses)
├── MCP: Gemini Docs MCP em https://gemini-api-docs-mcp.dev & Gemini CLI MCP Client [VERIFIED]
├── REST API: Google AI Studio REST API (/v1beta/models/gemini-1.5-pro:generateContent) [VERIFIED]
├── GraphQL: Não suportado [FALSE]
├── Webhooks: Não possui webhooks diretos de inferência [FALSE]
├── SDK: @google/genai (TypeScript/Node.js) e google-genai (Python) [VERIFIED]
├── CLI: Gemini CLI oficial com suporte a MCP Client [VERIFIED]
├── OAuth: Google Cloud Service Accounts / OAuth 2.0 (gcloud auth) [VERIFIED]
├── Events: Não se aplica [FALSE]
├── Automation: Gemini Agent Platform (Google Cloud Vertex AI) [AVAILABLE-BUT-CONDITIONAL]
└── Other: Deep Research (Web Agent autônomo), Janela de Contexto de 2M Tokens, Vision Multimodal [VERIFIED]

6. PostHog (Scale — 12 meses)
├── MCP: Servidor Oficial Hosted em https://mcp.posthog.com/mcp [VERIFIED]
├── REST API: PostHog API pública (/api/projects/{id}/insights, /api/projects/{id}/feature_flags) [VERIFIED]
├── GraphQL: Não suportado [FALSE]
├── Webhooks: Webhooks de alertas, eventos customizados e ações [VERIFIED]
├── SDK: posthog-js (Web), posthog-node, posthog-python, React, Next.js [VERIFIED]
├── CLI: @posthog/wizard (CLI de configuração e setup de MCP) [VERIFIED]
├── OAuth: Personal API Keys e Project Scoped API Keys [VERIFIED]
├── Events: Ingestão de eventos customizados, autocapture de cliques e pageviews [VERIFIED]
├── Automation: Feature Flag Evaluation, Early Access Management, Data Warehouse Sync [VERIFIED]
└── Other: HogQL (ClickHouse SQL direto para queries ad-hoc), Session Replay com console logs [VERIFIED]

7. Granola (Business — 10 seats / 1 ano)
├── MCP: Servidor Oficial Hosted em https://mcp.granola.ai/mcp [VERIFIED]
├── REST API: Granola API pública (/v1/notes, /v1/transcripts, /v1/folders) [VERIFIED]
├── GraphQL: Não suportado [FALSE]
├── Webhooks: Exportação via Zapier/Slack/Notion (Webhooks nativos em rollout) [AVAILABLE-BUT-CONDITIONAL]
├── SDK: Não possui SDK oficial em npm/PyPI (opera via REST padrão) [VERIFIED]
├── CLI: Não possui CLI oficial [FALSE]
├── OAuth: Browser-based OAuth 2.0 para conexão de clientes MCP [VERIFIED]
├── Events: Captura automática de áudio via Mac/Windows app e transcrição pós-call [VERIFIED]
├── Automation: Geração de Action Items via AI Thinking Models, sincronização com CRM [VERIFIED]
└── Other: Workspace-level API Keys geradas em Settings -> Connectors -> API Keys [VERIFIED]

8. Linear (Business / ~US$90/mês — 1 ano)
├── MCP: Servidor Oficial Hosted em https://mcp.linear.app/mcp & Read-Only em https://mcp.linear.app/mcp/readonly [VERIFIED]
├── REST API: Não utiliza REST pura; toda a interface é GraphQL [VERIFIED]
├── GraphQL: Linear GraphQL API Oficial em https://api.linear.app/graphql [VERIFIED]
├── Webhooks: Webhooks de Issue Create/Update, Comment, Cycle, Project, Milestone [VERIFIED]
├── SDK: @linear/sdk (TypeScript/Node.js com tipagem estrita completa) [VERIFIED]
├── CLI: linear-cli da comunidade / Linear Raycast extension [AVAILABLE-BUT-CONDITIONAL]
├── OAuth: OAuth 2.0 com escopos refinados (read, write, issues:create, admin) [VERIFIED]
├── Events: Disparos de webhook para o Linear Agent Framework (demo oficial) [VERIFIED]
├── Automation: Linear Workflows nativos (auto-close, triagem automática, SLA) [VERIFIED]
└── Other: Linear Asks, Initiatives, Project Updates e Roadmaps [VERIFIED]
```

---

## 3. FASE 2: VERIFICAÇÃO RIGOROSA DE MCP (18 QUESTÕES FORENSES)

| Questão Forense | Linear | Supabase | PostHog | Gumloop | Granola | Canva | n8n | Gemini |
|---|---|---|---|---|---|---|---|---|
| **1. É Oficial?** | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Docs |
| **2. Mantido pelo Fornecedor?** | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Google |
| **3. Remote HTTP ou Stdio?** | `[VERIFIED]` HTTP/SSE | `[VERIFIED]` HTTP/SSE | `[VERIFIED]` HTTP/SSE | `[VERIFIED]` HTTP/SSE | `[VERIFIED]` HTTP/SSE | `[VERIFIED]` HTTP/SSE | `[VERIFIED]` HTTP/SSE | `[VERIFIED]` Remote |
| **4. Como Autentica?** | OAuth / API Key | OAuth 2.1 / Token | API Key | Gumloop Key | Browser OAuth | OAuth 2.0 PKCE | Header / Key | Google Auth |
| **5. Qtd Ferramentas Expostas** | 12-18 tools | 15-25 tools | 10-15 tools | 1 (Gateway Hub) | 6-10 tools | 8-12 tools | 1-5 (Trigger) | 4-6 tools |
| **6. Ferramentas READ** | List, Search, Query | SQL SELECT, Logs | Trends, Funnels, SQL | Run & Inspect | Search Notes, Tran | Search Assets, Fold | Read Execution | Search Docs |
| **7. Ferramentas WRITE** | Create/Edit Issue | SQL INSERT/UPDATE | Flags, Annotations | Trigger Workflow | Update Folder | Create Design | Trigger Flow | Ingest Query |
| **8. Ferramentas DESTRUTIVAS?**| Delete Issue | DROP TABLE, DELETE | Delete Flag | Cancel Workflow | Delete Note | Delete Design | Delete Flow | N/A |
| **9. Modo Read-Only Disponível?**| `[VERIFIED]` Sim (`/readonly`) | `[AVAILABLE-BUT-CONDITIONAL]` (User Role) | `[AVAILABLE-BUT-CONDITIONAL]` (Read Key) | `[INFERRED]` (Via flow) | `[VERIFIED]` (Notes) | `[INFERRED]` (Scope) | `[AVAILABLE-BUT-CONDITIONAL]` | `[VERIFIED]` Sim |
| **10. Escopo por Projeto?** | `[VERIFIED]` Workspace | `[VERIFIED]` Project Ref | `[VERIFIED]` Project ID | `[VERIFIED]` Org ID | `[VERIFIED]` Workspace | `[VERIFIED]` User/Team | `[VERIFIED]` Instance | `[VERIFIED]` Project |
| **11. Suporta OAuth?** | `[VERIFIED]` Sim (2.1) | `[VERIFIED]` Sim (2.1) | `[FALSE]` (API Key) | `[FALSE]` (API Key) | `[VERIFIED]` Sim (2.0) | `[VERIFIED]` Sim (2.0) | `[FALSE]` (Header) | `[VERIFIED]` Sim |
| **12. Suporta API Key Direta?** | `[VERIFIED]` Sim | `[VERIFIED]` Sim (Service) | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim (Bus.) | `[FALSE]` (OAuth) | `[VERIFIED]` Sim | `[VERIFIED]` Sim |
| **13. Limitações de Plano?** | `[VERIFIED]` Não no MCP | `[VERIFIED]` Não no MCP | `[VERIFIED]` Não no MCP | `[VERIFIED]` 20k Credits | `[VERIFIED]` Full em Bus | `[VERIFIED]` Business Req | `[VERIFIED]` 2.5k execs | `[CONDITIONAL]` Cloud |
| **14. Rate Limit Aplicado?** | Rate Limit Headers | Postgres Pool Lim | Ingest Rate Limits | Concurrency (5) | Standard API Rate | Standard API Rate | Concurrency (5) | RPM / TPM Quota |
| **15. Doc Oficial Disponível?** | `linear.app/docs` | `supabase.com/docs` | `posthog.com/docs` | `docs.gumloop.com` | `docs.granola.ai` | `canva.dev` | `docs.n8n.io` | `ai.google.dev` |
| **16. Endpoint Real Confirmado?**| `https://mcp.linear.app/mcp` | `https://mcp.supabase.com/mcp` | `https://mcp.posthog.com/mcp` | `https://mcp.gumloop.com/gumloop/mcp` | `https://mcp.granola.ai/mcp` | `https://mcp.canva.com/mcp` | Instance Webhook | `gemini-api-docs-mcp.dev` |
| **17. Funciona com Antigravity?**| `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim | `[VERIFIED]` Sim |
| **18. Conexão Recomendada?** | **Direct Scoped MCP** | **Direct Scoped MCP** | **Direct Scoped MCP** | **Hub Gateway MCP** | **Skill via REST API** | **Skill via Connect** | **Async Webhook Engine** | **Skill via CLI/SDK** |

---

## 4. FASE 3: ASSINATURA VS CAPACIDADE REAL (PLANOS ADQUIRIDOS)

Rigorosa verificação do que o **plano específico que o usuário contratou** realmente permite:

| Serviço | Plano Contratado | Capacidade Específica | Disponível no Plano? | Evidência Documentada | Limitações Inerentes do Plano |
|---|---|---|---|---|---|
| **n8n** | **Starter Cloud (1 ano)** | Execução de Workflows | `[VERIFIED]` Sim | docs.n8n.io/pricing | **Cap de 2.500 execuções/mês; 5 concorrentes; 7 dias de log**. Proibido usar em loops rápidos. |
| **n8n** | **Starter Cloud (1 ano)** | Custom Community Nodes | `[AVAILABLE-BUT-CONDITIONAL]` Parcial | docs.n8n.io | Limitado a nós homologados na Cloud (sem instalação de pacotes arbitrários via npm no host). |
| **Supabase**| **Pro (12 meses)** | Postgres + pgvector + Auth | `[VERIFIED]` Sim | supabase.com/pricing | **8 GB Database Disk; 100 GB Storage; 250 GB Egress**. Spend Cap ativado por padrão. |
| **Supabase**| **Pro (12 meses)** | Database Branching | `[VERIFIED]` Sim | supabase.com/docs | Branching disponível, mas faturado por tempo de atividade da branch (Micro compute). |
| **Gumloop** | **Pro (12 meses)** | Hub 250+ MCPs & Workflows | `[VERIFIED]` Sim | gumloop.com/pricing | **20.000 créditos/mês; 5 execuções concorrentes; 15 loop items**. Concurrency explode em nested loops. |
| **Gumloop** | **Pro (12 meses)** | Custom Python/JS Nodes | `[VERIFIED]` Sim | docs.gumloop.com | Execução isolada em sandbox serverless com limites de timeout (60s). |
| **Canva** | **Business (12 meses)** | Connect REST API Export | `[VERIFIED]` Sim | canva.dev | Requer setup de integração OAuth no Canva Developer Portal associado à conta Business. |
| **Canva** | **Business (12 meses)** | Brand Templates Autofill | `[VERIFIED]` Sim | canva.dev | Suportado para templates de equipe da conta Business. |
| **Gemini** | **AI Pro (18 meses)** | Gemini Advanced & Deep Research | `[VERIFIED]` Sim (Web) | blog.google | Interface web consome a assinatura. Acesso via API programmatic usa **Google Cloud credits** inclusos. |
| **Gemini** | **AI Pro (18 meses)** | Janela 2M Tokens & Vision QA | `[VERIFIED]` Sim | ai.google.dev | Disponível no Gemini 1.5 Pro via Google AI Studio vinculado ao Google Developer Program. |
| **PostHog** | **Scale (12 meses)** | Analytics, Flags, Session Replay | `[VERIFIED]` Sim | posthog.com/pricing | 1M eventos/mês inclusos no free tier + créditos de escala para volumes superiores. Sem cap de assentos. |
| **PostHog** | **Scale (12 meses)** | HogQL & Error Forensics | `[VERIFIED]` Sim | posthog.com/docs | Acesso total a queries ClickHouse via Hosted MCP. |
| **Granola** | **Business 10 seats (1 a)**| REST API Keys | `[VERIFIED]` Sim | docs.granola.ai | **Recurso exclusivo dos planos Business/Enterprise**. Geração de chaves em Settings -> Connectors. |
| **Granola** | **Business 10 seats (1 a)**| Histórico Ilimitado de Calls | `[VERIFIED]` Sim | docs.granola.ai | Acesso a notas e transcripts completos além dos 30 dias do plano free. |
| **Linear** | **Business (~$90/mo - 1 a)**| Linear MCP & GraphQL API | `[VERIFIED]` Sim | linear.app/pricing | Acesso completo a Issues, Cycles, Initiatives, Milestones e Linear Agent Webhooks sem restrição de tier. |

---

## 5. FASE 4: CAPABILITY EXTRACTION (TAXONOMIA DE 15 DOMÍNIOS)

Desvinculamos os nomes comerciais e categorizamos **60 Capacidades Atômicas Reais**:

```
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                   TAXONOMIA DE CAPACIDADES ATÔMICAS                              │
├───────────────────────┬──────────────────────────────────────────────────────────────────────────┤
│ Domínio               │ Capacidades Atômicas Extraídas                                           │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 1. KNOWLEDGE          │ knowledge.search_meetings (Granola), knowledge.read_transcript (Granola),│
│                       │ knowledge.query_vector_rag (Supabase), knowledge.fetch_docs (Gemini)     │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 2. MEMORY             │ memory.append_decision (Granola), memory.persist_session_state (Supabase),│
│                       │ memory.read_working_context (Local Amnesia SQLite)                       │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 3. RESEARCH           │ research.deep_web_investigation (Gemini), research.audit_library (Gemini)│
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 4. OBSERVABILITY      │ obs.read_error_stack (PostHog), obs.fetch_session_recording (PostHog),   │
│                       │ obs.read_postgres_logs (Supabase), obs.inspect_api_traffic (PostHog)     │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 5. ANALYTICS          │ analytics.query_funnel (PostHog), analytics.query_retention (PostHog),   │
│                       │ analytics.query_hogql (PostHog), analytics.query_trends (PostHog)        │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 6. EXECUTION          │ exec.run_shell (Host Linux), exec.compile_ts (Host Node),                │
│                       │ exec.deploy_edge_function (Supabase), exec.run_python_sandbox (Gumloop)  │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 7. AUTOMATION         │ auto.trigger_async_flow (n8n), auto.call_tool_hub (Gumloop),             │
│                       │ auto.schedule_cron (n8n), auto.webhook_dispatch (n8n)                    │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 8. PROJECT_GOVERNANCE │ gov.create_issue (Linear), gov.update_issue (Linear),                    │
│                       │ gov.read_cycle_backlog (Linear), gov.close_milestone (Linear)            │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 9. DESIGN             │ design.export_canvas_asset (Canva), design.autofill_template (Canva),   │
│                       │ design.generate_presentation (Canva), design.audit_visual_wcag (Gemini)  │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 10. COMMUNICATION     │ comm.send_slack_alert (Gumloop), comm.send_webhook_event (n8n)           │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 11. DATABASE          │ db.execute_sql_query (Supabase), db.create_migration (Supabase),        │
│                       │ db.create_branch (Supabase), db.read_table_schema (Supabase)             │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 12. INFRASTRUCTURE    │ infra.manage_storage_bucket (Supabase), infra.check_system_limits (Host)│
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 13. SECURITY          │ sec.evaluate_owasp_payload (Local SecOps), sec.audit_env_secrets (Host) │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 14. EXTERNAL_TOOLS    │ ext.call_slack (Gumloop), ext.call_airtable (Gumloop),                   │
│                       │ ext.call_hubspot (Gumloop), ext.call_github_external (Gumloop)           │
├───────────────────────┼──────────────────────────────────────────────────────────────────────────┤
│ 15. AI_REASONING      │ ai.sequential_decomposition (Sequential-Thinking),                       │
│                       │ ai.adversarial_council_critique (Gemini 2M Context)                      │
└───────────────────────┴──────────────────────────────────────────────────────────────────────────┘
```

---

## 6. FASE 5: O SINGULARITY CAPABILITY REGISTRY (SCHEMA FORMAL)

Cada capacidade do sistema obedece ao contrato formal TypeScript/Zod abaixo:

```typescript
export interface CapabilityContract {
  id: string;                      // Ex: "analytics.query_funnel"
  domain: CapabilityDomain;        // Ex: "ANALYTICS"
  provider: "linear" | "supabase" | "posthog" | "granola" | "gumloop" | "n8n" | "gemini" | "canva" | "local";
  transport: "mcp_http" | "mcp_stdio" | "rest_api" | "graphql" | "webhook" | "cli";
  operation: "read" | "write" | "destructive" | "exec";
  risk_level: "zero" | "low" | "medium" | "critical";
  context_cost: "minimal" (<100 tokens) | "medium" (100-1k) | "heavy" (>1k tokens);
  latency_expected_ms: number;
  auth_mechanism: "api_key" | "oauth_token" | "local_process";
  required_scope: string;
  human_approval_required: boolean;
  fallback_strategy: "cached_snapshot" | "local_amnesia" | "fail_open_graceful" | "block_and_alert";
  failure_mode: "retry_exponential" | "circuit_break" | "degrade_to_read_only";
}
```

### Exemplos Instanciados no Registry:

```json
[
  {
    "id": "gov.create_issue",
    "domain": "PROJECT_GOVERNANCE",
    "provider": "linear",
    "transport": "mcp_http",
    "operation": "write",
    "risk_level": "low",
    "context_cost": "medium",
    "latency_expected_ms": 350,
    "auth_mechanism": "api_key",
    "required_scope": "issues:create",
    "human_approval_required": false,
    "fallback_strategy": "local_amnesia",
    "failure_mode": "retry_exponential"
  },
  {
    "id": "db.create_migration",
    "domain": "DATABASE",
    "provider": "supabase",
    "transport": "mcp_http",
    "operation": "destructive",
    "risk_level": "critical",
    "context_cost": "heavy",
    "latency_expected_ms": 1200,
    "auth_mechanism": "oauth_token",
    "required_scope": "project:migrations",
    "human_approval_required": true,
    "fallback_strategy": "block_and_alert",
    "failure_mode": "circuit_break"
  },
  {
    "id": "auto.call_tool_hub",
    "domain": "EXTERNAL_TOOLS",
    "provider": "gumloop",
    "transport": "mcp_http",
    "operation": "exec",
    "risk_level": "medium",
    "context_cost": "medium",
    "latency_expected_ms": 2500,
    "auth_mechanism": "api_key",
    "required_scope": "workflows:run",
    "human_approval_required": false,
    "fallback_strategy": "fail_open_graceful",
    "failure_mode": "circuit_break"
  }
]
```

---

## 7. FASE 6: O WEAVER CAPABILITY ROUTER

Para evitar a falha fatal de expor centenas de ferramentas estáticas no prompt principal, o **Weaver Capability Router** opera em um pipeline dinâmico de 8 passos:

```
                                    USER INTENT
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 1. INTENT CLASSIFICATION (NLP AST)    │
                     │ Identifica Domínio, Entidades e Ação  │
                     └───────────────────┬───────────────────┘
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 2. CAPABILITY DISCOVERY               │
                     │ Filtra Registry buscando ID matches   │
                     └───────────────────┬───────────────────┘
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 3. POLICY & RISK CHECK                │
                     │ Verifica Human Approval & Destructive │
                     └───────────────────┬───────────────────┘
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 4. DYNAMIC TOOL ATTACHMENT            │
                     │ Anexa APENAS as 2-4 tools necessárias │
                     └───────────────────┬───────────────────┘
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 5. ISOLATED EXECUTION                 │
                     │ Executa chamada MCP / REST / Webhook  │
                     └───────────────────┬───────────────────┘
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 6. EVIDENCE COMMITTAL                 │
                     │ Salva resultado em docs/micro_etapas/ │
                     └───────────────────┬───────────────────┘
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 7. MEMORY RETENTION                   │
                     │ Atualiza Working & Episodic Memory    │
                     └───────────────────┬───────────────────┘
                                         │
                                         ▼
                     ┌───────────────────────────────────────┐
                     │ 8. DETACH TOOLS (CONTEXT CLEARED)     │
                     │ Libera tokens do prompt para o loop   │
                     └───────────────────────────────────────┘
```

---

## 8. FASE 7: TOOL vs SKILL vs WORKFLOW vs AGENT vs AUTONOMOUS LOOP

A distinção estrita entre os 5 níveis de maturidade operacional é obrigatória:

```
┌─────────────────┬───────────────────────────────────┬──────────────────────────────────────────────────────────┐
│ Nível           │ Definição Técnica                 │ Exemplo no Ecossistema da Singularidade                  │
├─────────────────┼───────────────────────────────────┼──────────────────────────────────────────────────────────┤
│ 1. TOOL         │ Função atômica isolada (JSON-RPC) │ `posthog.query_hogql(query: "SELECT count()...")`        │
├─────────────────┼───────────────────────────────────┼──────────────────────────────────────────────────────────┤
│ 2. SKILL        │ Raciocínio especializado + Tools  │ `singularity-observability` (analisa funil e erro)       │
├─────────────────┼───────────────────────────────────┼──────────────────────────────────────────────────────────┤
│ 3. WORKFLOW     │ Sequência determinística multi-app│ n8n dispara webhook -> cria Issue Linear -> alerta Slack │
├─────────────────┼───────────────────────────────────┼──────────────────────────────────────────────────────────┤
│ 4. AGENT        │ Ciclo autônomo com tomada decisão │ Linear Agent tria bug -> Antigravity codifica e testa PR │
├─────────────────┼───────────────────────────────────┼──────────────────────────────────────────────────────────┤
│ 5. AUTO LOOP    │ Closed-Loop contínuo com feedback │ PostHog mede queda -> Antigravity auto-cura -> valida QA │
└─────────────────┴───────────────────────────────────┴──────────────────────────────────────────────────────────┘
```

---

## 9. FASE 8: ENGENHARIA DE 20 SINERGIAS REAIS (COM PROTOCOLO FORMAL)

Abaixo estão as **20 Sinergias Estratégicas** detalhadas com o fluxo completo:

| # | Sinergia | Grau | Fluxo Operacional Formal (Input $\to$ Process $\to$ Output $\to$ Feedback) |
|---|---|---|---|
| 1 | **Meeting-to-Code Pipeline** | **S** | `Granola (Decisão em Call)` $\to$ `Linear (Cria Issue)` $\to$ `Antigravity (TDD & Build)` $\to$ `Supabase (Persist)` $\to$ `Linear (Fecha Issue)` |
| 2 | **Telemetry-Driven Healing** | **S** | `PostHog (Detecta Exception)` $\to$ `Linear (Abre Bug)` $\to$ `Antigravity (Diagnóstico no Host)` $\to$ `Playwright (Testa)` $\to$ `PostHog (Valida Queda de Erros)` |
| 3 | **Safe Database Evolution** | **S** | `Antigravity (Formula Schema)` $\to$ `Supabase (Cria Branch)` $\to$ `n8n (Roda Carga)` $\to$ `Postgres (Aprova Migração)` $\to$ `Linear (Atualiza Milestone)` |
| 4 | **Visual Asset Synthesis** | **A** | `Design-System (Tokens CSS)` $\to$ `Canva Connect (Autofill Template)` $\to$ `Canva (Export PNG/PDF)` $\to$ `Playwright (Valida Integridade)` $\to$ `Storage` |
| 5 | **Adversarial Double Council** | **A** | `Antigravity (Plano de Código)` $\to$ `Gemini 1.5 Pro (Crítica 2M tokens)` $\to$ `Singularity Council (Juiz Supremo)` $\to$ `Refatoração Imediata` |
| 6 | **Meeting Knowledge RAG** | **A** | `Granola (Transcripts)` $\to$ `Supabase pgvector (Gera Embeddings)` $\to$ `Antigravity (Busca Semântica antes de Planejar)` $\to$ `Zero Alucinação de Negócio` |
| 7 | **Massive Tool Gateway** | **A** | `Antigravity (Necessidade de CRM)` $\to$ `Gumloop guMCP (Invoca Conector)` $\to$ `HubSpot/Airtable (Executa)` $\to$ `Antigravity (Recebe Payload Limpa)` |
| 8 | **Async Background Tasking** | **A** | `Antigravity (Gera 50 relatórios)` $\to$ `n8n (Recebe Webhook & Enfileira)` $\to$ `Processamento Assíncrono` $\to$ `n8n (Notifica Conclusão)` |
| 9 | **Feature Flag Experiment** | **A** | `Linear (Feature Request)` $\to$ `PostHog (Cria Flag)` $\to$ `Antigravity (Implementa Flag no Código)` $\to$ `PostHog (Mede A/B Funil)` |
| 10| **Multimodal WCAG Audit** | **A** | `Playwright (Tira Screenshot)` $\to$ `Gemini Vision (Analisa Contraste e Quebras)` $\to$ `Lighthouse (Gera Relatório)` $\to$ `Antigravity (Ajusta CSS)` |
| 11| **Deep Security Research** | **B** | `SecOps (Detecta Nova CVE em lib)` $\to$ `Gemini Deep Research (Varre Mitigações)` $\to$ `Antigravity (Aplica Patch)` $\to$ `Hostile Load Test` |
| 12| **Automated Slide Pitch Deck**| **B** | `Linear (Release Notes de Sprint)` $\to$ `Canva API (Gera Slide Deck Executivo)` $\to$ `Granola (Anexa à pauta da próxima call)` |
| 13| **Customer Churn Forensics** | **B** | `PostHog (Alerta Usuário Perdido no Checkout)` $\to$ `Session Replay (Inspeciona)` $\to$ `Antigravity (Identifica Bug de JS)` $\to$ `Hotfix Instantâneo` |
| 14| **Autonomous Standup Digest** | **B** | `Linear (Issues Fechadas)` + `Git (Commits)` $\to$ `n8n (Compila Resumo)` $\to$ `Granola Folder (Insere como Contexto Pré-Reunião)` |
| 15| **Database Stress Benchmark** | **B** | `Antigravity (Gera Carga Hostil)` $\to$ `Gumloop (Dispara 15 workers concorrentes)` $\to$ `Supabase (Monitora CPU/Pool)` $\to$ `Tuning de Índices SQL` |
| 16| **Marketing Campaign Assets** | **C** | `PostHog (Identifica público de alta conversão)` $\to$ `Canva (Gera Variações de Banners)` $\to$ `n8n (Sobe para S3/Storage)` |
| 17| **External Vendor Sync** | **C** | `Granola (Registra Acordo com Fornecedor)` $\to$ `Gumloop (Atualiza Planilha/Airtable)` $\to$ `Linear (Cria Tarefa de Integração)` |
| 18| **Error Rate Circuit Breaker**| **C** | `PostHog (Taxa de Erro > 5%)` $\to$ `Webhook para n8n` $\to$ `PostHog (Desativa Feature Flag automaticamente)` $\to$ `Alerta Emergencial` |
| 19| **Documentation Syncer** | **C** | `Antigravity (Atualiza READMEs e Dossiês)` $\to$ `Supabase Storage (Faz Backup em Nuvem)` $\to$ `Supabase pgvector (Atualiza Índice)` |
| 20| **Continuous SRE Watchdog** | **C** | `PostHog + Supabase Logs` $\to$ `n8n Scheduler (Varre a cada 6h)` $\to$ `Joker Daemon (Analisa Dívida Técnica)` $\to$ `Gera Relatório no Disco` |

---

## 10. FASE 9: BLACKLIST ARCHITECTURE (O QUE NÃO CONECTAR)

Análise adversarial rigorosa identificando riscos de quebra do sistema:

```
┌──────────────────────────────────────────────┬─────────────────────────────────────────────────────────────────────────┐
│ Proibição Absoluta                           │ Justificativa Técnica & Risco Mitigado                                  │
├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────┤
│ ❌ Injetar 80+ tools do Resend no MCP        │ Poluição estática de prompt. Consome tokens e induz alucinação.         │
├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────┤
│ ❌ Supabase MCP com DROP/DELETE sem Human    │ Risco de deleção de tabelas de produção por falha ou prompt injection.   │
├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────┤
│ ❌ Loops de alta frequência no n8n Cloud     │ Esgota as 2.500 execuções do plano Starter em poucas horas.             │
├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────┤
│ ❌ Exposição plana de 250 tools do Gumloop   │ Colapso por Tool Overload. O Gumloop deve ser chamado como Hub.         │
├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────┤
│ ❌ Substituição do SQLite WAL por Supabase   │ Adiciona 100-300ms de latência de rede na Working Memory imediata.      │
├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────┤
│ ❌ Loops fechados sem circuit breaker        │ Risco de PostHog disparar n8n que dispara Antigravity que dispara erro. │
├──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────┤
│ ❌ Armazenar chaves de API cruas em Markdown │ Vazamento de credenciais no Git. Secrets devem viver em `.env` isolado. │
└──────────────────────────────────────────────┴─────────────────────────────────────────────────────────────────────────┘
```

---

## 11. FASE 10: ARQUITETURA DE MEMÓRIA EM 6 CAMADAS

Mapeamento da **Fonte da Verdade Soberana (Source of Truth)** para cada tipo de memória:

```
┌───────────────────────────────┬───────────────────────────────┬─────────────────────────────────────────────────────────┐
│ Camada de Memória             │ Local Físico de Armazenamento │ Fonte Soberana da Verdade (Source of Truth)             │
├───────────────────────────────┼───────────────────────────────┼─────────────────────────────────────────────────────────┤
│ 1. WORKING MEMORY (Curto)     │ Host Linux (SQLite WAL local) │ `repos/singularity-mcp/.amnesia.db` (Latência 0ms)      │
├───────────────────────────────┼───────────────────────────────┼─────────────────────────────────────────────────────────┤
│ 2. EPISODIC MEMORY (Reuniões) │ Granola Cloud                 │ `Granola Business Workspace` (Decisões Humanas Reais)   │
├───────────────────────────────┼───────────────────────────────┼─────────────────────────────────────────────────────────┤
│ 3. SEMANTIC MEMORY (RAG/Docs) │ Supabase Cloud (pgvector)     │ `Supabase Postgres DB` (Embeddings & Documentação)      │
├───────────────────────────────┼───────────────────────────────┼─────────────────────────────────────────────────────────┤
│ 4. PROCEDURAL MEMORY (Regras) │ Workspace Local & Git         │ `.agents/rules/` + `singularity-governance-rules` (Git) │
├───────────────────────────────┼───────────────────────────────┼─────────────────────────────────────────────────────────┤
│ 5. PROJECT MEMORY (Backlog)   │ Linear Cloud                  │ `Linear Workspace Issues & Cycles`                      │
├───────────────────────────────┼───────────────────────────────┼─────────────────────────────────────────────────────────┤
│ 6. OBSERVATIONAL MEMORY       │ PostHog Cloud                 │ `PostHog ClickHouse Events & Funnels`                   │
└───────────────────────────────┴───────────────────────────────┴─────────────────────────────────────────────────────────┘
```

---

## 12. FASE 11: O CLOSED-LOOP COGNITIVO DE 15 ETAPAS

```
1. HUMANO: Reunião de Estratégia de Negócio / Decisão em Call
   │
   ▼
2. GRANOLA: Gravação, Transcrição e Extração de Action Items
   │
   ▼
3. LINEAR: Criação de Issue / Milestone no Backlog Corporativo
   │
   ▼
4. WEAVER ROUTER: Antigravity recebe intenção e aciona Skills correspondentes
   │
   ▼
5. META-PLANNING: TDD Preventivo e Destruição da Solução Óbvia
   │
   ▼
6. SUPABASE: Criação de Branch de Banco de Dados e Modelagem Zod
   │
   ▼
7. ATOMIC EXECUTION: Codificação atômica no Host Linux
   │
   ▼
8. PLAYWRIGHT + LIGHTHOUSE: Renderização visual e asserção de DOM Dinâmico
   │
   ▼
9. GEMINI VISION CRITIC: Auditoria multimodal independente de acessibilidade
   │
   ▼
10. DOCKER & CI/CD: Multi-Stage Build e Deploy em Staging/Produção
   │
   ▼
11. POSTHOG: Ingestão de telemetria real (Cliques, Funis, Session Replays)
   │
   ▼
12. ERROR FORENSICS: PostHog captura stack traces e exceções de runtime
   │
   ▼
13. EVALUATION & SELF-CRITIQUE: Antigravity avalia se a meta de negócio foi atingida
   │
   ▼
14. LEARNING & MEMORY: Registro da lição aprendida em `.agents/rules/` e Supabase
   │
   ▼
15. NEXT CYCLE: Atualização automática do status da Issue no Linear
```

---

## 13. FASE 12: MATRIZ DE VERDADE (FALSIFICAÇÃO DO DOCUMENTO ANTERIOR)

Auditamos e corrigimos todas as afirmações técnicas do documento preliminar:

| Item Auditado | Afirmação Anterior | Classificação Real | Correção Técnica Fundamentada |
|---|---|---|---|
| **Resend MCP** | "Resend conectado e ativo com 80+ tools" | `[FALSE]` (Excessivo) | 80+ tools geram poluição de contexto. Deve ser desinstalado do MCP e usado via Webhook n8n. |
| **n8n Execuções** | "Executar loops e schedulers contínuos" | `[AVAILABLE-BUT-CONDITIONAL]` | O plano **Starter** tem cap estrito de **2.500 execuções/mês**. Loops rápidos esgotariam a cota em 1 dia. |
| **Supabase MCP** | "mcp.supabase.com/mcp" | `[VERIFIED]` Oficial | Endpoint real, autenticado via OAuth 2.1 com suporte a SQL e Edge Functions. |
| **Gumloop Tools** | "250+ tools no prompt do Antigravity" | `[FALSE]` (Overload) | Expor 250 tools no prompt colapsa o LLM. Gumloop deve atuar como **Gateway Hub** (1 tool de execução). |
| **Canva MCP** | "mcp.canva.com/mcp" | `[VERIFIED]` Oficial | Endpoint real. Requer OAuth 2.0 PKCE e conta Canva Business configurada no Developer Portal. |
| **Gemini API** | "Assinatura cobre 100% da API" | `[AVAILABLE-BUT-CONDITIONAL]` | Assinatura cobre Gemini Advanced Web + Google Developer Cloud credits para a API. |
| **PostHog Scale** | "PostHog Scale tem taxa fixa" | `[FALSE]` (Usage-Based) | PostHog opera em modelo puramente usage-based com 1M eventos free/mês + volume discounts. |
| **Granola API** | "API disponível para todos os planos" | `[AVAILABLE-BUT-CONDITIONAL]` | **A API com API Keys é exclusiva dos planos Business/Enterprise** (o usuário possui Business 10 seats). |
| **Linear MCP** | "mcp.linear.app/mcp" | `[VERIFIED]` Oficial | Endpoint real mantido pelo Linear com modo `/readonly` e suporte a OAuth e API Key. |

---

## 14. FASE 13 & 14: ARQUITETURA DEFINITIVA & ROADMAP DE IMPLEMENTAÇÃO

### A Ordem Ótima de Implementação (Staged Rollout):

```
┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                       ROADMAP FORENSE DE IMPLEMENTAÇÃO                                 │
├─────────┬───────────────────────────────┬──────────────────────────────────────────────────────────────┤
│ Fase    │ Nome da Fase                  │ Critério de Aceite & Evidência de Sucesso                    │
├─────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ FASE 0  │ Sanitização & Limpeza MCP     │ Remover `resend` do `mcp_config.json` -> Redução de 80 tools.│
│ FASE 1  │ Governança Corporativa        │ Conectar `Linear MCP` -> Teste de criação e leitura de issue.│
│ FASE 2  │ Fundição de Dados na Nuvem    │ Conectar `Supabase MCP` -> Teste de query SQL e branch.      │
│ FASE 3  │ Observabilidade Empírica      │ Conectar `PostHog MCP` -> Teste de query HogQL de analytics. │
│ FASE 4  │ Memória Episódica             │ Conectar `Granola API` -> Teste de busca semântica de calls. │
│ FASE 5  │ Multi-Tool Gateway Hub        │ Conectar `Gumloop guMCP` -> Teste de execução de 1 workflow. │
│ FASE 6  │ Event Bus Assíncrono          │ Conectar `n8n Webhooks` -> Teste de disparo em background.   │
│ FASE 7  │ Closed-Loop Validação Total   │ Execução completa do ciclo: Reunião -> Código -> Telemetria. │
└─────────┴───────────────────────────────┴──────────────────────────────────────────────────────────────┘
```

---

*Esta auditoria forense constitui o diagnóstico absoluto e cientificamente verificado do ecossistema da Singularidade.*
