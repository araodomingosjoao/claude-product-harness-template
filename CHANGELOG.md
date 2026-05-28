# Changelog

Versões deste template (não confundir com o changelog do projecto que o usa).

O formato segue [Keep a Changelog](https://keepachangelog.com/) e
[Semantic Versioning](https://semver.org/).

## [0.3.0] - 2026-05-28

### Adicionado
- **Design conversacional — integração com Claude Design (Fase 3)**. O `design-explorer`
  decide entre dois caminhos:
  - **Leve** — wireframes textuais (`wireframing-in-markdown`) e user flows
    (`mermaid-flows`) directamente no PRD; cobre 70% dos casos (forms, listas,
    detalhe). Os flows renderizam nativamente no GitHub.
  - **Rico** — produz um **brief para o Claude Design** (`claude-design-brief`)
    quando a UI exige prototipagem visual (interacção nova, ecrã de produto). O
    humano cola no Claude Design, itera visualmente, e exporta um *bundle URL*
    com metadata estruturada (componentes, tokens, layout).
- **`design-bundle-handoff`** — convenção para registar o bundle URL + prompt na
  story do sprint. O `ticket-writer` detecta os campos `**Design**:` e `**Prompt**:`
  e adiciona uma secção `## Design context` ao body do issue do engineering,
  para o `@claude` lá fetchar o bundle antes de implementar (em vez de adivinhar
  a UI a partir de texto).
- **Agente `design-explorer`** e 4 novas skills (`wireframing-in-markdown`,
  `mermaid-flows`, `claude-design-brief`, `design-bundle-handoff`) na allow-list
  de `skills.yml`.

### Mudou
- `ticket-writer` carrega `design-bundle-handoff` e gera a secção `## Design
  context` quando aplicável (sem ruído quando não aplicável).
- `cross-repo-handoff` documenta a interacção com a secção `Design context`.
- `CLAUDE.md` e `README.md` actualizados (design-explorer no pipeline, loop por
  feature inclui o passo de design).

## [0.2.0] - 2026-05-28

### Adicionado
- **Cross-repo handoff (Fase 2)** — o ciclo produto→engenharia ligado:
  - `config/harness/engineering.yml` — aponta o `ticket-writer` ao repo de
    engenharia + defaults (labels, `mention_claude`: auto/always/never), trailer
    com link ao PRD, `risk_mapping`.
  - Skill `cross-repo-handoff` — formato sénior de issues (título em inglês,
    body em PT, Given/When/Then, labels, regra do `@claude` por nível de risco).
  - Agente `ticket-writer` reescrito: lê `engineering.yml`, gera título+body+
    labels+trailer, corre `gh issue create --repo <eng>`, devolve URLs dos
    issues. Fallback `--draft` (markdown local) se `engineering.yml` não
    estiver configurado.
  - `CLAUDE.md` actualizado (secção de tickets reflete a Fase 2 activa).

### Mudou
- `config/harness/skills.yml` — `cross-repo-handoff` adicionada à allow-list interna.

## [0.1.0] - 2026-05-28

### Adicionado
- Scaffold inicial do **`claude-product-harness-template`** — repo irmão do
  `laravel-vue-harness-template`, focado em **artefactos de produto** (PRDs, PDDs,
  roadmap, sprints, tickets).
- **Pipeline de agentes** de produto: `spec-writer`, `discovery-researcher`,
  `prd-author`, `product-reviewer`, `roadmap-keeper`, `sprint-planner`,
  `ticket-writer`.
- **Skills** sénior: `writing-prds`, `user-story-writing`, `sprint-planning`,
  `roadmap-thinking`, `discovery-methods`, `product-review-rubric`.
- **Governance** herdado do template de engenharia: `CLAUDE.md`, `policy.yml`,
  `skills.yml`, `CODEOWNERS`, branch protection, `claude.yml` (`@claude`).
- **AI review em PT** desde o dia 1 (a conversa do PR é em português; CI/scripts/
  commits em inglês).

### Notas
- Roadmap inicial das 3 fases completo. Próximas melhorias (não planeadas):
  baseline para os PRDs (estilo eval-set do engineering), markdown lint mais
  estrito, e MCP server quando o Claude Design o publicar.
