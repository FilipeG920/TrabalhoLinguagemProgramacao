# Paradigma Imperativo - C

## Compilador utilizado
- GCC 16.1.1 20260430, verificado com `gcc --version`.

## Arquivo principal
- `folha_pagamento.c`

## Como compilar
```bash
gcc -std=c11 -Wall -Wextra -pedantic folha_pagamento.c -o folha_pagamento
```

## Como executar
```bash
./folha_pagamento
```

## Dependências externas
Nenhuma. A implementação usa apenas a biblioteca padrão de C.

## Observações sobre o paradigma
A solução usa `structs`, arrays de faixas e laços explícitos. A função `buscar_aliquota` percorre sequencialmente a tabela de faixas, e o `main` mantém acumuladores para total, maior salário líquido e menor salário líquido.

## Política de arredondamento
Os cálculos internos usam `double`. Os valores monetários são formatados com duas casas decimais apenas na saída.
