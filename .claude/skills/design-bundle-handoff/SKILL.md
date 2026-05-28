---
name: design-bundle-handoff
description: Convenção para o bundle URL do Claude Design — onde se regista na story do sprint, como o ticket-writer o transporta para o issue do engineering, o que o @claude de lá faz com ele.
---

# Design bundle handoff (senior)

Depois de iterar no Claude Design, o humano clica **"Export → Hand off to Claude
Code"** e recebe dois artefactos:

- **Bundle URL** — endpoint servido pela Anthropic com a receita estruturada:
  componentes, tokens, layout, referências a assets. **Não é um screenshot** — é
  metadata machine-readable que o Claude Code consegue ler.
- **Prompt** — uma linha que o Claude Code deve seguir, com referência ao bundle URL.

## Onde se regista na story do sprint

Na story que vai gerar o ticket, adiciona duas linhas entre o título e os critérios
Given/When/Then:

```markdown
**Design**: <bundle URL>
**Prompt**: <prompt dado pelo Claude Design>
```

## O que o `ticket-writer` faz com isto

Detecta os campos **`Design`** e **`Prompt`** na story e, ao criar o issue no
engineering, adiciona uma secção:

```markdown
## Design context

🎨 Esta story tem um bundle do Claude Design.

- **Bundle**: <URL>
- **Prompt sugerido**: <prompt>

Recomendação ao agente do engineering: **vai buscar o bundle a este URL** antes
de implementar — tem os componentes, tokens e layout estruturados que foram
aprovados visualmente. Não partes de uma descrição em texto; partes de uma receita.
```

## O que o `@claude` do engineering deve fazer

1. Lê o issue completo (problema + Given/When/Then + Design context).
2. **Vai buscar o bundle** ao URL (HTTP GET — não precisa de auth; é servido pela
   Anthropic).
3. Implementa com os componentes/tokens reais que o bundle especifica.
4. Se o bundle conflituar com algo no código existente, **pára e pergunta** (via
   spec-writer) em vez de inventar.

## Princípios

- **Bundle URL é um bónus de fidelidade, não uma dependência crítica.** Se o Claude
  Design estiver fora do ar, o agente do engineering implementa a partir dos
  critérios Given/When/Then + wireframe textual (se existir). O issue não fica
  bloqueado.
- **Não copies o conteúdo do bundle para o issue.** Tem assets, é grande — fica no URL.
- **Pensa antes de publicar bundle URLs em issues públicos.** Se o produto tem
  dados sensíveis, considera revogar/regenerar o bundle no fim do ciclo.