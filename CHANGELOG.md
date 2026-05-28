# Changelog

Versões deste template (não confundir com o changelog do projecto que o usa).

O formato segue [Keep a Changelog](https://keepachangelog.com/) e
[Semantic Versioning](https://semver.org/).

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

### Fases pendentes (próximas releases)
- **Fase 3**: design conversacional — agente `design-explorer` + skills
  `wireframing-in-markdown` e flows em Mermaid.
