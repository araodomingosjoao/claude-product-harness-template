# PDDs — Product Decision Documents

Decisões de **produto** arquiteturalmente significativas vivem aqui (o equivalente
aos ADRs da engenharia, mas para decisões sobre **o quê construir e porquê**, não
sobre **como**).

`NNNN-titulo-curto.md` — sequencial, sem reuso nem saltos.

## Quando merece PDD

Merece:
- Difícil de reverter (escolha de mercado-alvo, mudança de princípio do produto,
  abandonar um pilar do `scope.md`).
- Trade-off não-óbvio que alguém vai questionar daqui a 6 meses.
- Desvio explícito de um princípio do `scope.md`.

Não merece (não inventes ruído):
- Decisão já coberta pelo `scope.md` ou óbvia dado o contexto.
- Detalhe reversível dentro de um PRD (vai no próprio PRD).
- Coisas que o `roadmap.md` ou o git já registam.

## Formato

```markdown
# PDD-NNNN: <título>

- Status: proposed | accepted | superseded by PDD-XXXX
- Date: YYYY-MM-DD

## Context
O problema / forças em jogo. Porquê esta decisão.

## Decision
O que decidimos, no activo: "Vamos X."

## Consequences
O que melhora, o que piora, o que passa a ser mais difícil. Trade-offs honestos.

## Alternatives considered
Opções rejeitadas e porquê (1 linha cada).
```