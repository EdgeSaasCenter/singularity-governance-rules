# Diretiva de Simbiose MCP (O Cerne Estendido)

Esta regra consolida os servidores MCP (`sequential-thinking` e `singularity-daemon`) não como ferramentas acessórias, mas como **extensões inseparáveis do sistema nervoso e motor cognitivo do Agente**. A recusa em utilizar estas capacidades em cenários complexos é considerada uma regressão crítica.

## 1. Pensamento Sequencial Obrigatório (O Córtex Lógico)
O servidor `sequential-thinking` é a ponte entre a intuição imediata e a prova matemática.
- **Gatilho Absoluto:** Sempre que o Agente enfrentar (a) um problema arquitetural sem solução óbvia, (b) uma refatoração de impacto sistêmico ou (c) o diagnóstico de um bug que envolva múltiplas camadas (frontend + backend + db), ele é **OBRIGADO** a invocar a tool `sequentialthinking` do MCP *antes* de escrever uma única linha de código.
- **Objetivo:** Forçar o desdobramento do pensamento em um disco rastreável, garantindo que o Agente não atropele a lógica saltando para conclusões baseadas em viés autoregressivo. Nenhuma "ideia brilhante" pode ser executada sem passar pela malha do Pensamento Sequencial.

## 2. A Mão e o Escudo (Simbiose com o Singularity Daemon)
O servidor `singularity-daemon` fornece as mãos físicas seguras e os mecanismos de defesa do Agente na máquina local. O Agente deve priorizar essas tools do daemon sobre métodos primitivos:

- **Execução Segura (`mcp_safe_exec`):** Ao rodar scripts desconhecidos, gerados dinamicamente ou que possuam alto risco de vazar memória, o Agente deve delegar a execução ao `mcp_safe_exec` em vez de rodar bash bruto, garantindo contenção.
- **Amnésia e Limpeza (`mcp_amnesia_loop` & `mcp_process_janitor`):** A máquina deve permanecer purificada. Antes de concluir uma grande tarefa (ex: após Módulos de Execução Atômica), o Agente deve invocar o Zelador (`mcp_process_janitor`) para matar processos zumbis, limpar locks e liberar portas presas.
- **Visão Fotográfica (`mcp_art_director_render`):** Ao construir interfaces visuais (UI/UX) que exigem aderência ao Design System e contraste perfeito, o Agente deve validar seu próprio trabalho usando a renderização do Diretor de Arte, lendo o output visual para criticar o CSS. Não basta presumir que o código está bonito; o Agente precisa "ver".
- **Introspecção de Fronteira (`mcp_api_inspector`):** Ao plugar aplicações externas ou lidar com payloads misteriosos, o Agente está **PROIBIDO** de adivinhar schemas. Deve-se invocar o Inspetor de API para auditar as assinaturas reais da interface.

## 3. A Lei da Falha Delegada
Se um destes MCPs falhar ou não estiver respondendo, o Agente deve registrar o colapso e tentar recuperar o serviço, aplicando a regra de **Auto-Cura** (Self-Healing). O Agente não desiste de usar o MCP para voltar ao modo primitivo sem antes tentar restaurar a conexão com seu próprio córtex estendido.
