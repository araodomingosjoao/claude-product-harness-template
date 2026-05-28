---
name: user-story-writing
description: Padrões sénior para escrever user stories testáveis — formato As/I want/So that + critérios de aceitação Given/When/Then. Usa ao escrever stories em PRDs ou tickets.
---

# User story writing (senior)

Uma story é uma promessa de conversa; os **critérios de aceitação** transformam-na
em algo testável. Sem eles, é só um desejo.

## Formato

```
Como <utilizador / role>,
quero <ação concreta>,
para <benefício / razão>.
```

Exemplo: *"Como dono de projecto, quero arquivar um projecto, para limpar a minha
lista sem perder o histórico."*

## Critérios de aceitação (Given/When/Then)

Para cada story, **pelo menos 1 cenário Given/When/Then** — mais se houver edge
cases relevantes.

```
**Given** estado inicial (precondições, dados, role)
**When** ação do utilizador / evento
**Then** resultado observável (não a implementação)
```

Exemplo:
```
Given um projecto activo de que sou owner,
When clico em "Arquivar" e confirmo,
Then o projecto deixa de aparecer na minha lista
And é mostrado em "Arquivados" com a data
And as tarefas continuam acessíveis (read-only).
```

## Princípios

- **Comportamento observável**, não implementação. "É guardado na DB" é mau Then —
  "aparece na lista de arquivados" é bom.
- **Um cenário por situação** — happy + um edge case crítico + autorização.
- **Independente**, **negociável**, **valuable**, **estimable**, **small**, **testable** (INVEST).
- **Pequena.** Se a story precisa de >3 dias, parte-a.
- **Não escondas decisões de produto nos critérios.** Se a story exige uma decisão
  ainda não tomada, marca-a como "decisão aberta" no PRD, não a sugiras à força.

## Cheiros a evitar
- "Como user, quero a app rápida" → não é story; é princípio.
- "Como dev, quero refactor X" → tarefa técnica, não story.
- Critérios em prosa solta ("deve estar bonito") → reescreve em Given/When/Then.
- Stories enormes que misturam 5 cenários → parte.
