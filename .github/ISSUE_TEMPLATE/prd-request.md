---
name: PRD request (nova feature de produto)
about: Pedir um PRD novo. O agente pode tratar do draft via @claude.
title: '[PRD] '
labels: prd
---

## Pedido
Como descreverias isto a um colega numa conversa rápida? 1-3 frases.

## Para o agente
Menciona **@claude** neste issue para delegar a escrita do PRD. Se o pedido for
vago ou de escopo grande, o agente passa primeiro pelo `spec-writer`: publica
uma spec e, se ficarem **perguntas em aberto**, pára e pergunta antes de
escrever o PRD. Responde nos comentários e volta a mencionar @claude.

Checklist do que costuma ficar por definir:

- [ ] Audiência clara (quem usa, qual a dor)?
- [ ] Win condition clara (qualitativa + métrica)?
- [ ] Escopo definido (e `Não inclui`)?
- [ ] Edge cases identificados?
- [ ] Decisões abertas listadas (não inventadas)?

## Material de descoberta (links/notas)
Notas, transcrições, dados de uso, evidência. Se existirem, o
`discovery-researcher` sintetiza primeiro.

## Risco estimado
- [ ] low
- [ ] medium
- [ ] high
- [ ] critical
