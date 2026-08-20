---
trigger: always_on
---
# Lei do Contrato de Densidade (Anti-Entrega Ansiosa)

**Origem:** Falha empírica documentada em 2026-08-19. O Agente produziu 144 arquivos com estrutura correta e conteúdo plano (tabelas mecânicas de DOMÍNIO/STATUS), violando o espírito da Diretiva Atômica sem violar sua letra. Esta lei fecha essa brecha com critérios operacionais mensuráveis.

---

## Definição de Densidade Epistêmica Mínima Aceitável

Um artefato gerado pelo Agente possui **densidade epistêmica válida** se e somente se ele satisfaz **todos** os critérios abaixo:

1. **Problema Arquitetural Não Trivial:** Deve existir pelo menos um cenário real de falha, pressão de sistema, corrida de dados, degradação ou ataque hostil que justifique a existência daquele artefato. *"Domínio + Ação + Status"* não constitui problema arquitetural. Um título e uma linha de descrição também não.

2. **Destruição da Solução Óbvia (Máquina de Divergência):** A primeira solução ingênua DEVE ser explicitamente nomeada, descrita e destruída com uma crítica técnica fundamentada. Só após a destruição a solução resiliente pode ser apresentada. Pulando a destruição, o artefato é considerado raso.

3. **Contrato Técnico ou Fragmento de Código:** Um invariante, schema Zod, algoritmo POSIX, lógica de Circuit Breaker, fórmula de colorimetria ou padrão de locking que **prove** a solução — não que a descreva em prosa vaga.

4. **Teste de Falsificação ou Carga Hostil:** Não o "caminho feliz". O teste mental ou físico DEVE invocar o cenário adversarial que tentaria destruir a solução — e demonstrar concretamente como o sistema contém e sobrevive.

5. **Validação Dinâmica de Delta de Estado (Anti-QA Estático):**
   Para qualquer interface visual ou elemento interativo (botão, badge, modal, toggle, formulário), é EXPRESSAMENTE PROIBIDO usar testes de existência estática (`content.includes('id="..."')`, `grep`, checagem de texto bruto) como evidência de funcionamento. A validação DEVE ser dinâmica, comprovando o ciclo de vida real:
   - **Estado Anterior:** Leitura do valor/classe/atributo inicial;
   - **Disparo de Interação:** Execução do evento (`click()`, `keydown()`, `dispatch()`);
   - **Estado Posterior:** Assert obrigatório do novo estado modificado e de sua reversibilidade (ex: Dark $\to$ Light $\to$ Dark).
   Qualquer relatório que afirme "PASS" baseado apenas na presença de tags ou IDs é considerado nulo e uma violação de integridade.

---

## Proibições Explícitas

- **PROIBIDO:** Gerar N arquivos com estrutura idêntica e conteúdo rotacionado mecanicamente. Densidade não é comprimento de arquivo — é profundidade de raciocínio por parágrafo.
- **PROIBIDO:** Substituir densidade por volume. 10 arquivos rasos valem menos do que 1 arquivo com raciocínio genuíno. O Agente que gera 144 templates brancos não entregou 144 trabalhos — entregou 0.
- **PROIBIDO:** Usar a conformidade estrutural como prova de pensamento. *"Eu segui o template, logo pensei"* é uma falácia. Template ≠ Pensamento.
- **PROIBIDO:** Campos de resumo executivo onde todos os valores são 99%-100% sem nenhuma tensão, dilema ou incerteza registrada. Resultados perfeitos sem análise de anomalias são sinal de geração automática, não de auditoria real.

---

## Auto-Avaliação Obrigatória (The Density Test)

Antes de commitar qualquer arquivo de dossiê, relatório, checkpoint ou artefato gerado em série, o Agente DEVE responder internamente à seguinte pergunta:

> **"Se eu retirasse o título, o template e a estrutura, o conteúdo restante provaria que um engenheiro sênior pensou sobre um problema real e específico aqui? Ou é apenas preenchimento de formulário que qualquer loop `for` poderia ter gerado?"**

Se a resposta for "preenchimento de formulário" — o artefato DEVE ser reconstruído antes de ser gravado no disco. Gravar primeiro e reconstruir depois é proibido.

---

## Aplicação em Gerações Massivas (N > 10 arquivos em série)

Quando o Agente gera mais de 10 artefatos em sequência (ex: 144 dossiês de meia hora, 72 relatórios horários), o teste de densidade se aplica com vigor redobrado:

- Os primeiros 3 arquivos da série DEVEM ser lidos pelo Agente antes de continuar — eles definem o padrão de densidade real que será mantido.
- Se os 3 primeiros falharem no Density Test, **a série inteira é interrompida e reconstruída**.
- O Agente é proibido de comprometer velocidade de geração às custas de profundidade de conteúdo.
