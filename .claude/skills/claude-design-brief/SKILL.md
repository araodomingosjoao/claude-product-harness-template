---
name: claude-design-brief
description: Formato sénior do brief para colar no Claude Design (Anthropic Labs) quando a UI exige prototipagem rica — intent, componentes referenciados aos do engineering, tokens nomeados, estados, restrições, link ao PRD.
---

# Claude Design brief (senior)

Quando a UI merece prototipagem visual (interacção nova, ecrã de produto, fluxo
multi-step), o `design-explorer` escreve este **brief** dentro do PRD. O humano
cola-o no Claude Design para arrancar a iteração visual.

> O Claude Design lê o teu repo de engenharia sozinho para extrair o design system
> (componentes, tokens, naming). Não redescrevas os tokens — referencia-os pelo nome.

## Forma do brief (secção `## Brief para Claude Design` no PRD)

```markdown
### Intent
1-2 frases: que utilizador, que objectivo. Ex.: "Owner consegue ver projectos
arquivados, filtrar por data, e desarquivar com uma confirmação."

### Ecrãs/Frames pretendidos
- Lista de arquivados (com filtros)
- Modal de confirmação de desarquivar

### Componentes — usa os que já existem
- `<DataTable>` para a lista (já existe em `resources/js/components/`)
- `<Button variant="ghost">` para acções secundárias
- `<Modal>` para a confirmação
- `<EmptyState>` para "ainda nada arquivado"

### Tokens — sem inventar
- Cor: tokens do projecto (`color.primary`, `color.muted`); NUNCA hex inventado.
- Tipografia: a fonte do projecto; sem mudar tamanhos arbitrários.
- Espaçamento: a escala do projecto (4/8/16/24…).

### Estados a desenhar
- Success, loading (skeleton), empty, error.

### Comportamento
- Desarquivar pede confirmação (não destrutivo mas reversível com fricção).
- Filtro por data persiste na URL.

### Restrições (não-negociáveis)
- Mobile-first; em ecrã pequeno o filtro colapsa num botão.
- WCAG AA; touch target ≥ 44px.

### Referências
- PRD: docs/prds/NNNN-archive-projects.md
- Componentes do engineering: link directo ao diretório `resources/js/components/`
```

## Princípios

- **Componentes pelo nome.** Não inventes (`<SuperCard>`). O Claude Design espelha
  o design system real do repo.
- **Tokens pelo nome.** Sem hex (`#3b82f6`). O Claude Design vai pegar nos tokens.
- **4 estados explícitos.** Sem pedir, Claude Design entrega só o happy path.
- **Restrições > especificações.** Define o que é não-negociável (a11y, mobile-first);
  deixa o Claude Design escolher o resto.

## Quando NÃO precisas deste brief

- UI simples (form, lista, detalhe sem novidade) → usa `wireframing-in-markdown`.
- Bug fix visual pequeno → não há nada a prototipar.
- Mudar um botão de cor → não, mesmo.
