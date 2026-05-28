---
name: wireframing-in-markdown
description: Padrões sénior para wireframes textuais em Markdown — cobrir os 4 estados (loading/empty/error/success), usar componentes nomeados, anotar a11y. Usa dentro do PRD para UI simples (forms, listas, detalhe).
---

# Wireframing in Markdown (senior)

Um wireframe em texto é a forma mais barata de discutir UI — versionável, revisível
num PR, sem nada para instalar. Cobre 70% dos ecrãs (forms, listas, detalhe). Para
UI rica/novel, usa a skill `claude-design-brief`.

## Princípios

- **Os 4 estados de TODA a vista** — loading, empty, error, success. Quem só desenha
  o happy path entrega features que partem no canto.
- **Componentes nomeados** — usa nomes que correspondem aos componentes reais do
  repo de engenharia (`<Button variant="primary">`, `<EmptyState>`). Não inventes
  componentes que não existem.
- **A11y mínima** — anota labels, semantic HTML, focus visível, contraste onde for
  relevante.
- **Mobile-first** — descreve em ecrã pequeno primeiro; desktop como expansão.

## Forma do wireframe (dentro do PRD)

````markdown
## Wireframes — <nome do ecrã>

### Estado: Success (caso normal)
```
┌────────────────────────────────────────────┐
│ Header: "Projectos arquivados"             │
│ <SearchInput placeholder="Procurar...">    │
│ <Filter label="Data" options=[...]>        │
├────────────────────────────────────────────┤
│ <ProjectRow>                               │
│   Title · Arquivado 12 Mai · [Desarquivar]│
│ <ProjectRow>                               │
│   ...                                      │
├────────────────────────────────────────────┤
│ <Pagination total=42 page=1>               │
└────────────────────────────────────────────┘
```
Notas:
- `<Button variant="ghost">` no Desarquivar (acção secundária).
- Foco visível no `<SearchInput>` ao montar.

### Estado: Loading
- `<Skeleton rows={3} />` mantém a estrutura — evita layout shift.

### Estado: Empty
- "Ainda não arquivaste projectos." + `<Button>` "Voltar aos activos".

### Estado: Error
- "Não foi possível carregar. <Button>Tentar de novo</Button>" — header fica.
````

## Antipadrões

- **Só o happy path** → bug garantido no canto.
- **Componentes inventados** (`<SuperCard>`) → engineering ignora-te ou duplica.
- **ASCII-art elaborada** que ninguém consegue editar — *keep it dumb*.
- **Wireframe gigante** para ecrã simples — texto + lista de estados chega.
