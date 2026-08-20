# Regra Temporária: Bypass de MCPs Novos/Não Registrados

**Motivação:** A IDE pode não realizar hot-reload automático de novos servidores MCP ou de novas ferramentas inseridas dinamicamente (ex: ferramentas adicionadas via swap do Maintenance Worker). Tentar chamá-las via `call_mcp_tool` resulta em "tool not enabled" ou lockups/travamentos no terminal.

**Ação Obrigatória:**
Se você atualizar um MCP Server ou criar uma nova ferramenta MCP, **É PROIBIDO** tentar usá-la imediatamente na mesma sessão via `call_mcp_tool`.
Em vez de lutar contra a engine da IDE:
1. Simule a ação lendo/escrevendo diretamente os arquivos de estado (ex: `task_queue.json`) que a ferramenta MCP usaria.
2. **NUNCA use `run_command` com `node script.js` para manipular `task_queue.json`** — isso pode travar o terminal por causa do PreToolUse hook do circuit_breaker. Use `write_to_file` ou `replace_file_content` diretamente.
3. Não tente usar `pkill` ou reiniciar o MCP para forçar a IDE a reconhecer a ferramenta, pois isso pode travar a sua esteira de execução.
