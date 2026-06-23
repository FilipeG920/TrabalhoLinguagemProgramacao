# Paradigma Orientado a Objetos - Java

## Interpretador/compilador utilizado
- `javac 26.0.1`
- `openjdk version "26.0.1" 2026-04-21`

O código foi escrito para Java 17 ou superior, pois usa `record` e `Stream.toList()`.

## Arquivo principal
- `FolhaPagamento.java`

## Como compilar
```bash
javac FolhaPagamento.java
```

## Como executar
```bash
java FolhaPagamento
```

## Dependências externas
Nenhuma. A implementação usa apenas a biblioteca padrão de Java.

## Observações sobre o paradigma
A solução encapsula os dados em `Funcionario` e `ResultadoFolha`, representa as faixas como objetos `Faixa` e aplica descontos por meio da interface `RegraDesconto`. `RegraINSS` e `RegraIRRF` são estratégias concretas usadas por `CalculadoraFolha`.

## Política de arredondamento
Os cálculos internos usam `double`. Os valores monetários são formatados com duas casas decimais apenas na saída.
