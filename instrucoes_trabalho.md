# Instruções para trabalho universitário sobre linguagens de programação
### Primeiro passo:
Leia abaixo os detalhes sobre o trabalho a ser feito (Entre aspas duplas):
"
Este trabalho prático vocês colocarão à prova a capacidade de pensar o mesmo problema sob óticas completamente diferentes: imperativa, orientada a objetos, funcional e lógica.
Os arquivos com o enunciado completo do problema e o template oficial do relatório já estão anexados.
 Objetivos do Trabalho
O propósito deste projeto não é apenas "fazer o código funcionar". O verdadeiro objetivo é a análise comparativa. Queremos entender:

    Como o gerenciamento de estado muda entre os paradigmas.
    Onde cada linguagem brilha e onde ela impõe fricção/dificuldade.
    Como a arquitetura do código reage a modificações e extensões.

 Diretrizes de Organização e Implementação
Para garantir uma entrega organizada e facilitar a correção, o repositório ou pasta do grupo deve seguir rigorosamente a estrutura abaixo:

    Organização de Pastas: Crie uma pasta exclusiva para cada paradigma (ex: imperativo/, oo/, funcional/, logico/).
    Documentação Local (README.md): Cada pasta de paradigma deve conter um arquivo markdown explicando:
    Versão do compilador/interpretador utilizada.
    Comandos exatos para compilar e executar o programa.
    Dependências externas (se houver, embora recomendemos o uso das bibliotecas padrão).
    Fidelidade ao Paradigma: Evitem "programar em C usando sintaxe de Java" ou "escrever código funcional que na verdade é imperativo disfarçado". Respeitem a filosofia de cada linguagem.

Diretrizes para a Redação do Relatório
O relatório técnico deve ser preenchido utilizando o template fornecido em anexo e deve seguir uma postura puramente acadêmica e de engenharia.

    Seção de Código: Não cole arquivos inteiros de código no relatório. Selecione apenas o núcleo do algoritmo (as funções/métodos principais de lógica e transição de dados). Códigos de leitura de arquivos ou formatação de tela devem ficar apenas no arquivo-fonte.
    Análise Qualitativa Fundamentada: Evitem respostas genéricas como "Achamos Haskell difícil". Substituam por argumentos técnicos: "O paradigma funcional impôs maior fricção na gestão do estado devido à necessidade de passar o registro imutável a cada chamada de função, o que aumentou a verbosidade em relação à abordagem imperativa".
    Métricas de Código (LOC): Contabilizem as linhas de código dedicadas estritamente à solução do problema para preencher a tabela comparativa.

Formato de Entrega e Apresentação

    Trabalho em Grupo: Conforme definido em sala. A divisão de tarefas deve ser justa, mas lembrem-se: todos devem conhecer todo o código.
    Defesa Oral (Apresentação): A avaliação contará com uma arguição individual.
"

Lido essas instruções, quero que leia o arquivo ~/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/projeto4_enunciado_folha_pagamento.docx , entenda as informações e sigas instruções contidas nele.

### Segundo passo:
A partir daqui eu quero que você crie o código de cada uma das linguagens em seus respectivos diretórios que já existem no diretório atual.
Em cada diretório é necessário existir o readme.md contendo a documentação local, como exposto nas instruções acima.

   Concluído. Li o arquivo instrucoes_trabalho.md, extraí o conteúdo do enunciado projeto4_enunciado_folha_pagamento.docx e criei as quatro implementações nos diretórios de cada paradigma.
    
    Arquivos criados:
    
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/imperativo/folha_pagamento.c
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/imperativo/README.md
    
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/oo/FolhaPagamento.java
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/oo/README.md
    
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/funcional/Main.hs
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/funcional/README.md
    
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/logico/folha_pagamento.pl
    - /home/Filipe/Documentos/General_Coding/Trabalho_Linguagens_de_Programacao/logico/README.md
    
    Também verifiquei o ambiente:
    
    - GCC instalado:
      - gcc (GCC) 16.1.1 20260430
    - Java não instalado:
      - javac: comando não encontrado
      - java: comando não encontrado
    - GHC/Haskell não instalado:
      - ghc: comando não encontrado
    - SWI-Prolog não instalado:
      - swipl: comando não encontrado
    
    A implementação em C foi compilada e executada com sucesso usando:
    
    bash
    gcc -std=c11 -Wall -Wextra -pedantic folha_pagamento.c -o folha_pagamento && ./folha_pagamento
    
    
    Saída real obtida no teste obrigatório:
    
    text
    Folha de pagamento - paradigma imperativo (C)
    Politica: valores monetarios exibidos com 2 casas decimais; calculos internos usam double.
    
    Ana      Bruto:  4500.00 | Extras:  300.00 | INSS:  630.00 | IRRF:  852.93 | Liquido:  3317.07
    Bruno    Bruto:  2200.00 | Extras:    0.00 | INSS:  198.00 | IRRF:    0.00 | Liquido:  2002.00
    Carla    Bruto:  1300.00 | Extras:   43.33 | INSS:   97.50 | IRRF:    0.00 | Liquido:  1245.83
    
    Total da folha: 6564.90
    Maior salario liquido: Ana (3317.07)
    Menor salario liquido: Carla (1245.83)
    
    
    Observação importante: segui as regras formais do enunciado, especialmente:
    
    text
    valor_hora = salario_bruto / 180
    hora extra = valor_hora × 1,5 × quantidade
    base do IRRF = bruto + extras − INSS − dedução por dependentes
    
    
    A tabela de valores esperados no .docx parece ter inconsistências com essas fórmulas. Por exemplo, para Carla, com salário bruto de 1300 e 4 horas extras:
    
    text
    valor_hora = 1300 / 180 = 7,22
    extras = 7,22 × 1,5 × 4 = 43,33
    
    
    Mas a tabela do enunciado mostra 130 de extras. Por isso, mantive todas as linguagens obedecendo às regras escritas do problema, garantindo consistência entre as quatro versões.
    
    Métricas aproximadas de LOC, contando linhas não vazias e não comentadas:
    
    text
    imperativo/folha_pagamento.c: 85 linhas
    oo/FolhaPagamento.java: 100 linhas
    funcional/Main.hs: 84 linhas
    logico/folha_pagamento.pl: 71 linhas
    
    
    Os READMEs de cada pasta incluem:
    
    - versão do compilador/interpretador disponível ou ausência dele no ambiente;
    - comandos exatos para compilar/executar;
    - dependências externas;
    - observações sobre fidelidade ao paradigma;
    - política de arredondamento.
