# claude-product-harness-template

Template GitHub para projectos de **produto** conduzidos com Claude Code e
`@claude` — irmão do
[`laravel-vue-harness-template`](https://github.com/araodomingosjoao/laravel-vue-harness-template).
Aqui o "código" são **PRDs, decisões, sprints e tickets**, com o mesmo ciclo
`PR → review (em PT) → merge` a aplicar-se a artefactos de produto.

## Para que serve

O harness de engenharia trata do *como construir*. Este trata do *o quê construir e
porquê*. Junta:

- Um **pipeline de agentes seniores** para o ciclo de produto:
  `spec-writer → discovery-researcher → prd-author → product-reviewer → roadmap-keeper`
  e, em paralelo, `sprint-planner → ticket-writer`.
- **Skills** sénior reutilizáveis (writing-prds, user-story-writing,
  sprint-planning, roadmap-thinking, discovery-methods, product-review-rubric).
- **Governance** (CLAUDE.md, branch protection, CODEOWNERS, AI review em PT).
- **Hand-off cross-repo** (Fase 2) — o `ticket-writer` cria issues no repo de
  engenharia para o `@claude` de lá implementar. Fecha o loop produto → engenharia.

## Começar

### 1. Criar um projecto a partir deste template

Clica em **"Use this template"** no GitHub, ou:

```bash
gh repo create meu-produto --template araodomingosjoao/claude-product-harness-template --public
gh repo clone <user>/meu-produto && cd meu-produto
```

### 2. Inicializar

Preenche os placeholders do `CLAUDE.md`, o `docs/scope.md` e o `docs/roadmap.md`.

### 3. Configurar o CI

Em **Settings → Secrets and variables → Actions**, define:

- `CLAUDE_CODE_OAUTH_TOKEN` — corre `claude setup-token` localmente e cola o
  resultado. Serve o `ai-review` e o `claude.yml` (`@claude`), na subscrição.

Instala o [Claude GitHub App](https://github.com/apps/claude) e seleciona o repo
(senão o `@claude` falha com *"Claude Code is not installed"*).

**Proteger a `main`** (uma vez, precisa de admin):

```bash
gh api -X PUT repos/OWNER/REPO/branches/main/protection --input - <<'JSON'
{
  "required_status_checks": { "strict": false,
    "contexts": ["Pre-flight checks", "Markdown lint"] },
  "enforce_admins": false,
  "required_pull_request_reviews": { "required_approving_review_count": 1,
    "require_code_owner_reviews": true, "dismiss_stale_reviews": true },
  "restrictions": null
}
JSON
```

Edita o `.github/CODEOWNERS` para o teu utilizador/equipa.

### 4. Validar

```bash
# corre o markdown lint local (se instalado)
npx markdownlint-cli2 'docs/**/*.md' 'sprints/**/*.md' 'CLAUDE.md' 'README.md'
```

## Como trabalhar no dia-a-dia

**Modo A — Local (Claude Code).** Pedes ao Claude "escreve um PRD para X" e ele
orquestra o pipeline localmente; tu fazes commit numa branch e abres PR.

**Modo B — Assíncrono (`@claude`).** Abres um issue (ex.: "PRD: notificações de
projecto") e mencionas `@claude`. Ele segue o pipeline:
`spec-writer → discovery-researcher → prd-author → product-reviewer` e abre o PR
com o PRD no `docs/prds/`. A review do AI já vem em **português**.

### O loop por feature

```
1. Slice do scope / nova ideia      ─►  spec-writer (se vago)
2. Descoberta (entrevistas/notas)   ─►  discovery-researcher
3. Draft do PRD                     ─►  prd-author
4. Review de coerência              ─►  product-reviewer
5. Roadmap actualizado              ─►  roadmap-keeper
6. Sprint kickoff                   ─►  sprint-planner
7. Stories → issues (eng repo)      ─►  ticket-writer  (Fase 2)
```

## Estrutura

```
.
├── CLAUDE.md                  # Convenções do projecto (lido pelo agente)
├── README.md                  # Este ficheiro
├── CHANGELOG.md               # Versões do template
│
├── .claude/agents/            # Pipeline de agentes (spec, discovery, PRD, …)
├── .claude/skills/            # Conhecimento sénior reutilizável
│
├── .github/                   # CI/CD, templates de issues e PR
│   ├── workflows/agent-pr.yml # gates de docs + AI review (PT)
│   ├── workflows/claude.yml   # @claude → o agente conduz o pipeline
│   ├── CODEOWNERS
│   └── ISSUE_TEMPLATE/
│
├── config/harness/
│   ├── policy.yml             # Budgets, kill switch, risco por path
│   ├── skills.yml             # Allow-list de skills
│   └── engineering.yml        # (Fase 2) Repo de engenharia para handoff
│
├── docs/
│   ├── scope.md               # Visão estável (a north star)
│   ├── roadmap.md             # now / next / later
│   ├── prds/                  # Product Requirements Documents
│   ├── pdds/                  # Product Decision Documents
│   └── discovery/             # Notas, entrevistas, hipóteses
│
└── sprints/                   # Planos de sprint (YYYY-Wnn.md)
```

## Filosofia em uma linha

> O sistema constrói (no repo de engenharia). Aqui **decidimos o quê construir**,
> documentamos o porquê, e dividimos isso em sprints e tickets — com o mesmo rigor
> de governance e a mesma divisão "agente propõe / humano aprova".

## Licença

MIT.