# {{PROJECT_NAME}} — Convenções do projecto (produto)

> **Nota para o developer**: Este ficheiro foi gerado a partir do template
> `claude-product-harness-template`. É o irmão de produto do
> `laravel-vue-harness-template`: aqui o "código" são **artefactos de produto**
> (PRDs, decisões, sprints, tickets) — não app.

{{PROJECT_DESCRIPTION}}

Este ficheiro é o contexto principal para qualquer agente de IA que trabalhe neste
repositório. Lê-o antes de qualquer task. Se uma instrução aqui conflituar com o
prompt do utilizador, pergunta.

## Ordem de leitura obrigatória no início de cada sessão

1. **Este ficheiro (CLAUDE.md)** — convenções estáveis
2. **`docs/roadmap.md`** — onde estamos agora
3. **`docs/scope.md`** — a visão de fundo (estável)
4. **`docs/pdds/`** — decisões de produto registadas
5. **`config/harness/policy.yml`** — limites e restrições do harness

## O que vive aqui (artefactos)

| Artefacto | Onde | Pensa nisto como |
|---|---|---|
| **PRD** (Product Requirements Doc) | `docs/prds/NNNN-titulo.md` | "ADR para uma feature" |
| **PDD** (Product Decision Document) | `docs/pdds/NNNN-titulo.md` | ADR de produto (trade-off registado) |
| **Discovery** (notas, entrevistas) | `docs/discovery/` | matéria-prima para os PRDs |
| **Roadmap** | `docs/roadmap.md` | `now / next / later` |
| **Sprint** | `sprints/YYYY-Wnn.md` | objetivo + plano + estado |
| **Scope** (visão estável) | `docs/scope.md` | a north star |

## Estrutura do repo

```
docs/
  scope.md                  # visão estável (a north star)
  roadmap.md                # now / next / later
  prds/NNNN-titulo.md       # PRDs
  pdds/NNNN-titulo.md       # decisões de produto
  discovery/                # notas, entrevistas, hipóteses
sprints/YYYY-Wnn.md         # planos de sprint
.claude/agents/             # pipeline de agentes
.claude/skills/             # conhecimento sénior reutilizável
config/harness/
  policy.yml                # budgets, kill switch, risco
  skills.yml                # allow-list de skills
  engineering.yml           # repo de engenharia (cross-repo, Fase 2)
```

## Regras de ouro

1. **Um artefacto = um PR.** Não juntes um PRD novo com mudanças no roadmap e
   tickets no mesmo PR; cada mudança lógica tem o seu.
2. **Não inventes decisões.** Pedido vago/grande → o agente usa o `spec-writer`
   primeiro; se ficarem perguntas em aberto, **pára e pergunta**.
3. **O PRD precede os tickets.** Não escrevas tickets para uma feature sem PRD
   aprovado (ou nota explícita "spike sem PRD"). Os tickets ligam ao PRD.
4. **Roadmap é vivo, não autoritário.** O roadmap é uma vista do estado, não um
   contrato. Mudá-lo é normal — mas com PDD se a mudança for grande.
5. **Sprints com objetivo, não com lista.** Cada sprint tem **um objetivo** que
   se prova sim/não no fim; o plano é como lá chegar, não substitui o objetivo.

## Pipeline de agentes (idea → ticket)

Tasks de produto passam por uma cadeia de sub-agentes especializados, orquestrada
pelo agente principal (ou pela action `@claude`). **Sub-agentes não invocam outros
sub-agentes** — encadeia-os a partir do topo, em sequência:

```
spec-writer → discovery-researcher → prd-author → product-reviewer → roadmap-keeper
                                                       │
                                                       ▼
                              sprint-planner → ticket-writer (Fase 2: gh issue → engineering)
                                                       │
                            design-explorer (paralelo, Fase 3, quando há UI)
```

- **`spec-writer`** — pedido vago? Clarifica primeiro. Não inventes.
- **`discovery-researcher`** — sintetiza notas/entrevistas em hipóteses + perguntas em aberto.
- **`prd-author`** — escreve o PRD a partir do `scope.md` + descoberta.
- **`product-reviewer`** — revê PRD/sprint vs roadmap, princípios, coerência (read-only).
- **`roadmap-keeper`** — mantém o `docs/roadmap.md`.
- **`sprint-planner`** — parte itens do roadmap em sprints com objetivo + capacidade.
- **`ticket-writer`** — converte stories em **issues no repo de engenharia** (Fase 2).

Tasks pequenas saltam fases (ex.: nota de descoberta direta, sem PRD).

## Convenções de PRD

- **Ficheiro**: `docs/prds/NNNN-titulo-curto.md` (NNNN sequencial, sem reuso/salto).
- **Status** no frontmatter: `proposed → accepted → shipped | superseded by PRD-XXXX`.
- **Formato**: problema / audiência / sucesso (métricas) / escopo / fora-de-escopo /
  flows / decisões abertas → ver a skill `writing-prds`.
- **Linkagem**: o ticket no repo de engenharia inclui o link a este PRD; o PRD
  acolhe um índice de tickets que o concretizam.

## Convenções de sprints

- **Ficheiro**: `sprints/YYYY-Wnn.md` (ano-semana ISO). Um por sprint.
- Cada sprint tem **um objetivo** mensurável e uma lista realista de stories
  (capacidade declarada). Ao fim, fechas com `## Retro` curta.

## Convenções de tickets — handoff cross-repo (Fase 2)

O `ticket-writer` cria issues no repo de engenharia via `gh issue create --repo`,
configurado em `config/harness/engineering.yml`. Sem essa config preenchida, cai
em modo **draft** (gera markdown local em vez de criar issues — útil offline ou
antes de o repo de engenharia existir).

A skill `cross-repo-handoff` tem o formato completo. Em resumo:

- **Título**: em **inglês**, imperativo, curto — `Add paginated listing endpoint for projects`.
- **Body**: em **português** (a conversa do PR é em PT) — Problema (1 frase) →
  Critérios de aceitação (Given/When/Then) → Fora de escopo → Risco (com justificação).
- **Labels** (sempre): `product:PRD-NNNN`, `risk:<level>` (via `risk_mapping`), +
  defaults de `engineering.yml`.
- **Trailer** (automático): link de volta ao PRD + sprint + risco.
- **Mencionar @claude no body?** Pelo risco (configurável em
  `engineering.yml → mention_claude`): `low/medium` → menciona (implementa já);
  `high/critical` → não menciona (espera revisão humana).

## Convenções de commits

Seguimos [Conventional Commits](https://www.conventionalcommits.org/). Em **inglês**
(mensagem + corpo + rodapé), no imperativo, ≤ 72 chars no assunto, sem ponto final.
Tipos: `feat`, `fix`, `docs`, `refactor`, `chore`, `ci`, etc. Para este repo de
produto os mais frequentes são `docs`, `chore`, `ci`.

**Não adicionar rodapés de co-autoria** (ex.: `Co-Authored-By`).

## Convenções de comentários

Comentários (no Markdown ou HTML embebido) explicam o **porquê**, não o quê. Se
adicionar contexto que o texto não capta, vale; senão, dispensa-se. Iguala a
densidade do ficheiro à volta.

## Idioma do feedback

- **Em português** — a conversa do PR que um humano lê: comentários do **AI review**,
  veredicto do `product-reviewer`, e tudo o que o `@claude` publica (descrição
  do PR, drafts de PRD, perguntas em aberto).
- **Em inglês** — o que é mecânico: mensagens de CI (`::notice::`/`::error::`),
  output de scripts, e mensagens de commit. Mantém sempre nomes de ficheiros,
  paths e comandos como estão.

## Workflow obrigatório para cada task de produto

1. **Lê o contexto** — `roadmap.md`, `scope.md`, PRDs/PDDs relacionados.
2. **Spec-first se vago** — invoca o `spec-writer`. Em modo assíncrono, publica
   spec com `## Perguntas em aberto` e **pára** se houver decisões a tomar.
3. **PRD antes de ticket** — não saltes para tickets sem PRD aprovado.
4. **Sprint com objetivo** — não enches um sprint sem objetivo claro.
5. **Tickets de qualidade** — Given/When/Then nos critérios, link ao PRD, risco.
6. **PR + review humana** — branch protection exige review de quem está no
   `CODEOWNERS`. Mensagens de commit em inglês.

## O que NÃO fazer

- Não fazer merge directo a `main` (branch protection bloqueia o agente).
- Não escrever tickets sem PRD ou sem objetivo claro.
- Não inventar decisões de produto sem o developer — usa o `spec-writer`.
- Não duplicar conteúdo entre PRDs e roadmap; o roadmap é uma vista, o PRD a fonte.

---

## Domínio: vocabulário do projecto

> **Preencher** com termos específicos do produto que o agente deve conhecer.

- **{{TERM}}**: definição
- ...

## Visão estável (resumo)

> **Preencher** com 3-5 linhas de visão (a partir do `docs/scope.md`). Mantém aqui
> apenas o que NÃO muda; detalhes evolutivos ficam no scope.md.