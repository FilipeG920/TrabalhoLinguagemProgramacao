import java.util.List;
import java.util.Comparator;
import java.util.Locale;

public class FolhaPagamento {
    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        List<Funcionario> funcionarios = List.of(
            new Funcionario("Ana", 4500.00, 2, 8),
            new Funcionario("Bruno", 2200.00, 0, 0),
            new Funcionario("Carla", 1300.00, 1, 4)
        );

        CalculadoraFolha calculadora = new CalculadoraFolha(new RegraINSS(), new RegraIRRF());
        List<ResultadoFolha> resultados = calculadora.calcular(funcionarios);
        ResumoFolha resumo = ResumoFolha.de(resultados);

        System.out.println("Folha de pagamento - paradigma orientado a objetos (Java)");
        System.out.println("Politica: valores monetarios exibidos com 2 casas decimais; calculos internos usam double.\n");
        resultados.forEach(System.out::println);
        System.out.printf("%nTotal da folha: %.2f%n", resumo.totalFolha());
        System.out.printf("Maior salario liquido: %s (%.2f)%n", resumo.maior().nome(), resumo.maior().liquido());
        System.out.printf("Menor salario liquido: %s (%.2f)%n", resumo.menor().nome(), resumo.menor().liquido());
    }
}

record Funcionario(String nome, double salarioBruto, int dependentes, int horasExtras) {}

record ResultadoFolha(String nome, double bruto, double extras, double inss, double irrf, double liquido) {
    @Override
    public String toString() {
        return String.format("%-8s Bruto: %8.2f | Extras: %7.2f | INSS: %7.2f | IRRF: %7.2f | Liquido: %8.2f",
            nome, bruto, extras, inss, irrf, liquido);
    }
}

record Faixa(double limite, double aliquota) {
    boolean contem(double valor) {
        return valor <= limite;
    }
}

interface RegraDesconto {
    double calcular(double base);
}

class RegraPorFaixas implements RegraDesconto {
    private final List<Faixa> faixas;

    RegraPorFaixas(List<Faixa> faixas) {
        this.faixas = faixas;
    }

    @Override
    public double calcular(double base) {
        double aliquota = faixas.stream()
            .filter(faixa -> faixa.contem(base))
            .findFirst()
            .orElseThrow()
            .aliquota();
        return base * aliquota;
    }
}

class RegraINSS extends RegraPorFaixas {
    RegraINSS() {
        super(List.of(
            new Faixa(1412.00, 0.075),
            new Faixa(2666.00, 0.090),
            new Faixa(4000.00, 0.120),
            new Faixa(Double.POSITIVE_INFINITY, 0.140)
        ));
    }
}

class RegraIRRF extends RegraPorFaixas {
    RegraIRRF() {
        super(List.of(
            new Faixa(2259.00, 0.000),
            new Faixa(2826.00, 0.075),
            new Faixa(3751.00, 0.150),
            new Faixa(4664.00, 0.225),
            new Faixa(Double.POSITIVE_INFINITY, 0.275)
        ));
    }
}

class CalculadoraFolha {
    private static final double DEDUCAO_POR_DEPENDENTE = 189.59;
    private final RegraDesconto regraINSS;
    private final RegraDesconto regraIRRF;

    CalculadoraFolha(RegraDesconto regraINSS, RegraDesconto regraIRRF) {
        this.regraINSS = regraINSS;
        this.regraIRRF = regraIRRF;
    }

    List<ResultadoFolha> calcular(List<Funcionario> funcionarios) {
        return funcionarios.stream().map(this::calcular).toList();
    }

    ResultadoFolha calcular(Funcionario f) {
        double extras = (f.salarioBruto() / 180.0) * 1.5 * f.horasExtras();
        double inss = regraINSS.calcular(f.salarioBruto());
        double baseIRRF = Math.max(0.0, f.salarioBruto() + extras - inss - f.dependentes() * DEDUCAO_POR_DEPENDENTE);
        double irrf = regraIRRF.calcular(baseIRRF);
        double liquido = f.salarioBruto() + extras - inss - irrf;
        return new ResultadoFolha(f.nome(), f.salarioBruto(), extras, inss, irrf, liquido);
    }
}

record ResumoFolha(double totalFolha, ResultadoFolha maior, ResultadoFolha menor) {
    static ResumoFolha de(List<ResultadoFolha> resultados) {
        double total = resultados.stream().mapToDouble(ResultadoFolha::liquido).sum();
        ResultadoFolha maior = resultados.stream().max(Comparator.comparingDouble(ResultadoFolha::liquido)).orElseThrow();
        ResultadoFolha menor = resultados.stream().min(Comparator.comparingDouble(ResultadoFolha::liquido)).orElseThrow();
        return new ResumoFolha(total, maior, menor);
    }
}
