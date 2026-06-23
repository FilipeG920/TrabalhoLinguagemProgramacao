# Paradigma Lógico - Prolog

## Interpretador utilizado
- SWI-Prolog 10.0.2, verificado com `swipl --version`.

O código foi escrito para SWI-Prolog.

## Arquivo principal
- `folha_pagamento.pl`

## Como executar
```bash
swipl -q -s folha_pagamento.pl
```

Consulta alternativa dentro do REPL:
```prolog
funcionarios_obrigatorios(Fs), folha(Fs, Resultados), total_folha(Resultados, Total).
```

## Dependências externas
Nenhuma. A implementação usa apenas predicados padrão de SWI-Prolog.

## Observações sobre o paradigma
A solução representa as faixas como fatos (`faixa_inss/2` e `faixa_irrf/2`) e o cálculo como relações entre termos de entrada e saída. O predicado `folha/2` processa a lista com `maplist/3`, sem simular estado mutável.

## Política de arredondamento
Os cálculos internos usam números reais do Prolog. Os valores monetários são formatados com duas casas decimais apenas na saída.
