module Main where

import Data.List (maximumBy, minimumBy)
import Data.Ord (comparing)

data Funcionario = Funcionario
    { nome :: String
    , salarioBruto :: Double
    , dependentes :: Int
    , horasExtras :: Int
    } deriving (Show)

data ResultadoFolha = ResultadoFolha
    { resultadoNome :: String
    , bruto :: Double
    , extras :: Double
    , inss :: Double
    , irrf :: Double
    , liquido :: Double
    } deriving (Show)

type Faixa = (Double, Double)

faixasINSS :: [Faixa]
faixasINSS =
    [ (1412.00, 0.075)
    , (2666.00, 0.090)
    , (4000.00, 0.120)
    , (1 / 0, 0.140)
    ]

faixasIRRF :: [Faixa]
faixasIRRF =
    [ (2259.00, 0.000)
    , (2826.00, 0.075)
    , (3751.00, 0.150)
    , (4664.00, 0.225)
    , (1 / 0, 0.275)
    ]

aliquota :: [Faixa] -> Double -> Double
aliquota [] _ = error "Tabela de faixas vazia ou valor fora das faixas"
aliquota ((limite, taxa):resto) valor
    | valor <= limite = taxa
    | otherwise = aliquota resto valor

valorExtras :: Funcionario -> Double
valorExtras f = (salarioBruto f / 180.0) * 1.5 * fromIntegral (horasExtras f)

deducaoDependentes :: Funcionario -> Double
deducaoDependentes f = fromIntegral (dependentes f) * 189.59

calcularFuncionario :: Funcionario -> ResultadoFolha
calcularFuncionario f = ResultadoFolha (nome f) brutoFuncionario extrasFuncionario valorINSS valorIRRF valorLiquido
  where
    brutoFuncionario = salarioBruto f
    extrasFuncionario = valorExtras f
    valorINSS = brutoFuncionario * aliquota faixasINSS brutoFuncionario
    baseIRRF = max 0.0 (brutoFuncionario + extrasFuncionario - valorINSS - deducaoDependentes f)
    valorIRRF = baseIRRF * aliquota faixasIRRF baseIRRF
    valorLiquido = brutoFuncionario + extrasFuncionario - valorINSS - valorIRRF

formatarResultado :: ResultadoFolha -> String
formatarResultado r = resultadoNome r ++
    " | Bruto: " ++ moeda (bruto r) ++
    " | Extras: " ++ moeda (extras r) ++
    " | INSS: " ++ moeda (inss r) ++
    " | IRRF: " ++ moeda (irrf r) ++
    " | Liquido: " ++ moeda (liquido r)

moeda :: Double -> String
moeda = formatDouble 2

formatDouble :: Int -> Double -> String
formatDouble casas valor = showFFloatFixed casas valor

showFFloatFixed :: Int -> Double -> String
showFFloatFixed casas valor = let fator = 10 ^ casas :: Integer
                                  arredondado = round (valor * fromIntegral fator) :: Integer
                                  inteiro = arredondado `div` fator
                                  decimal = arredondado `mod` fator
                                  dec = show decimal
                              in show inteiro ++ "." ++ replicate (casas - length dec) '0' ++ dec

funcionarios :: [Funcionario]
funcionarios =
    [ Funcionario "Ana" 4500.00 2 8
    , Funcionario "Bruno" 2200.00 0 0
    , Funcionario "Carla" 1300.00 1 4
    ]

main :: IO ()
main = do
    let resultados = map calcularFuncionario funcionarios
        totalFolha = sum (map liquido resultados)
        maior = maximumBy (comparing liquido) resultados
        menor = minimumBy (comparing liquido) resultados
    putStrLn "Folha de pagamento - paradigma funcional (Haskell)"
    putStrLn "Politica: valores monetarios exibidos com 2 casas decimais; calculos internos usam Double.\n"
    mapM_ (putStrLn . formatarResultado) resultados
    putStrLn ("\nTotal da folha: " ++ moeda totalFolha)
    putStrLn ("Maior salario liquido: " ++ resultadoNome maior ++ " (" ++ moeda (liquido maior) ++ ")")
    putStrLn ("Menor salario liquido: " ++ resultadoNome menor ++ " (" ++ moeda (liquido menor) ++ ")")
