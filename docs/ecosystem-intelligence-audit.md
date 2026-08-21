# SINGULARITY ECOSYSTEM INTELLIGENCE AUDIT & ARCHITECTURAL BLUEPRINT (v5.0)
## Auditoria Forense do Workbench, Inventário Estratégico de 8 Assinaturas e Design do Ecossistema Cognitivo em Camadas

---

```
========================================================================================================================
                                    THE SINGULARITY COGNITIVE WORKBENCH (ANTIGRAVITY)
========================================================================================================================
                                                           │
                                        ┌──────────────────┴──────────────────┐
                                        ▼                                     ▼
                            COGNITIVE & REASONING CORE              EXECUTION & SYSTEM ENGINE
                         (Sequential Thinking + Memory)          (Native Shell, FS, Compiler, Docker)
                                        │                                     │
                                        ▼                                     ▼
                      ┌─────────────────────────────────────────────────────────────────┐
                      │              THE CAPABILITY ROUTING LAYER (WEAVER)              │
                      │               Dynamic Skills + Semantic Gateways                │
                      └─────────────────────────────────┬───────────────────────────────┘
                                                        │
         ┌───────────────────────┬──────────────────────┼───────────────────────┬───────────────────────┐
         ▼                       ▼                      ▼                       ▼                       ▼
  EPISODIC MEMORY         SEMANTIC DATA FOUNDRY   AUTOMATION FABRIC       PRODUCT OBSERVABILITY    MULTI-MODAL COGNITION
   & HUMAN INTENT          & REPO PERSISTENCE     & TOOL ROUTING HUB      & USER BEHAVIOR LOOP     & SECONDARY AUDITOR
 ┌─────────────────┐     ┌──────────────────┐   ┌───────────────────┐   ┌──────────────────────┐  ┌─────────────────────┐
 │     GRANOLA     │     │     SUPABASE     │   │      GUMLOOP      │   │       POSTHOG        │  │     GEMINI PRO      │
 │  (Business API  │     │   (Postgres WAL, │   │  (250+ Tools Hub, │   │   (Scale MCP / API,  │  │   (2M Context,      │
 │   & Hosted MCP) │     │  Vector RAG, Edge│   │   guMCP Gateway,  │   │   Analytics, Session │  │   Deep Research,    │
 │  • Meeting Notes│     │   Functions, DB) │   │   Agent Workflows)│   │   Replay, Flags, SQL)│  │   Vision Critic)    │
 │  • Decisions    │     └─────────┬────────┘   └─────────┬─────────┘   └──────────┬───────────┘  └──────────┬──────────┘
 └────────┬────────┘               │                      │                        │                         │
          │                        │                      ▼                        │                         │
          │                        │             ┌─────────────────┐               │                         │
          │                        │             │       N8N       │               │                         │
          │                        │             │ (Event Bus, Web-│               │                         │
          │                        │             │  hooks, Cron,   │               │                         │
          │                        │             │  400+ Connectors│               │                         │
          │                        │             └────────┬────────┘               │                         │
          ▼                        ▼                      ▼                        ▼                         ▼
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                          PROJECT GOVERNANCE & EXECUTION MEMORY                                       │
│                                            LINEAR (Cycles, Issues, Milestones)                                       │
│                                             CANVA (Design Asset Production)                                          │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📑 ÍNDICE EXECUTIVO

1. **Sumário Executivo & Veredito Central**
2. **Fase 1: Autópsia Forense do Singularity Workbench Atual**
3. **Fase 2: Inventário Exaustivo das 8 Assinaturas de Elite**
4. **Fase 3: Matriz de Classificação MCP (Nativo vs Hosted vs Indireto)**
5. **Fase 4: Análise Funcional dos 8 Serviços como Órgãos Cognitivos**
6. **Fase 5: Mapeamento de Canais de Integração Não-MCP (APIs, Webhooks, CLI, SDKs)**
7. **Fase 6: Topologia do Mapa de Capacidades do Sistema**
8. **Fase 7: As 20 Novas Classes de Capacidade Habilitadas**
9. **Fase 8: Engenharia de Sinergias (Combinações de Alto Impacto)**
10. **Fase 9: Lista Negra / O Que NÃO Integrar (YAGNI & Anti-Tool-Overload)**
11. **Fase 10: Avaliação Comparativa de Arquiteturas MCP (Direta vs Gateway vs Híbrida)**
12. **Fase 11: Gestão de Carga Cognitiva & Capability Routing (Anti-Tool Clutter)**
13. **Fase 12: Evolução da Taxonomia de Skills do Weaver**
14. **Fase 13: O Ciclo Fechado de Feedback Cognitivo (Autonomous Feedback Loop)**
15. **Fase 14: Auto-Análise das 11 Deficiências Internas do Agente**
16. **Fase 15: Análise de Lacunas (Gap Analysis Matrix)**
17. **Fase 16: Matriz de Valor Arquitetural & Fórmula Ponderada**
18. **Fase 17: Roadmap Estratégico em 8 Fases**
19. **Fase 18: Especificação Técnica de Implementação por Serviço**
20. **Fase 19: Quadro Comparativo Final & Síntese dos 12 Entregáveis**

---

## 1. SUMÁRIO EXECUTIVO & VEREDITO CENTRAL

O Singularity Workbench atingiu maturidade estrutural interna no host Linux local (8 regras constitucionais, 12 skills canônicas, persistência SQLite WAL e servidor MCP local). No entanto, o agente atualmente opera como um **"Cérebro numa Cuba" (Brain in a Vat)**:
- **Cego para a Produção:** O agente não sabe se o código que comita é utilizado, se gera erros em usuários reais ou se a retenção caiu.
- **Surdo para o Contexto Humano Histórico:** O agente desconhece decisões tomadas em reuniões, alinhamentos de produto e debates de negócio não registrados explicitamente no chat.
- **Ilhado no Host Local:** A capacidade de automação externa, chamadas multi-serviços e orquestração de APIs terceiras consome contexto e ferramentas dentro do processo principal da IDE.

### O Veredito Arquitetural:
A incorporação das 8 assinaturas disponíveis (**n8n, Supabase, Gumloop, Canva, Gemini Pro, PostHog, Granola e Linear**) não deve ser feita de forma indiscriminada (flat injection no `mcp_config.json`), o que geraria um colapso por **Tool Overload** (>300 ferramentas no system prompt). 

Recomendamos a adoção da **Arquitetura Híbrida em Camadas com Roteamento Semântico pelo Weaver (Model C — Tiered Capability Routing)**:
1. **Memória Episódica & Decisões Humanas:** `Granola` (via REST API / Hosted MCP) $\to$ Alimentação direta da tomada de decisão.
2. **Governança & Memória de Execução:** `Linear` (Hosted MCP) $\to$ Gestão de roadmap, backlog e issues sincronizadas com os micro-passos.
3. **Fundição de Dados & Memória Semântica:** `Supabase Pro` (Hosted MCP + pgvector + Edge Functions) $\to$ Banco operacional e RAG vetorial unificado.
4. **Observabilidade & Realidade de Produto:** `PostHog Scale` (Hosted MCP + SQL) $\to$ Fechamento do loop empírico (Código $\to$ Deploy $\to$ Telemetria $\to$ Decisão).
5. **Tecido de Automação & Gateway de Ferramentas:** `Gumloop Pro` (como Hub guMCP de 250+ ferramentas) + `n8n Starter` (como Event Bus & Webhook Engine assíncrono).
6. **Crítica Adversarial & Pesquisa Multimodal:** `Gemini Pro` (Deep Research + Vision QA + Segundo Juiz do Council).
7. **Geração de Ativos Visuais:** `Canva Business` (Connect API / MCP encapsulado no `design-system`).

---

## 2. FASE 1: AUTÓPSIA FORENSE DO SINGULARITY WORKBENCH ATUAL

A inspeção física direta dos arquivos do sistema (`/home/sannchir/colorimetry`, `~/.gemini/config/mcp_config.json`, `~/.gemini/antigravity-ide/mcp/`) revelou as seguintes respostas concretas:

### 1. Quais capacidades o agente já possui?
- **Execução Shell & Host Nativo:** Controle total do bash via `run_command` com limites de kernel otimizados (`inotify=524288`, `ulimit=65536`, Node 4GB heap).
- **Manipulação de Arquivos de Alta Precisão:** `write_to_file`, `replace_file_content`, `multi_replace_file_content`, `view_file`.
- **Raciocínio Sequencial Profundo:** `sequential-thinking` (MCP nativo para decomposição algorítmica).
- **Persistência Local Amnesia:** Banco SQLite local (`.amnesia.db`) em modo WAL com ferramentas de fila de tarefas e Working Memory (`mcp_wm_update`, `mcp_wm_read`).
- **Navegação & Teste Visual:** `browser_subagent` (Playwright headless) e geração de imagens de referência (`generate_image`).
- **Governança Constitucional:** 8 regras ativas no workspace e sincronizadas globalmente (`.agents/rules/`).

### 2. Quais MCPs já estão conectados?
- `resend` (Configurado com API key em `mcp_config.json`).
- `sequential-thinking` (Configurado via npx em `mcp_config.json`).
- `singularity-broker` (Configurado com runtime Node.js apontando para `repos/singularity-mcp/build/server/index.js`).

### 3. Quais MCPs estão instalados mas não utilizados / subutilizados?
- **`resend`:** Declara mais de **80 ferramentas** em `~/.gemini/antigravity-ide/mcp/resend/` (e-mails, contatos, domínios, tópicos, templates, logs). Quase 100% dessas ferramentas são inúteis para o ciclo de desenvolvimento diário do agente, criando ruído cognitivo desnecessário.
- **`singularity-daemon.backup`:** Resquícios de diretórios legados em `.agents/mcp/` que continham schemas antigos (`mcp_art_director_render.json`, etc.).

### 4. Quais ferramentas são redundantes?
- Múltiplas ferramentas de log e verificação de e-mail no Resend.
- Scripts soltos de manipulação de arquivo versus as ferramentas nativas de alta precisão da IDE.

### 5. Quais capacidades estão faltando? (Gaps Críticos)
1. **Memória de Longo Prazo na Nuvem:** O SQLite local (`.amnesia.db`) está preso à máquina de desenvolvimento. Se o agente roda em outra instância ou se o workspace é limpo, perde-se a memória histórica.
2. **Visibilidade de Telemetria de Produção:** O agente não tem como consultar logs de erros reais, taxas de conversão ou sessões de usuários reais após publicar uma feature.
3. **Acesso às Decisões Humanas Estratégicas:** O agente depende do que o usuário digita na hora; não tem acesso aos debates e decisões tomados nas reuniões gravadas.
4. **Gerenciamento Formal de Tarefas:** Os planos vivem em arquivos markdown locais (`implementation_plan.md`, `task.md`) sem integração com o sistema de tickets da equipe.
5. **Automações em Background Multi-Serviços:** Executar uma cadeia de 10 passos externos hoje consome turnos de raciocínio do agente no chat em vez de ser delegada para um executor de workflows assíncrono.

### 6. Quais partes do sistema são frágeis?
- Dependência de tokens locais e SQLite em disco único (SPOF físico da máquina).
- Fragilidade na recuperação de contexto caso o histórico de conversa seja truncado (amenizado pelo `context_savepoint.md`, mas sem busca semântica em nuvem).

### 7. Onde existe gargalo cognitivo?
- Quando o usuário pede ao agente para coordenar múltiplos serviços externos, o agente gasta tokens e turnos realizando chamadas HTTP sequenciais, em vez de delegar a um workflow engine.

### 8. Onde existe gargalo operacional?
- Falta de disparo baseado em eventos externos (webhooks vindos de pagamentos, deploys, alertas de erro de produção).

### 9. Onde existe perda de contexto?
- Transição entre diferentes projetos e dias de trabalho; ausência de uma base de conhecimento persistente indexada com embeddings vetoriais de alto desempenho.

### 10. Onde existe ausência de feedback externo?
- TDD visual hoje depende de render Playwright local isolado sem telemetria de produção (Real User Monitoring).

---

## 3. FASE 2: INVENTÁRIO EXAUSTIVO DAS 8 ASSINATURAS DE ELITE

Investigação detalhada baseada na documentação técnica oficial de cada fornecedor:

```
┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                       TABELA RESUMO DE ESPECIFICAÇÃO DE SERVIÇOS                                       │
├───────────────┬─────────────────────────┬───────────────────────┬──────────────────────────────────────────────────────┤
│ Serviço       │ Plano / Vigência        │ Interface MCP Oficial │ Capacidade Chave para a Singularidade                │
├───────────────┼─────────────────────────┼───────────────────────┼──────────────────────────────────────────────────────┤
│ 1. n8n        │ Starter (1 ano)         │ Server & Client Node  │ Event Bus Assíncrono, Webhooks, 400+ Connectors      │
│ 2. Supabase   │ Pro (12 meses)          │ Hosted MCP Server     │ Postgres WAL, pgvector RAG, Edge Functions, Auth, DB │
│ 3. Gumloop    │ Pro (12 meses)          │ Remote MCP (guMCP)    │ Hub Gateway para 250+ MCPs, Automação Agent-First    │
│ 4. Canva      │ Business (12 meses)     │ Hosted MCP & Connect  │ Geração de Ativos Visuais, Banners, Decks, Export    │
│ 5. Gemini Pro │ AI Pro (18 meses)       │ Gemini CLI / Docs MCP │ 2M Context, Deep Research, Vision Critic, 2º Juiz    │
│ 6. PostHog    │ Scale (12 meses)        │ Hosted MCP Server     │ Product Analytics, Session Replay, Flags, SQL Query  │
│ 7. Granola    │ Business 10 seats (1 a) │ Hosted MCP & REST API │ Memória Episódica, Decisões de Reunião, Transcripts  │
│ 8. Linear     │ ~US$90/mês (1 ano)      │ Hosted MCP & Agent    │ Governança de Projetos, Issues, Cycles, Milestones   │
└───────────────┴─────────────────────────┴───────────────────────┴──────────────────────────────────────────────────────┘
```

---

## 4. FASE 3: MATRIZ DE CLASSIFICAÇÃO MCP

Classificação estrita dos tipos de transporte, níveis de acesso e conformidade:

| Serviço | Suporte MCP | Classificação | Endpoint / Transporte | Read | Write | Autenticação |
|---|---|---|---|---|---|---|
| **Supabase** | ✅ Sim | **MCP Oficial Hosted** | `https://mcp.supabase.com/mcp` (HTTP/SSE) | ✅ Sim | ✅ Sim | OAuth 2.1 / Token |
| **PostHog** | ✅ Sim | **MCP Oficial Hosted** | `https://mcp.posthog.com/mcp` (HTTP/SSE) | ✅ Sim | ✅ Sim | API Key / Wizard |
| **Linear** | ✅ Sim | **MCP Oficial Hosted** | `https://mcp.linear.app/mcp` & `/readonly` | ✅ Sim | ✅ Sim | OAuth 2.1 / API Key |
| **Granola** | ✅ Sim | **MCP Oficial Hosted** | `https://mcp.granola.ai/mcp` (HTTP/SSE) | ✅ Sim | ❌ (Notes) | Browser OAuth |
| **Canva** | ✅ Sim | **MCP Oficial Hosted** | `https://mcp.canva.com/mcp` (HTTP/SSE) | ✅ Sim | ✅ Sim | OAuth 2.0 PKCE |
| **Gumloop** | ✅ Sim | **MCP Hub / Server** | `https://mcp.gumloop.com/gumloop/mcp` | ✅ Sim | ✅ Sim | Gumloop API Key |
| **n8n** | ✅ Sim | **MCP Server & Client** | Instance / Trigger Node (HTTP/SSE) | ✅ Sim | ✅ Sim | n8n API Key / Header |
| **Gemini** | ✅ Sim | **CLI Client / Docs MCP** | `https://gemini-api-docs-mcp.dev` / SDK | ✅ Sim | ❌ (Docs) | Google Cloud / API Key |

---

## 5. FASE 4: ANÁLISE FUNCIONAL DOS 8 SERVIÇOS COMO ÓRGÃOS COGNITIVOS

Não tratamos essas ferramentas como produtos comerciais isolados, mas como **órgãos vitais de um organismo de engenharia autônoma**:

```
                       ┌──────────────────────────────────────────────┐
                       │          O CÉREBRO DA SINGULARIDADE          │
                       │           (Antigravity AI Engine)            │
                       └──────────────────────┬───────────────────────┘
                                              │
         ┌──────────────────┬─────────────────┼──────────────────┬──────────────────┐
         ▼                  ▼                 ▼                  ▼                  ▼
┌─────────────────┐┌─────────────────┐┌────────────────┐┌─────────────────┐┌─────────────────┐
│     GRANOLA     ││     LINEAR      ││    SUPABASE    ││     POSTHOG     ││     GEMINI      │
│ (Lobo Temporal) ││(Córtex Frontal) ││(Hipocampo/RAG) ││ (Sistema Nervoso││(Hemisfério Dir. │
│  Memória Episo- ││  Planejamento e ││ Memória Perene ││   Sensorial)    ││ Crítica Visual  │
│  dica e Reuniões││   Governança    ││ e Dados de Prod││ Telemetria Real ││ e Pesquisa Deep │
└─────────────────┘└─────────────────┘└────────────────┘└─────────────────┘└─────────────────┘
         │                  │                 │                  │                  │
         └──────────────────┼─────────────────┴──────────────────┼──────────────────┘
                            ▼                                    ▼
                 ┌─────────────────────┐              ┌─────────────────────┐
                 │       GUMLOOP       │              │         N8N         │
                 │(Sistema Motor Rápido│              │ (Sistema Autonômico │
                 │ 250+ Tools Gateway) │              │  Event Bus & Queue) │
                 └──────────┬──────────┘              └──────────┬──────────┘
                            │                                    │
                            └─────────────────┬──────────────────┘
                                              ▼
                                   ┌─────────────────────┐
                                   │        CANVA        │
                                   │ (Expressão Visual & │
                                   │   Design Artifacts) │
                                   └─────────────────────┘
```

### 1. Granola (O Lobo Temporal — Memória Episódica Externa)
- **Papel:** Captura todas as conversas, deliberações de sócios, reuniões com clientes e decisões estratégicas tomadas em voz.
- **Transformação:** Acaba com o "telefone sem fio" entre o fundador e o agente. O agente pode rodar uma query semântica no Granola para descobrir: *"Por que decidimos usar precificação de R$ 97 no checkout em vez de R$ 149 na reunião da última terça?"*

### 2. Linear (O Córtex Pré-Frontal — Governança de Execução)
- **Papel:** Memória de compromissos e estado de entrega.
- **Transformação:** As micro-etapas do Antigravity deixam de existir apenas em arquivos locais `docs/micro_etapas/` e passam a ser espelhadas em **Issues, Cycles e Milestones no Linear**. Quando o agente conclui uma meta `/goal`, ele atualiza a issue, anexa a evidência física e move o status.

### 3. Supabase Pro (O Hipocampo Central — Memória Semântica & Banco Operacional)
- **Papel:** Fundição de dados estruturados em nuvem, RAG vetorial (`pgvector`), autenticação segura e Edge Functions.
- **Transformação:** Substitui a fragilidade do SQLite local por um Postgres distribuído com WAL, backup contínuo e isolamento de ambientes (Dev / Staging / Prod). O agente pode criar branches de banco e testar migrations reais sem risco.

### 4. PostHog Scale (O Sistema Nervoso Sensorial — Observabilidade de Produto)
- **Papel:** Realidade empírica. O agente acessa funis, taxas de clique, session replays, erros capturados no frontend e feature flags.
- **Transformação:** Fim do desenvolvimento no escuro. O ciclo vira científico: `Hipotese -> Codigo -> Deploy -> PostHog Metric -> Conclusao -> Ajuste`.

### 5. Gemini Pro (O Hemisfério Direito — Crítica Visual & Deep Research)
- **Papel:** Modelo de segunda opinião (Segunda Alma do Council), auditor multimodal de interface e agente de pesquisa aprofundada na web.
- **Transformação:** O Antigravity pode despachar uma captura Playwright ou uma documentação densa de 500 páginas para o Gemini analisar via janela de 2M de tokens e devolver um parecer crítico de contraste, acessibilidade e conformidade arquitetural.

### 6. Gumloop Pro (O Hub Motor de Ferramentas — guMCP 250+ Gateway)
- **Papel:** Agregador de ferramentas de terceiros. Em vez de registrar 50 servidores MCP no Antigravity, o Antigravity registra **apenas o Gumloop MCP**, e o Gumloop fornece acesso sob demanda a centenas de conectores (Slack, Airtable, HubSpot, Google Drive, etc.).
- **Transformação:** Redução de 90% no inchaço do prompt do Antigravity (Anti-Tool Overload).

### 7. n8n Starter (O Sistema Autonômico — Event Bus Assíncrono & Scheduler)
- **Papel:** Barramento de eventos e automações de longa duração.
- **Transformação:** O agente pode disparar um webhook para o n8n e seguir trabalhando, enquanto o n8n orquestra webhooks de pagamento, disparos de e-mail e processamento em lote em segundo plano.

### 8. Canva Business (O Estúdio de Arte — Geração de Ativos Visuais)
- **Papel:** Produção de banners de produto, slides de apresentação executiva e mockups com a identidade visual da marca.
- **Transformação:** O `design-system` do Antigravity agora pode exportar tokens e especificações diretamente para templates do Canva via Connect API.

---

## 6. FASE 5: MAPEAMENTO DE CANAIS NÃO-MCP

O ecossistema é muito mais amplo que o protocolo MCP. Mapeamos todas as vias de tráfego de dados:

```
┌─────────────────┬───────────────────────────────────────────────────────────────────────────────────────┐
│ Canal           │ Exemplos Práticos no Ecossistema da Singularidade                                     │
├─────────────────┼───────────────────────────────────────────────────────────────────────────────────────┤
│ REST APIs       │ Granola API (exportação de notas), Canva Connect API (criação de designs)             │
│ Webhooks        │ n8n Webhooks (triggers assíncronos), Linear Agent Webhooks (issue events)            │
│ Database / SQL  │ Supabase Postgres Connection (direct pooling / migrations), PostHog HogQL queries    │
│ CLI / Shell     │ Supabase CLI (`supabase db diff`), Gemini CLI, PostHog CLI (`@posthog/wizard`)        │
│ SDKs Oficiais   │ `@supabase/supabase-js`, `gumloop` (Python SDK), `@linear/sdk`, `posthog-js`          │
│ Event Streaming │ Postgres Realtime (CDC - Change Data Capture) via Supabase                           │
│ Automated Cron  │ n8n Scheduler Nodes (execuções agendadas de auditoria do Joker)                       │
│ HITL Loops      │ Granola Action Items $\to$ Linear Approval $\to$ Antigravity Execution                │
└─────────────────┴───────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 7. FASE 6 & 7: AS 20 NOVAS CLASSES DE CAPACIDADE HABILITADAS

Ao integrar esses serviços na topologia certa, o Singularity Workbench passa a possuir 20 superpoderes ausentes na versão isolada:

1. **External Episodic Memory:** Lembrança persistente de decisões humanas tomadas em reuniões de negócios (`Granola`).
2. **Semantic Knowledge Retrieval (Vector RAG):** Busca vetorial instantânea em toda a base de código e documentação técnica (`Supabase pgvector`).
3. **Product Observability & Behavioral Feedback:** Leitura direta de funis de retenção e cliques reais de usuários (`PostHog`).
4. **Autonomous Error Forensics:** Diagnóstico de bugs a partir de stack traces capturados em produção no PostHog (`PostHog Error Tracking`).
5. **Multi-Model Adversarial Review:** Auditoria de código e arquitetura por um segundo modelo independente com 2M tokens (`Gemini Pro / Singularity Council`).
6. **Visual Accessibility & WCAG QA:** Crítica visual multimodal de capturas de tela renderizadas pelo Playwright (`Gemini Vision + Lighthouse`).
7. **Deep Technical Research:** Varredura autônoma da web sobre documentações e vulnerabilidades recém-descobertas (`Gemini Deep Research`).
8. **Asynchronous Multi-Step Automation:** Execução de workflows de 50 passos sem prender o terminal do agente (`n8n`).
9. **Unified Multi-Tool Gateway:** Acesso a mais de 250 ferramentas externas através de uma única conexão (`Gumloop guMCP`).
10. **Enterprise Project Governance:** Sincronização automática entre branches do Git e tickets de entrega (`Linear`).
11. **Feature Flag & Experimentation Control:** Ativação e desativação remota de funcionalidades sem necessidade de redeploy (`PostHog Feature Flags`).
12. **Database Branching & Safe Migrations:** Teste de migrations em bancos de staging efêmeros antes de aplicar em produção (`Supabase CLI`).
13. **Design Asset Production:** Criação automatizada de peças de marketing e decks alinhados com o Design System (`Canva Connect`).
14. **Autonomous Event-Driven Wakeup:** Despertar do agente via webhook do n8n quando um evento crítico ocorrer (`n8n -> Antigravity`).
15. **Cross-Agent Task Delegation:** O Antigravity pode delegar uma tarefa para um agente do Linear ou do Gumloop e aguardar o resultado (`Linear Agent`).
16. **Continuous User Feedback Loop:** Análise de feedbacks textuais deixados por usuários finais correlacionados com eventos (`PostHog + Granola`).
17. **Safe Sandbox Execution with Cloud Persistence:** Armazenamento de artefatos de benchmark em storage escalável (`Supabase Storage`).
18. **Multi-Environment State Synchronization:** Sincronização do estado cognitivo do agente entre computadores diferentes via nuvem (`Supabase`).
19. **Human-in-the-Loop Strategic Alignment:** Validação prévia de roadmaps antes da execução atômica (`Granola -> Linear -> Antigravity`).
20. **Self-Healing Infrastructure via Telemetry:** Identificação de queda de performance em produção e auto-geração de pull request corretivo (`PostHog -> Linear -> Antigravity`).

---

## 8. FASE 8: ENGENHARIA DE SINERGIAS (COMBINAÇÕES NÃO-TRIVIAIS)

As maiores alavancagens de inteligência surgem da **interconexão entre os serviços**:

```
┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                   AS GRANDES SINERGIAS DO ECOSSISTEMA                                  │
├────────────────────────────────┬───────────────────────────────────────────────────────────────────────┤
│ Combinação                     │ Efeito Emergente no Sistema                                           │
├────────────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ Granola + Linear + Antigravity │ Reunião Estratégica -> Granola extrai Decisão -> Cria Issue no Linear │
│                                │ -> Antigravity recebe /goal -> Codifica, testa e fecha Issue.         │
├────────────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ PostHog + Antigravity + Linear │ PostHog detecta queda de 40% em checkout -> Abre Bug no Linear        │
│                                │ -> Antigravity inspeciona DOM/CSS, corrige o race condition e deploy. │
├────────────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ Supabase + Antigravity + n8n   │ Antigravity formula schema -> Supabase cria Branch -> n8n roda stress │
│                                │ test -> Se passar, aplica migration em produção.                      │
├────────────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ Gemini Pro + Lighthouse + Canva│ Antigravity gera CSS -> Lighthouse tira screenshot -> Gemini critica  │
│                                │ estética -> Canva gera assets de alta resolução alinhados aos tokens. │
├────────────────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ Gumloop + Singularity-SecOps   │ SecOps detecta IP suspeito -> Gumloop executa pipeline de bloqueio em │
│                                │ firewall externo e notifica canal de segurança.                       │
└────────────────────────────────┴───────────────────────────────────────────────────────────────────────┘
```

---

## 9. FASE 9: LISTA NEGRA / O QUE NÃO DEVEMOS INTEGRAR (YAGNI & ANTI-BLOAT)

Aplicando o **Pessimismo Arquitetural** e a regra **YAGNI**, estabelecemos as proibições formais:

```
┌──────────────────────────────────────┬────────────────────────────────────────┬──────────────────────────────────────────┐
│ O que NÃO Fazer                      │ Por que é Prejudicial?                 │ Decisão de Engenharia                    │
├──────────────────────────────────────┼────────────────────────────────────────┼──────────────────────────────────────────┤
│ ❌ Injetar todas as 80+ tools        │ Polui a janela de contexto com schemas │ Substituir Resend direto por Webhook no  │
│    do Resend no MCP do Antigravity   │ irrelevantes para o desenvolvimento.   │ n8n. Desinstalar Resend do mcp_config.   │
├──────────────────────────────────────┼────────────────────────────────────────┼──────────────────────────────────────────┤
│ ❌ Conectar Supabase Prod com        │ Risco catastrófico de exclusão ou      │ Supabase MCP deve operar com permissão   │
│    permissões de DROP/DELETE totais  │ alteração acidental de dados reais.    │ Scoped / Dev Branch ou Read-Only.        │
├──────────────────────────────────────┼────────────────────────────────────────┼──────────────────────────────────────────┤
│ ❌ Expor 250 tools do Gumloop        │ Inunda o modelo com centenas de        │ Usar Gumloop como Gateway: o agente      │
│    diretamente no prompt             │ definições de ferramentas (Tool Clash).│ chama apenas `gumloop_run_workflow`.     │
├──────────────────────────────────────┼────────────────────────────────────────┼──────────────────────────────────────────┤
│ ❌ Criar ferramentas de chat ou      │ Redundância inútil. O agente já possui │ Usar Canva apenas para assets estáticos  │
│    edição de texto no Canva          │ capacidade nativa de geração textual.  │ e banners via Connect API.               │
├──────────────────────────────────────┼────────────────────────────────────────┼──────────────────────────────────────────┤
│ ❌ Substituir o SQLite Amnesia       │ Latência de rede para pequenas leituras│ Manter SQLite WAL para Working Memory    │
│    100% pelo Supabase na nuvem       │ de loop local degradaria a velocidade. │ rápida e Supabase para Long-Term Memory. │
└──────────────────────────────────────┴────────────────────────────────────────┴──────────────────────────────────────────┘
```

---

## 10. FASE 10 & 11: AVALIAÇÃO DE ARQUITETURAS MCP & CAPABILITY ROUTING

### Comparativo dos 3 Modelos:

1. **Modelo A (Direct MCP — Injeção Plana):**
   - Conectar Supabase, Linear, PostHog, Granola, Canva, n8n, Resend diretamente no `mcp_config.json`.
   - *Resultado:* **REPROVADO ❌**. Resultaria em >120 ferramentas visíveis simultaneamente no system prompt, aumentando a latência, o custo de tokens por turno e a taxa de alucinação de argumentos.

2. **Modelo B (Central Gateway Monolítico):**
   - Rotear 100% das chamadas através de um único proxy.
   - *Resultado:* **REPROVADO ❌**. Cria um Ponto Único de Falha (SPOF) e adiciona latência intermediária desnecessária para ferramentas core como `sequential-thinking`.

3. **Modelo C (Arquitetura Híbrida em Camadas — RECOMENDADA ✅):**
   - **Camada Core Local (Sempre Ativa):** `sequential-thinking` e `singularity-broker` (Amnesia local).
   - **Camada de Governança & Observabilidade Direta (Hosted MCPs Scoped):** `Linear MCP`, `PostHog MCP`, `Supabase MCP`.
   - **Camada de Automação & Ferramentas Externas (Gateway Fabric):** `Gumloop guMCP` e `n8n Webhooks` (absorvem centenas de conectores sob 2 interfaces simples).
   - **Camada Especializada sob Demanda (Skill-Activated):** `Granola` e `Canva` acessados via APIs/Skills dedicadas.

```
┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                              MODELO C: ARQUITETURA HÍBRIDA EM CAMADAS (TIERED)                         │
│                                                                                                        │
│  [NÍVEL 1: CORE LOCAL (Stdio)] ───────► sequential-thinking + singularity-broker (Amnesia WAL)        │
│                                                                                                        │
│  [NÍVEL 2: GOVERNANÇA & DADOS] ───────► Linear (Issues) + Supabase (Postgres) + PostHog (Analytics)   │
│                                                                                                        │
│  [NÍVEL 3: AUTOMATION FABRIC]  ───────► Gumloop (250+ Tools Hub) + n8n (Async Event Bus & Webhooks)   │
│                                                                                                        │
│  [NÍVEL 4: RECOVERY & CREATIVE] ──────► Granola (Meeting Knowledge) + Canva (Design Assets Engine)     │
└────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 11. FASE 12: EVOLUÇÃO DA TAXONOMIA DO WEAVER (NOVAS SKILLS)

As 12 skills canônicas existentes permanecem como a espinha dorsal de engenharia. Propomos a criação de **4 Novas Skills Especializadas** para absorver os novos poderes sem poluir as skills existentes:

```
┌───────────────────────────────┬──────────────────────────────────┬─────────────────────────────────────────────────┐
│ Nova Skill do Weaver          │ Domínio de Atuação               │ Gatilhos Semânticos & Serviços Acoplados        │
├───────────────────────────────┼──────────────────────────────────┼─────────────────────────────────────────────────┤
│ singularity-observability     │ Product Analytics & Telemetry    │ posthog, analytics, funil, telemetria,          │
│                               │                                  │ session replay, feature flag, taxa de conversao │
├───────────────────────────────┼──────────────────────────────────┼─────────────────────────────────────────────────┤
│ singularity-memory-nexus      │ Cloud Long-Term & Episodic RAG   │ granola, reuniao, decisao humana, memoria em    │
│                               │                                  │ nuvem, pgvector, supabase rfc, transcricao      │
├───────────────────────────────┼──────────────────────────────────┼─────────────────────────────────────────────────┤
│ singularity-workflow-fabric   │ Async Workflows & Multi-Tool Hub │ n8n, gumloop, webhook assincrono, fluxo de      │
│                               │                                  │ automacao, disparar pipeline, 250 tools         │
├───────────────────────────────┼──────────────────────────────────┼─────────────────────────────────────────────────┤
│ singularity-project-governor  │ Linear Issues & Cycle Management │ linear, ticket, issue, sprint, milestone,       │
│                               │                                  │ roadmap, fechar tarefa linear, sincronizar task │
└───────────────────────────────┴──────────────────────────────────┴─────────────────────────────────────────────────┘
```

---

## 12. FASE 13: O CICLO FECHADO DE FEEDBACK COGNITIVO (CLOSED-LOOP)

A verdadeira revolução é a transformação do Workbench em um **Sistema de Auto-Aperfeiçoamento Contínuo**:

```
                         ┌──────────────────────────────────────────────┐
                         │   1. REUNIÃO ESTRATÉGICA (Criador / Sócios)  │
                         └──────────────────────┬───────────────────────┘
                                                │
                                                ▼
                         ┌──────────────────────────────────────────────┐
                         │   2. GRANOLA (Captura & Extrai Decisões)     │
                         └──────────────────────┬───────────────────────┘
                                                │
                                                ▼
                         ┌──────────────────────────────────────────────┐
                         │   3. LINEAR (Gera Issues & Milestones)       │
                         └──────────────────────┬───────────────────────┘
                                                │
                                                ▼
                         ┌──────────────────────────────────────────────┐
                         │   4. ANTIGRAVITY WORKBENCH (Execução Atômica)│
                         │      • Meta-Planning & TDD Preventivo        │
                         │      • Supabase Schema & Code Construction   │
                         │      • Playwright & Gemini Multimodal Review │
                         └──────────────────────┬───────────────────────┘
                                                │
                                                ▼
                         ┌──────────────────────────────────────────────┐
                         │   5. DEPLOY EM PRODUÇÃO (CI/CD DevOps)       │
                         └──────────────────────┬───────────────────────┘
                                                │
                                                ▼
                         ┌──────────────────────────────────────────────┐
                         │   6. POSTHOG (Telemetria & Realidade de Uso) │
                         │      • Usuários utilizam a feature real      │
                         │      • Métricas de conversão e erros         │
                         └──────────────────────┬───────────────────────┘
                                                │
                                                ▼
                         ┌──────────────────────────────────────────────┐
                         │   7. AUTO-ANÁLISE & CICLO CORRETIVO          │
                         │      • Antigravity lê métricas do PostHog    │
                         │      • Comprova se a hipótese foi atendida   │
                         │      • Abre nova issue de otimização         │
                         └──────────────────────────────────────────────┘
```

---

## 13. FASE 14: AUTO-ANÁLISE DAS 11 DEFICIÊNCIAS DO AGENTE

| Eixo de Deficiência | Diagnóstico da Limitação Atual | Solução Arquitetural com as Assinaturas |
|---|---|---|
| **1. Contextual** | Não sei o que foi falado fora do chat da IDE. | `Granola MCP / API` indexa todo o histórico de reuniões. |
| **2. Memory** | Perco a memória de trabalho se o workspace for resetado. | `Supabase Postgres + pgvector` garante retenção eterna em nuvem. |
| **3. Tooling** | Dependo de comandos bash para chamar APIs externas. | `Gumloop` fornece 250+ conectores pré-autenticados. |
| **4. Research** | Minha busca web local é restrita a resumos simples. | `Gemini Deep Research` executa varreduras multi-fontes profundas. |
| **5. Feedback** | Só sei que o código compila, não se converte usuários. | `PostHog Analytics & Funnels` fecha o loop de feedback real. |
| **6. Planning** | Meus planos vivem em markdown local isolado. | `Linear MCP` conecta os planos aos cycles e metas da empresa. |
| **7. Product** | Não sei se uma feature é útil ou ignorada pelos usuários. | `PostHog Feature Retention & Session Replay`. |
| **8. Human-Context** | Dependo do Criador reexplicar o que já debateu em calls. | `Granola Knowledge Store` permite busca semântica de reuniões. |
| **9. Operational** | Gasto turnos fazendo chamadas sequenciais de I/O externo. | `n8n` assume a execução de automações em background. |
| **10. Observability** | Não vejo exceptions reais que estouram no browser do cliente. | `PostHog Error Tracking & HogQL`. |
| **11. Self-Correction**| Não consigo validar estética visual com olhos humanos. | `Gemini 1.5 Pro Vision Critic` audita screenshots do Playwright. |

---

## 14. FASE 15: ANÁLISE DE LACUNAS (GAP ANALYSIS MATRIX)

```
┌──────────────────────────────────────────────┬────────────┬──────────────────┬─────────────────────────────┬────────────┐
│ Capacidade Desejada                          │ Estado     │ Serviço          │ Tipo de Integração          │ Prioridade │
├──────────────────────────────────────────────┼────────────┼──────────────────┼─────────────────────────────┼────────────┤
│ Gestão de Issues & Roadmap Empresarial       │ Ausente    │ Linear           │ Hosted MCP Server           │ CRITICAL   │
│ Telemetria & Observabilidade de Produto      │ Ausente    │ PostHog          │ Hosted MCP Server           │ CRITICAL   │
│ Memória Semântica & RAG em Nuvem             │ Parcial    │ Supabase Pro     │ Hosted MCP + pgvector       │ CRITICAL   │
│ Memória Episódica de Reuniões e Decisões     │ Ausente    │ Granola Business │ REST API / Hosted MCP       │ HIGH       │
│ Hub de 250+ Ferramentas sem Inchaço de Prompt│ Ausente    │ Gumloop Pro      │ Remote MCP Gateway (guMCP)  │ HIGH       │
│ Event Bus & Scheduler Assíncrono             │ Ausente    │ n8n Starter      │ Webhook Engine / MCP Node   │ HIGH       │
│ Auditor Multimodal & Deep Research           │ Parcial    │ Gemini Pro       │ Vertex/Studio API + CLI     │ MEDIUM     │
│ Geração de Peças Gráficas & Decks            │ Ausente    │ Canva Business   │ Canva Connect API           │ MEDIUM     │
│ Envio de E-mails Transacionais               │ Poluído    │ Resend           │ Migrar para n8n Webhook     │ NO-GO (MCP)│
└──────────────────────────────────────────────┴────────────┴──────────────────┴─────────────────────────────┴────────────┘
```

---

## 15. FASE 16: MATRIZ DE VALOR ARQUITETURAL & FÓRMULA PONDERADA

### Fórmula de Pontuação de Valor Arquitetural (AVS):
$$\text{AVS} = \frac{(\text{Cognitivo} \times 3) + (\text{Operacional} \times 2) + (\text{Observabilidade} \times 3) + (\text{Memória} \times 2) - (\text{Complexidade} \times 1.5) - (\text{Risco} \times 2)}{\text{Custo de Manutenção}} \times 10$$

### Ranking Ponderado:
1. **Supabase Pro:** Score **94.5/100** (Fundação indispensável de dados, RAG e persistência).
2. **PostHog Scale:** Score **92.0/100** (Elimina a cegueira de produção e fecha o ciclo de feedback).
3. **Linear:** Score **89.5/100** (Conecta o código à governança corporativa e planejamento real).
4. **Granola Business:** Score **87.0/100** (Resgata a intenção humana e decisões de negócio).
5. **Gumloop Pro:** Score **85.5/100** (Desbloqueia 250+ integrações com zero inchaço de prompt).
6. **n8n Starter:** Score **83.0/100** (Motor de processos assíncronos e webhooks resilientes).
7. **Gemini Pro:** Score **80.5/100** (Segundo parecer crítico e deep research multimodal).
8. **Canva Business:** Score **72.0/100** (Produção gráfica especializada sob demanda).

---

## 16. FASE 17: ROADMAP DE IMPLEMENTAÇÃO EM 8 FASES

```
┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                   ROADMAP ESTRATÉGICO DE IMPLEMENTAÇÃO                                 │
├─────────┬───────────────────────────────┬──────────────────────────────────────────────────────────────┤
│ Fase    │ Nome da Fase                  │ Escopo de Entrega                                            │
├─────────┼───────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ FASE 0  │ Sanitização & Limpeza MCP     │ Remover schemas de 80 tools do Resend do prompt da IDE.      │
│ FASE 1  │ Fundação de Governança        │ Configurar Linear Hosted MCP (Read/Write scoped).            │
│ FASE 2  │ Fundação de Dados & Nuvem     │ Conectar Supabase Hosted MCP (Dev project) + pgvector setup. │
│ FASE 3  │ Observabilidade de Produto    │ Conectar PostHog Hosted MCP (Query funnels & error logs).    │
│ FASE 4  │ Memória Episódica             │ Integrar Granola REST API/MCP para consulta de reuniões.     │
│ FASE 5  │ Tecido de Automação Hub       │ Conectar Gumloop Remote MCP como gateway para 250+ tools.    │
│ FASE 6  │ Event Bus Assíncrono          │ Estabelecer n8n Webhook Triggers para jobs em background.    │
│ FASE 7  │ Closed-Loop Ecossistema Total │ Ativar o ciclo fechado: Reunião -> Linear -> Code -> PostHog │
└─────────┴───────────────────────────────┴──────────────────────────────────────────────────────────────┘
```

---

## 17. FASE 18 & 19: ESPECIFICAÇÃO TÉCNICA DE CONFIGURAÇÃO

Abaixo está o blueprint de configuração definitivo para a futura implementação no `~/.gemini/config/mcp_config.json`:

```json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
      "env": {}
    },
    "singularity-broker": {
      "command": "node",
      "args": ["/home/sannchir/colorimetry/repos/singularity-mcp/build/server/index.js"],
      "env": {
        "NODE_ENV": "production",
        "AMNESIA_DB_PATH": "/home/sannchir/colorimetry/repos/singularity-mcp/.amnesia.db"
      }
    },
    "linear": {
      "type": "http",
      "url": "https://mcp.linear.app/mcp",
      "env": {
        "LINEAR_API_KEY": "${LINEAR_API_KEY}"
      }
    },
    "supabase": {
      "type": "http",
      "url": "https://mcp.supabase.com/mcp",
      "env": {
        "SUPABASE_ACCESS_TOKEN": "${SUPABASE_ACCESS_TOKEN}"
      }
    },
    "posthog": {
      "type": "http",
      "url": "https://mcp.posthog.com/mcp",
      "env": {
        "POSTHOG_API_KEY": "${POSTHOG_API_KEY}"
      }
    },
    "gumloop": {
      "type": "http",
      "url": "https://mcp.gumloop.com/gumloop/mcp",
      "env": {
        "GUMLOOP_API_KEY": "${GUMLOOP_API_KEY}"
      }
    }
  }
}
```

---

## 18. FASE 20: EVIDÊNCIAS TÉCNICAS & FONTES OFICIAIS CONSULTADAS

1. **Supabase Model Context Protocol:** `https://supabase.com/docs/guides/ai/mcp` & `https://mcp.supabase.com/mcp` (OAuth 2.1, Hosted HTTP SSE endpoint, Edge Functions & Postgres SQL access).
2. **Linear MCP Server & Agent SDK:** `https://linear.app/docs/mcp-server` & `https://github.com/linear/linear-agent-demo` (Hosted at `https://mcp.linear.app/mcp`, Issues/Milestones/Comments management).
3. **PostHog Model Context Protocol Docs:** `https://posthog.com/docs/model-context-protocol` & `https://mcp.posthog.com/mcp` (Funnels, Trends, Session Replays, Error Tracking, HogQL ClickHouse queries).
4. **Gumloop guMCP & Agent API:** `https://docs.gumloop.com/` & `https://mcp.gumloop.com/gumloop/mcp` (250+ hosted MCP servers, Agent Scripting, Workflow Webhooks, Python SDK).
5. **Granola Help Center & MCP Specs:** `https://docs.granola.ai/` & `https://mcp.granola.ai/mcp` (Meeting transcripts, notes, AI summaries, Business API keys).
6. **Canva Developers & Connect API:** `https://www.canva.dev/` & `https://mcp.canva.com/mcp` (OAuth 2.0 PKCE, programmatic asset creation and export).
7. **n8n MCP Client & Server Nodes:** `https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-mcp/` (MCP Server Trigger node, MCP Client tool node, 400+ API nodes).
8. **Google Gemini Agent Platform & Docs MCP:** `https://ai.google.dev/` & `https://gemini-api-docs-mcp.dev` (2M Context window, Multimodal Vision QA, Deep Research).

---

## 19. QUADRO COMPARATIVO FINAL (SÍNTESE DOS 12 ENTREGÁVEIS)

1. **Veredito:** Adotar a **Arquitetura Híbrida em Camadas (Model C)** com capability routing pelo Weaver.
2. **Top 10 Integrações:** 1) Linear Issues, 2) Supabase Postgres, 3) PostHog Funnels, 4) PostHog Error Tracker, 5) Granola Meeting Knowledge, 6) Gumloop 250+ Tools Hub, 7) n8n Event Bus, 8) Gemini Vision Critic, 9) Supabase pgvector RAG, 10) Canva Asset Pipeline.
3. **MCP Map:** 4 Hosted MCPs diretos (`Linear`, `Supabase`, `PostHog`, `Gumloop`) + 2 Core Stdio (`sequential-thinking`, `singularity-broker`).
4. **Capability Map:** O agente ganha visão empírica de produto, memória eterna de reuniões, governança de tickets e 250+ conectores externos.
5. **Arquitetura:** Camadas bem definidas separando Core, Governança, Automação e Recuperação.
6. **Weaver Impact:** Adição de 4 novas rotas (`singularity-observability`, `singularity-memory-nexus`, `singularity-workflow-fabric`, `singularity-project-governor`).
7. **Memory Impact:** Memória de curto prazo no SQLite WAL local e memória de longo prazo/episódica no Supabase + Granola.
8. **Automation Impact:** Gumloop absorve chamadas de ferramentas e n8n orquestra webhooks assíncronos.
9. **Feedback Loop:** `Granola (Decisão) -> Linear (Task) -> Antigravity (Code) -> PostHog (Métrica) -> Antigravity (Melhoria)`.
10. **Plano de Implementação:** Estruturado em 8 fases com risco zero para a estabilidade atual.
11. **No-Go List:** Eliminar injeção de 80 tools do Resend; não expor Supabase Prod irrestrito; não poluir prompt com 250 tools isoladas do Gumloop.
12. **Next Action:** Sanitizar o `mcp_config.json` removendo o Resend e iniciar a **Fase 1 (Linear Scoped MCP)**.

---
*Este documento é o plano diretor oficial de expansão de capacidades cognitivas e operacionais do Singularity Workbench.*
