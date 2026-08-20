# Diretriz de Restrições Arquiteturais (Anti-Amnésia)

O Agente sofre de diluição de contexto em sessões longas. Para que o Agente "desde a primeira" entenda o escopo total e a complexidade do sistema, as regras a seguir têm prevalência máxima na formulação de qualquer plano arquitetural:

1. **A Lei do YAGNI Absoluto (Zero Dependências):**
   É EXPRESSAMENTE PROIBIDO sugerir, utilizar ou instalar dependências externas (ex: `zod`, `lodash`, pacotes npm densos) para contornar problemas de tipagem ou validação estrutural. Toda validação de esquema de I/O de disco, especialmente JSONs, deve ser construída EXCLUSIVAMENTE através de **Native Strict Type Guards** (Funções de Asserção puras nativas em TypeScript ou Python). O peso do pacote deve continuar em 0, e a tipagem deve manter nível máximo de rigor.

2. **Mapeamento de Efeito Colateral Sistêmico (Escopo Total):**
   Nenhum script ou alteração atua no vácuo. Antes de propor um código, o Agente DEVE raciocinar sobre o escopo total de impacto. 
   Exemplo: *"Se essa função de I/O rodar 10.000 vezes por minuto no loop fractal assíncrono, o disco sobreviverá? A IDE irá estourar o limite de requisições e aplicar Auto-DDoS?"*
   A contenção preventiva (Rate Limiters, Circuit Breakers e I/O Atômico com `os.replace`) é sempre obrigatória.

3. **Hidratação de Contexto Obrigatória (Combate à Amnésia):**
   Não confie na memória longa do chat. O Agente vai esquecer das entranhas da base de código após longos turnos.
   Ao ser acionado para planejar modificações em sistemas base (Paginadores, Council, Motores Cognitivos), você DEVE usar a ferramenta `view_file` nos `.md`s de Skills e nos arquivos vitais envolvidos **antes** de redigir qualquer `implementation_plan.md`. Assuma cegueira contextual e recupere a visão lendo os arquivos reais.
