#include <stdio.h>
#include <stddef.h>

typedef struct {
    const char *nome;
    double salario_bruto;
    int dependentes;
    int horas_extras;
} Funcionario;

typedef struct {
    double limite;
    double aliquota;
} Faixa;

typedef struct {
    const char *nome;
    double bruto;
    double extras;
    double inss;
    double irrf;
    double liquido;
} Resultado;

static const Faixa FAIXAS_INSS[] = {
    {1412.00, 0.075},
    {2666.00, 0.090},
    {4000.00, 0.120},
    {1.0 / 0.0, 0.140}
};

static const Faixa FAIXAS_IRRF[] = {
    {2259.00, 0.000},
    {2826.00, 0.075},
    {3751.00, 0.150},
    {4664.00, 0.225},
    {1.0 / 0.0, 0.275}
};

static double buscar_aliquota(double valor, const Faixa faixas[], size_t quantidade) {
    for (size_t i = 0; i < quantidade; i++) {
        if (valor <= faixas[i].limite) {
            return faixas[i].aliquota;
        }
    }
    return faixas[quantidade - 1].aliquota;
}

static double calcular_extras(const Funcionario *f) {
    double valor_hora = f->salario_bruto / 180.0;
    return valor_hora * 1.5 * f->horas_extras;
}

static Resultado calcular_funcionario(const Funcionario *f) {
    double extras = calcular_extras(f);
    double aliquota_inss = buscar_aliquota(f->salario_bruto, FAIXAS_INSS, sizeof(FAIXAS_INSS) / sizeof(FAIXAS_INSS[0]));
    double inss = f->salario_bruto * aliquota_inss;
    double deducao_dependentes = f->dependentes * 189.59;
    double base_irrf = f->salario_bruto + extras - inss - deducao_dependentes;
    if (base_irrf < 0.0) base_irrf = 0.0;
    double aliquota_irrf = buscar_aliquota(base_irrf, FAIXAS_IRRF, sizeof(FAIXAS_IRRF) / sizeof(FAIXAS_IRRF[0]));
    double irrf = base_irrf * aliquota_irrf;

    Resultado r = {f->nome, f->salario_bruto, extras, inss, irrf, f->salario_bruto + extras - inss - irrf};
    return r;
}

static void imprimir_resultado(Resultado r) {
    printf("%-8s Bruto: %8.2f | Extras: %7.2f | INSS: %7.2f | IRRF: %7.2f | Liquido: %8.2f\n",
           r.nome, r.bruto, r.extras, r.inss, r.irrf, r.liquido);
}

int main(void) {
    Funcionario funcionarios[] = {
        {"Ana", 4500.00, 2, 8},
        {"Bruno", 2200.00, 0, 0},
        {"Carla", 1300.00, 1, 4}
    };
    size_t quantidade = sizeof(funcionarios) / sizeof(funcionarios[0]);

    double total = 0.0;
    Resultado maior = calcular_funcionario(&funcionarios[0]);
    Resultado menor = maior;

    puts("Folha de pagamento - paradigma imperativo (C)");
    puts("Politica: valores monetarios exibidos com 2 casas decimais; calculos internos usam double.\n");

    for (size_t i = 0; i < quantidade; i++) {
        Resultado atual = calcular_funcionario(&funcionarios[i]);
        imprimir_resultado(atual);
        total += atual.liquido;
        if (atual.liquido > maior.liquido) maior = atual;
        if (atual.liquido < menor.liquido) menor = atual;
    }

    printf("\nTotal da folha: %.2f\n", total);
    printf("Maior salario liquido: %s (%.2f)\n", maior.nome, maior.liquido);
    printf("Menor salario liquido: %s (%.2f)\n", menor.nome, menor.liquido);
    return 0;
}
