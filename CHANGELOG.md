# Changelog

Versões deste template (não confundir com o changelog do projecto que o usa).

O formato segue [Keep a Changelog](https://keepachangelog.com/) e
[Semantic Versioning](https://semver.org/).

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
- **Fase 2**: cross-repo wiring — `ticket-writer` cria issues no repo de engenharia
  via `gh issue create --repo`; `config/harness/engineering.yml`.
- **Fase 3**: design conversacional — agente `design-explorer` + skills
  `wireframing-in-markdown` e flows em Mermaid.
