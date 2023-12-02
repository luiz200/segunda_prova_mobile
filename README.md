# segunda_prova

Segunda prova de mobile.

UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE
ESCOLA AGRÍCOLA DE JUNDIAÍ
Disciplina: Programação para Dispositivos Móveis
Professor: Taniro Rodrigues
Grupo: ______________________________________________________________________
Data: 02 de dezembro de 2023 Nota: _____ de 10,0 pontos
Segunda Avaliação
INSTRUÇÕES:
a) A avaliação é em grupo de até 2 estudantes.
b) Crie um projeto no github (ou similar) para enviar o seu código de resposta. Se necessário
adicione comentários no código para explicar ou justificar sua resposta. Recomenda-se a criação de
um repositório privado. Caso o repositório seja público o grupo assume as consequências de
qualquer cópia não autorizada de seu repositório.
c) Grave um vídeo APONTANDO no código as suas respostas. (Exemplo: a solução da questão 1
está nas linhas...., a solução da questão 2 está no arquivo....). A gravação do vídeo é obrigatória e a
correção da questão está condicionada ao conteúdo do vídeo. É necessário apresentar o aplicativo
sendo EXECUTADO. O vídeo pode ter no MÁXIMO 2 minutos.
d) Escolha o tema da sua prova através do Link abaixo. Os temas devem ser únicos entre os
estudantes. Coloque seu nome ao lado do tema que você escolheu para que os colegas saibam
quais temas estão disponíveis.
https://docs.google.com/spreadsheets/d/1W3q_dMh7P2jA91A9C32W5VyV_gAMZTaUl61p1PXDKHM
/edit?usp=sharing
e) Defina os atributos do seu tema. Cada tema deve ser especificado como uma data class com
pelo menos 6 atributos (sejam criativos(as))
e) Envie o link do vídeo (youtube ou drive) e o link do projeto no github para a atividade no
SIGAA.
f) A prova vale 10,0 e deve ser enviada até o dia 02/12/2023 às 23:59.
QUESTÕES:
1) Crie o aplicativo “segunda_prova” que deve funcionar para dispositivos Android ou iOS. Crie a
Widget TelaHome que configura um Widget MaterialApp. (0,5 ponto)
2) Defina a data class do seu tema. Lembre-se de criar pelo menos 6 atributos. Use pelo menos 2
tipos diferentes (Strings, Inteiros, Long etc.). Implemente o uso de banco de dados utilizando a
biblioteca SQFLITE. Você deve implementar métodos para: cadastrar, editar, listar todos, listar por ID.
Opcionalmente você pode implementar o banco de dados com a biblioteca Floor. (2,0 pontos).
3) Crie uma widget TelaHome e Adicione um ListView. Os dados para preencher os itens do ListView
devem ser obtidos através de uma busca no banco (listar todos). (1,5 pontos)
4) Adicione na widget TelaHome um FloatingActionButton com ícone de + que ao ser clicado deve
navegar para a widget TelaCadastro. (1,0 pontos)
5) Crie uma widget chamada TelaCadastro que possui um formulário para cadastro de registros. Os
dados do formulário (objeto da sua classe do tema escolhido) devem ser validados (não podem ser
nulos ou vazios). Adicione um botão “Cadastrar” que deve verificar se os dados são válidos e então
salvar o registro no banco de dados. Após o cadastro navegue para o TelaHome exibindo um
SnackBar que informa que o cadastro foi realizado com sucesso. (1,0 ponto)
6) Crie uma widget chamada TelaAltera que recebe como parâmetro um ID e possui um formulário.
Carregue os dados do banco através de uma busca por ID para preencher o formulário. Os dados do
formulário (objeto da sua classe do tema escolhido) devem ser validados (não podem ser nulos ou
vazios). Adicione um botão “Confirmar” que deve atualizar o registro no banco de dados. Após a
alteração navegue para o TelaHome exibindo um SnackBar que informa que a alteração foi realizada
com sucesso. (1,0 pontos)
7) Crie uma widget chamada TelaDetalhes que recebe como parâmetro um ID e possui Texts com os
dados do registro. Carregue os dados do banco através de uma busca por ID. (1,0 ponto)
8) Adicione uma widget de GestureDetector nos ListItems da TelaHome para que com um toque
simples a aplicação navegue para o TelaDetalhes e com o toque longo a aplicação navegue para o
TelaAltera. (1,0 ponto)
9) Crie uma widget chamada TelaSobre que mantem informações estáticas sobre os(as)
desenvolvedores(as) do aplicativo. Adicione aos Scaffolds do seu aplicativo uma AppBar que deve
apresentar um Icone com link de navegação para o TelaSobre. (1,0 ponto)
