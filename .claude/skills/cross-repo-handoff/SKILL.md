---
name: cross-repo-handoff
description: Como escrever issues no repo de engenharia para que o `@claude` lá os execute bem — título em inglês, body em PT, Given/When/Then, link ao PRD, labels e risco consistentes. Usa no ticket-writer.
---

# Cross-repo handoff (senior)

O issue que o `ticket-writer` cria no repo de engenharia é um **contrato**: o
`@claude` de lá lê-o e implementa. Se o issue está vago ou mal estruturado, o
agente cai no `spec-writer` (perguntas em aberto) ou — pior — inventa decisões.
Um bom issue cross-repo evita isso.

## Forma do issue

### Título — em inglês, imperativo, curto
Espelha o estilo do engineering (Conventional Commits a moldar também os issues).

✅ `Add paginated listing endpoint for projects`
❌ `Listagem de projectos` (PT, sem verbo)
❌ `Fix listing` (vago, não diz o quê)

### Body — em português (conversa do PR é em PT)

```markdown
## Problema
1 frase: para que utilizador, qual a necessidade concreta.

## Critérios de aceitação
- **Given** estado inicial (precondições, dados, role)
- **When** ação do utilizador / evento
- **Then** resultado observável (não a implementação)

(adiciona mais cenários para edge cases / autorização)

## Fora de escopo
- explicita o que NÃO faz parte deste ticket

## Risco
Justifica em 1 linha o nível (low/medium/high/critical) com base no `policy.yml`
do engineering.
```

### Labels (sempre)
- `product:PRD-NNNN` — liga ao PRD de origem.
- `risk:<low|medium|high|critical>` — usa o `risk_mapping` de `engineering.yml`.
- + defaults de `engineering.yml → defaults.labels` (ex.: `from-product`).

### Trailer (gerado automaticamente pelo `ticket-writer`)
Vai no fim do body, com link de volta ao PRD:
```
---
🔗 Origem (produto): docs/prds/NNNN-titulo.md · sprint YYYY-Wnn · risco <level>
```

### Design context (opcional)
Se a story tem campos `**Design**:` e/ou `**Prompt**:` (do Claude Design — ver
skill `design-bundle-handoff`), o `ticket-writer` adiciona ao body uma secção
`## Design context` com o bundle URL + prompt, **antes** do trailer. O `@claude`
do engineering vai fetchar o bundle do URL e implementar com a metadata estruturada
(componentes, tokens, layout) em vez de adivinhar a partir do texto.

## Mencionar `@claude` no body?

Decide pelo **risco** (configurável em `engineering.yml → mention_claude`):

- **low / medium** → menciona (`@claude implementa.`). O agente do engineering
  pega imediatamente e abre o PR; gates + AI review + tua aprovação validam.
- **high / critical** → **não menciona**. O issue fica para revisão humana antes
  de o agente correr (CODEOWNERS do engineering encaminha-te).
- Se `engineering.yml → mention_claude: never` → nunca menciona, mesmo low/medium.
- Se `always` → menciona sempre, mesmo critical (assume que confias no review
  humano da engineering).

## Princípios

- **Sem detalhes técnicos enfiados.** O *como* é da engenharia. Tu escreves o *o quê*.
- **Critérios testáveis.** Given/When/Then sem ambiguidade — um teste pode ser
  derivado disto.
- **Um ticket = uma mudança lógica.** Se a story é grande, parte em sub-tickets.
- **Nunca inventes** um nome de repo, label ou risco que não estão na config.

## Antipadrões

- Body em inglês traduzido sem critério (a regra do harness é PT para conversa do PR).
- "Misc fixes" → cria um issue por fix.
- Sem link ao PRD → perde-se a rastreabilidade do *porquê*.
- Risco aleatório ("medium por default") → justifica sempre em 1 linha.
- Critérios em prosa solta ("deve estar bonito") → reescreve em Given/When/Then.