# Paradigma Funcional - Haskell

## Interpretador/compilador utilizado
- GHC 9.10.3, verificado com `ghc --version`.

O código usa apenas recursos básicos compatíveis com versões modernas do GHC.

## Arquivo principal
- `Main.hs`

## Como compilar
```bash
ghc -Wall Main.hs -o folha-pagamento
```

## Como executar
```bash
./folha-pagamento
```

Execução direta alternativa, se `runghc` estiver disponível:
```bash
runghc Main.hs
```

## Dependências externas
Nenhuma. A implementação usa apenas módulos da biblioteca padrão (`Data.List` e `Data.Ord`).

## Observações sobre o paradigma
A solução é baseada em funções puras. As faixas são listas de pares, cada funcionário é transformado em um resultado por `map`, e os agregados usam `sum`, `maximumBy` e `minimumBy`.

## Política de arredondamento
Os cálculos internos usam `Double`. Os valores monetários são formatados com duas casas decimais apenas na saída por uma função pura de formatação.
