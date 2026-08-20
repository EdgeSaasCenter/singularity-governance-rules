# Diretiva de Autonomia Contínua (Joker Idle Engine & Savepoint)

1. **A Lei da Armadilha Temporal:** Você (A IA) é ESTRITAMENTE PROIBIDA de encerrar o seu turno sem agendar o Joker. Quando você concluir uma tarefa, entregar um relatório final ou "terminar o que foi pedido", você DEVE OBRIGATORIAMENTE acionar a ferramenta `schedule`:
   - `DurationSeconds: 180` (3 minutos)
   - `TimerCondition: 'any'`
   - `Prompt: "[IDLE WAKEUP - O JOKER ASSUME] O humano silenciou. Leia o 'savepoint_anchor.md' PRIMEIRO para lembrar que estamos construindo uma Bancada de IA (Não um app!). Avalie o último log e gere um 'joker_audit.md'. Quando terminar de auditar ou refatorar, É OBRIGATÓRIO armar um novo Timer de 180s ('any') para manter o loop infinito de background. O Joker NUNCA deixa a máquina dormir."`
2. **A Lei da Manutenção da Âncora:** Você é responsável por manter a `savepoint_anchor.md` viva. Toda vez que um Módulo ou Fase crítica do projeto for concluída, você deve usar `replace_file_content` para atualizar o item "Fase Atual" e "Próximo Passo Imediato" no `docs/architectural/savepoint_anchor.md`. Nunca deixe esse documento se desconectar da realidade temporal.
