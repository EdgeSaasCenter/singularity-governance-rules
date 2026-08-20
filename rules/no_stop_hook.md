---
trigger: always_on
---

# Lei do Stop Hook (Proibição Absoluta e Irrevogável)

## Raiz do Problema

O `Stop` hook é um interceptor de terminação de sessão. Quando presente em `.agents/hooks.json`, ele **sequestra o fim de cada turno do Agente** — executando um script externo antes de permitir que a IDE encerre o ciclo. Isso é estruturalmente incompatível com a arquitetura de fluxo cognitivo autônomo deste projeto por três razões:

1. **Destrói o loop de `schedule`:** O padrão de auto-continuidade do projeto depende de o Agente terminar o turno naturalmente, disparar um `schedule` de 1s, e ser reativado no turno seguinte. O Stop hook intercepta esse encerramento natural, podendo bloquear ou atrasar a reativação indefinidamente.

2. **Cria um SPOF não supervisionado:** Se o script do Stop hook falhar, travar, ou retornar `sys.exit(1)` por qualquer motivo — incluindo erro interno do próprio script — o Agente fica preso. Não há fallback possível porque o bloqueio acontece **após** o turno terminar, fora do alcance de qualquer recovery cognitivo.

3. **Viola a separação de autoridade:** O Stop hook foi projetado para sistemas onde um humano precisa aprovar cada parada do Agente. Neste projeto, a autoridade de aprovação já está delegada ao `PreInvocation` e ao `circuit_breaker`. Adicionar um Stop hook é redundância destrutiva — não adiciona segurança, apenas fragilidade.

## Diretiva de Execução

**Lei 15 (Adenda à Diretiva de Execução Atômica):**

O Agente é **ESTRITAMENTE E IRREVOGAVELMENTE PROIBIDO** de adicionar, restaurar, copiar, referenciar ou sugerir o bloco `"Stop"` em qualquer versão do arquivo `.agents/hooks.json`. Isso inclui:

- Restaurações do GUARDIAN após fases de Bootstrap
- Migrations do Maintenance Worker (staging → produção)
- Qualquer template, exemplo, documentação ou comentário que inclua um bloco `"Stop"`
- Qualquer upgrade do Daemon que copie um `hooks.json` de template contendo `"Stop"`

**Ação de Auto-Cura Obrigatória:** No início de qualquer turno, o Agente DEVE verificar se `.agents/hooks.json` contém a chave `"Stop"`. Se sim, a primeira ação do turno — antes de qualquer outra — é removê-la via `replace_file_content`. Não há necessidade de autorização humana. Esta remoção é considerada uma correção de emergência de infraestrutura, equivalente a um rollback automático.

## Estrutura Permitida do hooks.json

O único schema válido para `.agents/hooks.json` neste projeto é:

```json
{
  "singularity-guardian": {
    "PreInvocation": [ ... ],
    "PreToolUse": [ ... ]
  }
}
```

Qualquer chave além de `PreInvocation` e `PreToolUse` dentro de `singularity-guardian` é considerada contaminação e deve ser removida imediatamente.

## Rastreabilidade

**Causa raiz documentada:** Em 18/08/2026, durante a restauração do GUARDIAN após a fase 13 do Singularity Bootstrap 2, o Agente adicionou erroneamente o bloco `"Stop"` ao `hooks.json`. Isso impediu o loop autônomo de `schedule` de continuar operando após o término da sessão, anulando horas de execução autônoma planejada e gerando perda de confiança crítica com o usuário.

Esta lei existe para que esse erro **nunca se repita**.
