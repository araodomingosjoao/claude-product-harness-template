---
name: sprint-planning
description: Padrões sénior para planear um sprint — UM objetivo mensurável, capacidade honesta, definition of done, antipadrões. Usa no kickoff e na retro.
---

# Sprint planning (senior)

## Princípio nº1: UM objetivo, não cinco

Cada sprint tem **um objetivo** que se prova sim/não no fim. O plano de stories
é como lá chegar — não substitui o objetivo. Se não consegues escrever **uma**
frase de objetivo, não estás pronto para planear.

Bom: *"No fim do sprint, owners de projecto conseguem arquivar e desarquivar
projectos sem perder histórico."*

Mau: *"Várias melhorias na gestão de projecto."*

## Capacidade honesta

- Conta dias **úteis reais** por pessoa (férias, on-call, reuniões — desconta).
- Usa a velocidade do sprint anterior como base, não o desejo.
- Se as stories priorizadas não cabem, **corta** — não comprimas.

## Definition of Done (DoD)
Antes de fechar uma story:
- Critérios de aceitação cumpridos (todos os Given/When/Then verdes).
- Testes pass; gates do repo de engenharia ok; review humana feita.
- Documentação minimal actualizada (PRD reflete o entregue; roadmap actualizado).

## Antipadrões a evitar
- **Enchimento**: "sobra capacidade, enfia mais 3 stories" → não. Capacidade que
  sobra é margem para o objetivo.
- **Sem objetivo, só lista**: vira gestão de fila, perde-se o porquê.
- **Carry-over silencioso**: o que não fechou no sprint anterior precisa de
  explicação na retro, não passa só para o próximo.
- **Estimação por desejo**: usa velocidade observada, não otimismo.
- **Stories técnicas dominantes**: se o sprint só tem "refactor X", o objetivo de
  produto desapareceu.

## Retro (curta, no fim)
- O objetivo provou-se sim ou não? Como sabemos?
- O que correu bem (mantém).
- O que correu mal ou foi por instinto (muda).
- 1-2 acções concretas para o próximo sprint.
