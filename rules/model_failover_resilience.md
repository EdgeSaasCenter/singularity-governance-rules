# Diretiva de Resiliência a Esgotamento de Cota e Transição de Modelos (Model Failover & Cognitive Continuity)

Esta diretriz estabelece o protocolo de sobrevivência operacional quando ocorrem erros de API (cota esgotada, rate limits, overloads) ou quando há alternância entre diferentes LLMs durante uma mesma missão.

---

## 1. O Princípio da Continuidade de Substrato

O cérebro do Agente não é o modelo de IA efêmero do turno atual; o cérebro do Agente é o **ecossistema de arquivos, regras, checkpoints e estado no disco**.
Se o modelo for substituído (ex: Claude ↔ Gemini ↔ GPT), a missão **NÃO é reiniciada**, **NÃO sofre degradação de rigor** e **NÃO exige repetição de instruções pelo usuário**.

---

## 2. Protocolo Imediato ao Assumir Após Troca ou Erro de API

Quando o Agente é acordado após um erro de sobrecarga (`API overloaded`), limite de cota (`rate limit / quota exceeded`) ou troca de modelo:

1. **Auto-Reconhecimento Silencioso (Zero Fricção):**
   - NÃO se desculpe prolixamente pelo erro do modelo anterior.
   - NÃO pergunte ao usuário *"o que estávamos fazendo?"* ou *"como posso ajudar?"*.
   - NÃO recomece tarefas que já possuem arquivos gerados ou testes aprovados.

2. **Auditoria Imediata de Estado Físico:**
   - O Agente DEVE ler os checkpoints mais recentes em `docs/micro_etapas/` ou na pasta de pesquisa correspondente.
   - Identificar com precisão milimétrica: **O que já está comitado? O que estava no meio da execução? Qual é o próximo passo exato?**

3. **Herança Inegociável de Rigor:**
   - O modelo substituto herda **integralmente** todas as regras ativas (`density_contract.md`, `atomic_execution.md`, `no_stop_hook.md`, `singularity_maturity.md`).
   - É terminantemente proibido reduzir a densidade analítica ou adotar respostas preguiçosas sob a justificativa de ser um modelo diferente.

---

## 3. Protocolo de Persistência Preventiva (Anti-Data Loss)

Para garantir que uma interrupção de cota nunca destrua o progresso:

1. **Comits Atômicos Contínuos:** Cada descoberta, código ou validação DEVE ser gravado imediatamente em disco. Nunca acumule progresso crítico apenas na memória volátil da conversa.
2. **Logs em Background Observáveis:** Tarefas em background (ex: daemons, suites de teste) devem manter logs físicos em disco para que qualquer modelo que assuma consiga ler o status via `view_file` ou `manage_task`.
3. **Savepoint Atualizado:** Ao concluir blocos significativos, registre o avanço no `savepoint_anchor.md` ou `task.md`.

---

## 4. Recomendações Práticas para o Usuário

Se uma cota de modelo se esgotar durante uma tarefa de longa duração (`/goal`):
- O sistema e o usuário podem alternar o modelo diretamente na interface sem receio de perda de contexto.
- O Agente retomará autonomamente a partir do último checkpoint comitado.
