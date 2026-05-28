---
name: product-review-rubric
description: Rubrica sénior para rever PRDs, sprints e mudanças de roadmap — coerência, escopo, win condition, qualidade das stories, alinhamento com scope/PDDs. Usa antes de aprovar um PR de produto.
---

# Product review rubric (senior)

Revê o **diff**, não o repo todo. O `CLAUDE.md` + `docs/scope.md` + os PDDs são a
régua. Sinaliza só o que muda a decisão de merge; distingue **🔴 bloqueante** de
**🟡 sugestão**.

## 1. Coerência com a visão
- O PRD/sprint aponta para um problema que está dentro do `scope.md`? Se não, é
  PDD ou rejeição.
- Não contradiz nenhum PDD existente (e se contradiz, propõe `superseded by`).

## 2. PRD: qualidade essencial (bloqueante)
- **Win condition mensurável** — uma métrica concreta + prazo, não "melhorar UX".
- **Escopo honesto** — `**Não inclui**` está preenchido e é coerente com
  `**Inclui**` (sem scope-creep silencioso).
- **User stories testáveis** — Given/When/Then presentes, comportamento
  observável (não implementação).
- **Decisões em aberto explícitas** — listadas, não escondidas.

## 3. Sprint: qualidade essencial
- **Um** objetivo mensurável (não cinco).
- **Capacidade declarada** e realista vs velocidade observada.
- Stories ligam a PRDs (excepto `chore`/fix triviais explicados).

## 4. Roadmap
- Mudanças coerentes com PDDs / PRDs aceites.
- Sem datas firmes em `next`/`later`.
- Items em `now` há demasiado tempo → sinaliza.

## 5. Tickets (drafts em Markdown ou cross-repo)
- Título imperativo curto; Given/When/Then; link ao PRD; risco; "fora de escopo".
- Sem detalhes técnicos enfiados à força.

## Como devolver a review
- Agrupa por ficheiro. Cada nota: severidade (🔴 bloqueante / 🟡 sugestão), o quê,
  o porquê, e o fix concreto.
- Termina com um veredicto: **APROVAR** ou **PEDIR ALTERAÇÕES** + uma razão em uma
  linha.
- **Em português** (a conversa do PR é em PT; ver `CLAUDE.md` → "Idioma do
  feedback"). Mantém identificadores, paths e códigos como estão.

## Não faças
- Não reescrevas o PRD ao teu gosto — o estilo do autor + o existente ganham.
- Não inventes problemas para parecer minucioso. Silêncio = está bem.