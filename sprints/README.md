# Sprints

Um ficheiro por sprint: `YYYY-Wnn.md` (semana ISO).

## Formato

Cabeçalho YAML + objetivo + stories + capacidade + retro. Ver a skill
`.claude/skills/sprint-planning/SKILL.md` para o detalhe; em curto:

```yaml
---
sprint: YYYY-Wnn
start: YYYY-MM-DD
end: YYYY-MM-DD
status: planning | active | closed
---
```

```
## Objetivo
Uma frase mensurável: "No fim do sprint, X consegue Y."

## Stories
- [ ] **PRD-NNNN / S1** — <título> — Given/When/Then resumido
- ...

## Fora deste sprint (explícito)

## Capacidade
Pessoa A: N dias úteis; Pessoa B: N dias úteis. Total ≈ N stories.

## Riscos

## Retro (preencher no fim)
- O objetivo provou-se? sim/não, como sabemos.
- O que correr bem / o que mudar.
- 1-2 acções para o próximo sprint.
```

## Princípios

- **Um objetivo, não cinco.** Sem objetivo, não há sprint — há fila.
- **Capacidade declarada, não otimismo.** Cortar é normal.
- **Stories ligam a PRDs.** Excepções (chore, fix trivial) são explícitas.