---
name: roadmap-thinking
description: Como pensar (e escrever) um roadmap honesto — now / next / later sem datas firmes para o futuro, trade-offs, e quando mover algo de bucket. Usa ao manter docs/roadmap.md.
---

# Roadmap thinking (senior)

O roadmap é uma **vista do estado**, não um contrato. Quem o lê deve perceber em
1 minuto o que estamos a fazer **agora**, o que vem **a seguir**, e o que
**considerámos para depois**.

## Os 3 buckets

- **Now**: o que está a ser executado (sprint actual e o próximo). Aponta para
  PRDs existentes (status `accepted` ou `proposed` perto de ship).
- **Next**: 1-2 meses; intenção, não promessa. PRDs em discussão; cada item liga a
  um PRD ou a uma vaga clara.
- **Later**: ≥ 3 meses ou hipóteses. Vago a propósito; pode mudar a qualquer
  momento.

## Princípios

- **Datas firmes só em `shipped`.** `Next` e `later` são intenção, não promessa.
  Se prometeres datas firmes em `next`, vais quebrar.
- **Cada item aponta para um PRD** (ou uma vaga em `later`). Roadmap não duplica
  conteúdo do PRD — só título + link.
- **Princípios em cima.** 3-5 frases de prioridade que mudam raramente (só com
  PDD). O resto do roadmap interpreta-se à luz delas.
- **Move com sinal, não com fé.** Subir uma coisa de `later` para `now` precisa de
  evidência (descoberta, métrica) e capacidade libertada.

## Sinais para reagir
- Item em `now` há mais de 2 sprints → quebra-o ou requestiona.
- `Next` cheio enquanto `now` arrasta → estás a planear em vez de executar.
- `Later` enorme → tudo bem; é parking de ideias. Não te obrigues a comprometer.
- Métrica acordada não mexe → revisita o PRD, não o esforço.

## Antipadrões
- Roadmap-Gantt (todo datado por trimestre) → não é roadmap, é compromisso.
- Roadmap só com features → falta a *intenção* (qual o resultado para o user).
- Roadmap sem `shipped` → perdes memória do que aprendeste.