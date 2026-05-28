# PRDs — Product Requirements Documents

PRDs vivem aqui, um por ficheiro: `NNNN-titulo-curto.md` (NNNN sequencial — não
reutilizes nem saltes números).

## Formato

Ver a skill `.claude/skills/writing-prds/SKILL.md` para o formato completo. Em
resumo, um PRD tem: frontmatter (`prd`, `status`, `date`, `owner`) → **Problema**
→ **Win condition** (qualitativa + métrica) → **Escopo** (`Inclui` + `Não inclui`)
→ **User stories** com Given/When/Then → **Decisões em aberto** → **Riscos** →
**Links** (roadmap, descoberta, PDDs).

## Lifecycle

```
proposed  →  accepted  →  shipped
                  ↓
              superseded by PRD-XXXX
```

- **proposed**: draft em discussão.
- **accepted**: aprovado, no roadmap (`now`/`next`).
- **shipped**: entregue (sai do roadmap activo para `shipped` no roadmap).
- **superseded**: substituído por outro PRD (mantém o ficheiro, atualiza o status).