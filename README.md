# Contact-Angle
Rotina Computacional para Análise de Ângulo de Contato de Gotas Sésseis em Diversas superfícies
O programa baseia-se na conversão binária da imagem e no preenchimento do interior da gota. Esta conversão é definida por um valor de threshold (que varia de 0 a 1) que pode ser
ajustado pelo usuário no código do programa para compensar a carência de iluminação da imagem, sendo valores próximos à zero para fotos mais escuras e próximas a 1 para fotos
mais claras. O valor médio de 0,5 foi estipulado como padrão do programa.
Em seguida, é realizado o reconhecimento dos pixels que representam o contorno entre a região líquida e gasosa de maneira digital. Os dois pontos triplos são indicados por meio de
uma entrada fornecida pelo usuário com o cursor do mouse e determinam a reta que representa numericamente o substrato. Por fim, um método de integração é aplicado nos pontos
obtidos gerando um ajuste de curva polinomial e o ângulo de contato é determinado.
A rotina computacional do pós-processamento das imagens engloba as seguintes etapas:
1. Aquisição da imagem;
2. Transformação da imagem para monocromática, para permitir a fácil identificação de pixels;
3. Remoção dos pontos escuros de dentro do contorno da gota. Esse fenômeno geralmente ocorre com gotejamento de nanofluidos ou gotas com valores baixos de ângulo de contato, acarretando em sombreamento na parte interna que o software interpreta como sendo um vazio levando a erros na medida;
4. Preenchimento, na cor vermelha, de todo o volume do corpo da gota de modo a serem evidentes para o usuário quais pontos de contato triplo escolher;
5. Determinação dos pontos de contato triplo, criando uma linha de base; de acordo com o contorno criado pela densidade de pixels, uma curva polinomial é ajustada na borda da imagem. A linha de base é transformada em um vetor de comprimento entre os pontos deter-minados inicialmente;
6. Vetor tangente é traçado para os pontos colocados pelo usuário na linha de base e o ângulo formado entre o vetor e a linha de base representa o ângulo de contato da gota séssil.

Linguagens Utilizada: C, OCtave

**CITAR**: CUNHA, A. P. ; CARDOSO, E. M. ; PASCHOAL, M. F. A. . Rotina Computacional para Análise de Ângulo de Contato de Gotas Sésseis em Diversas Superfícies. Ano 2020. Registro BR512020000555-1 em INPI – Instituto Nacional da Propriedade Industrial.
