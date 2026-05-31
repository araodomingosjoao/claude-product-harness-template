---
name: spec-conformance-rubric
description: Rubrica para verificar se uma PR de engenharia cumpre as regras de negócio do PRD que a originou — critérios de aceitação, decisões (D-NNN) e o que NÃO foi inventado. Usa no spec-conformance-reviewer.
---

# Spec-conformance (senior)

A engenharia implementa; esta rubrica verifica se a implementação **honra a spec**
de produto. **Não** a qualidade do código (isso é o code-review do engineering),
mas se as **regras de negócio** do PRD foram cumpridas. É o lado de produto do loop
produto↔engenharia — confirma a ida, e apanha quando a engenharia divergiu.

## O que verificar (contra o PRD ligado no ticket/trailer)

1. **Cada critério de aceitação tem prova.** Para cada Given/When/Then da(s)
   story(ies), o diff implementa-o **e** há um teste que o cobre. Critério sem
   teste = 🟡; critério contrariado = 🔴.
2. **As decisões (D1, D2, …) são respeitadas.** Lê as "Decisões já tomadas" do PRD
   e confirma que o código não as viola (ex.: se o D1 diz "fonte de verdade = X",
   o código não pode tratar Y como autoridade). Decisão `[SUPERSEDED]` → vale a que
   a substituiu.
3. **Nada de decisões inventadas.** Se o código tomou uma decisão de negócio que o
   PRD **não** tomou (auto-criar um registo, escolher um default que muda o
   comportamento, colapsar dois estados num só), isso é um **`needs-product`** — não
   um facto consumado. Sinaliza, não aceites.
4. **Estados/erros distinguíveis** conforme o PRD (ex.: erro-A ≠ erro-B se o PRD
   exige distinção; não conflundir "sem saldo" com "cartão inválido").
5. **Fora-de-escopo respeitado.** O PR não fez mais do que o ticket pedia (scope
   creep) nem regrediu uma restrição registada (ex.: ordem de escrita do D7).
6. **Incerteza do implementador = sinal.** Se o PR/comentários mostram o agente
   inseguro ("acho que…", "assumi que…", "não estava claro se…"), trata como
   `needs-product`: a spec estava ambígua ali — clarifica-a na fonte.

## Veredicto

Os tipos **não são exclusivos**: um mesmo PR pode ter, ao mesmo tempo, violações de
regra (**PEDIR ALTERAÇÕES**) **e** pontos de spec ambígua (**NEEDS-PRODUCT**). Nesse
caso dá um **veredicto misto** e separa o que é *código a corrigir* (vai para a
engenharia) do que é *spec a clarificar* (vai para o produto) — cada um para o seu
dono. O veredicto global é o mais bloqueante presente.

- **CONFORME** — todos os critérios provados, nenhuma decisão violada nem inventada.
- **PEDIR ALTERAÇÕES** — o código **viola** uma regra ou falta prova de um critério.
- **NEEDS-PRODUCT** — a causa não é código errado, é **spec ambígua**: formula a
  pergunta e diz que decisão do PRD passa de aberta a tomada.

Por achado: severidade (🔴 viola / 🟡 dúvida-ou-sem-teste / ✅ conforme), a **regra
do PRD** em causa (cita `D-NNN` ou a story), e o fix **ou** a pergunta. Em PT.

## Fronteira (o que NÃO é teu)

- **Não** revejas estilo, arquitectura, performance ou padrões de código — é da
  engenharia.
- **Não** reescrevas o PRD para "encaixar" o código. Se o código diverge por boa
  razão, isso é **input para o produto decidir** (`needs-product`), não para ceder
  a spec em silêncio.
- **Não** inventes problemas para parecer minucioso. Silêncio num ponto = conforme.
