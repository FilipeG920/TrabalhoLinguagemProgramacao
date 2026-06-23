% Folha de pagamento - paradigma logico (Prolog)
% Politica: valores monetarios exibidos com 2 casas decimais; calculos internos usam numeros reais.

funcionario('Ana', 4500.00, 2, 8).
funcionario('Bruno', 2200.00, 0, 0).
funcionario('Carla', 1300.00, 1, 4).

faixa_inss(1412.00, 0.075).
faixa_inss(2666.00, 0.090).
faixa_inss(4000.00, 0.120).
faixa_inss(infinito, 0.140).

faixa_irrf(2259.00, 0.000).
faixa_irrf(2826.00, 0.075).
faixa_irrf(3751.00, 0.150).
faixa_irrf(4664.00, 0.225).
faixa_irrf(infinito, 0.275).

aliquota(Tipo, Valor, Aliquota) :-
    faixa(Tipo, Limite, Aliquota),
    dentro_da_faixa(Valor, Limite),
    !.

faixa(inss, Limite, Aliquota) :- faixa_inss(Limite, Aliquota).
faixa(irrf, Limite, Aliquota) :- faixa_irrf(Limite, Aliquota).

dentro_da_faixa(_, infinito).
dentro_da_faixa(Valor, Limite) :- number(Limite), Valor =< Limite.

valor_extras(salario(_, Bruto, _, HorasExtras), Extras) :-
    Extras is (Bruto / 180.0) * 1.5 * HorasExtras.

deducao_dependentes(salario(_, _, Dependentes, _), Deducao) :-
    Deducao is Dependentes * 189.59.

calcular_funcionario(salario(Nome, Bruto, Dependentes, HorasExtras), resultado(Nome, Bruto, Extras, INSS, IRRF, Liquido)) :-
    valor_extras(salario(Nome, Bruto, Dependentes, HorasExtras), Extras),
    aliquota(inss, Bruto, AliquotaINSS),
    INSS is Bruto * AliquotaINSS,
    deducao_dependentes(salario(Nome, Bruto, Dependentes, HorasExtras), Deducao),
    BaseTemporaria is Bruto + Extras - INSS - Deducao,
    BaseIRRF is max(0.0, BaseTemporaria),
    aliquota(irrf, BaseIRRF, AliquotaIRRF),
    IRRF is BaseIRRF * AliquotaIRRF,
    Liquido is Bruto + Extras - INSS - IRRF.

folha(Funcionarios, Resultados) :-
    maplist(calcular_funcionario, Funcionarios, Resultados).

total_folha(Resultados, Total) :-
    findall(Liquido, member(resultado(_, _, _, _, _, Liquido), Resultados), Liquidos),
    sum_list(Liquidos, Total).

maior_liquido([Resultado], Resultado).
maior_liquido([R1, R2 | Resto], Maior) :-
    R1 = resultado(_, _, _, _, _, L1),
    R2 = resultado(_, _, _, _, _, L2),
    (L1 >= L2 -> maior_liquido([R1 | Resto], Maior) ; maior_liquido([R2 | Resto], Maior)).

menor_liquido([Resultado], Resultado).
menor_liquido([R1, R2 | Resto], Menor) :-
    R1 = resultado(_, _, _, _, _, L1),
    R2 = resultado(_, _, _, _, _, L2),
    (L1 =< L2 -> menor_liquido([R1 | Resto], Menor) ; menor_liquido([R2 | Resto], Menor)).

funcionarios_obrigatorios(Funcionarios) :-
    findall(salario(Nome, Bruto, Dependentes, HorasExtras), funcionario(Nome, Bruto, Dependentes, HorasExtras), Funcionarios).

imprimir_resultado(resultado(Nome, Bruto, Extras, INSS, IRRF, Liquido)) :-
    format('~w | Bruto: ~2f | Extras: ~2f | INSS: ~2f | IRRF: ~2f | Liquido: ~2f~n',
           [Nome, Bruto, Extras, INSS, IRRF, Liquido]).

main :-
    funcionarios_obrigatorios(Funcionarios),
    folha(Funcionarios, Resultados),
    total_folha(Resultados, Total),
    maior_liquido(Resultados, Maior),
    menor_liquido(Resultados, Menor),
    Maior = resultado(NomeMaior, _, _, _, _, LiquidoMaior),
    Menor = resultado(NomeMenor, _, _, _, _, LiquidoMenor),
    writeln('Folha de pagamento - paradigma logico (Prolog)'),
    writeln('Politica: valores monetarios exibidos com 2 casas decimais; calculos internos usam numeros reais.'),
    nl,
    maplist(imprimir_resultado, Resultados),
    nl,
    format('Total da folha: ~2f~n', [Total]),
    format('Maior salario liquido: ~w (~2f)~n', [NomeMaior, LiquidoMaior]),
    format('Menor salario liquido: ~w (~2f)~n', [NomeMenor, LiquidoMenor]).

:- initialization(main, main).
