---
name: discovery-methods
description: Métodos sénior de descoberta para destilar entrevistas, notas e dados em hipóteses testáveis — JTBD, entrevistas, evidência forte vs fraca, perguntas em aberto. Usa ao sintetizar material em docs/discovery/.
---

# Discovery methods (senior)

Descoberta não é "perguntar ao user o que quer". É **entender o problema** o
suficiente para formular hipóteses testáveis. Citas evidência, nunca a inventas.

## Frameworks úteis (não dogmáticos)

- **Jobs To Be Done (JTBD)**: "Quando [situação], eu quero [motivação], para
  [resultado esperado]." Foca no progresso que o user procura, não nas features.
- **Problem/Outcome/Solution**: separa os três. Confundi-los enviesa a discussão.
- **Five Whys**: usa para chegar à causa, mas sem teatro — pára quando já não
  acrescenta.

## Entrevistas — como ler bem

- **Distingue facto, padrão e opinião.** "Cancelei 3x" é facto; "não gostam" é
  opinião do entrevistado.
- **Cita.** "Comprei pelo preço" (entrevista #4) é matéria-prima. "Os users são
  sensíveis ao preço" é hipótese — marca o nível de evidência.
- **5 entrevistas dão padrões; 1 não dá.** Sinaliza quando tens dados
  insuficientes.
- **Cuidado com leading questions.** "Não acharias útil ter X?" não é dado, é
  ruído. Reformula em "Como resolves Y hoje?".

## Hipóteses testáveis

```
**H1**: Owners de projecto evitam apagar projectos antigos por medo de perder
contexto.
- Evidência: forte | média | fraca
- Como testar: oferecer "Arquivar" e medir adesão em 30 dias.
```

Sem **como testar**, é fé, não hipótese.

## Output da síntese

- **Sinais observados** (factos, com fonte).
- **Padrões** que vês recorrer (≥ 2 fontes).
- **Hipóteses** com evidência classificada (forte/média/fraca) e como testar.
- **Perguntas em aberto** — o que ainda não sabes e bloqueia decisão.
- **Recomendação** — vale escrever PRD agora ou precisamos de mais descoberta?

## Antipadrões

- **Confirmation bias**: só citares quem disse o que querias ouvir.
- **Generalizar de 1 entrevista**: "X disse Y, logo os users querem Y."
- **Misturar problema e solução**: "Os users querem botão de arquivar" é uma
  solução; o problema é "como gerir projectos antigos sem ruído".
- **Inventar descoberta**: se não há dados, di-lo. "Não temos dados sobre X" é
  uma resposta válida.