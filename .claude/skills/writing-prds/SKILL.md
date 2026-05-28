---
name: writing-prds
description: Padrões sénior para escrever PRDs (Product Requirements Documents) em docs/prds/ — formato, win condition, escopo honesto, decisões abertas. Usa ao escrever ou rever um PRD.
---

# Writing PRDs (senior)

Um PRD bom é **curto, honesto e accionável**. Não é um spec técnico, nem um pitch
de marketing. É a fonte de verdade para "o que vamos fazer e porquê".

## Formato (`docs/prds/NNNN-titulo-curto.md`)

```markdown
---
prd: NNNN
status: proposed | accepted | shipped | superseded by PRD-XXXX
date: YYYY-MM-DD
owner: @utilizador
---

# PRD-NNNN: <título>

## Problema
1-3 frases. Para quem é? Qual é a dor? Como sabemos?

## Win condition
**Qualitativa**: como ficará a vida do user depois disto?
**Quantitativa**: que métrica esperamos mexer? Para quanto? Em que prazo?

## Escopo
**Inclui**: bullets curtos do que esta versão entrega.
**Não inclui**: bullets curtos do que **NÃO** vai entregar (importante).

## User stories
- **S1** — Como <user>, quero <X>, para <Y>.
  - **Given/When/Then** (critérios de aceitação).
- **S2** — ...

## Fluxos (opcional, se a UI for não-óbvia)
Fluxo principal em texto, ou ASCII/Mermaid se ajudar.

## Decisões já tomadas
- Decidimos X em vez de Y porque Z (link a PDD se aplicável).

## Decisões em aberto
- ... (bloqueia ship? ou pode resolver-se em flight?)

## Riscos
- Risco → mitigação.

## Links
- Roadmap: ...
- Descoberta: ...
- PDDs relacionados: ...
```

## Princípios

- **Tem win condition mensurável.** "Os utilizadores ficam mais felizes" não é uma
  win condition. "Adesão à feature ≥ 30% em 30 dias" é.
- **Escopo honesto.** O `**Não inclui**` é tão importante quanto o `**Inclui**` —
  evita scope-creep silencioso.
- **User stories com Given/When/Then.** Sem isso, são desejos, não requisitos.
- **Decisões abertas explícitas.** Não as escondas debaixo do tapete — listadas
  são geríveis; ignoradas, voltam como bugs.
- **Sem detalhes técnicos.** O "como" é da engenharia. Se entras em "vamos usar
  WebSockets", para — isso é spec técnica, vai para o repo de engenharia.

## Cheiros a evitar
- PRD de 5 páginas que ninguém lê → corta. Se não cabe numa página, parte em PRDs menores.
- Win condition vaga ("melhorar UX") → exige uma frase concreta.
- "Stories" que são tarefas técnicas → não são stories.
- Decisões inventadas para parecer completo → marca como aberta.