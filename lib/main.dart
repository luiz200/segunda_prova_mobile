import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Prioridade { Baixa, Alta }

// 2) Defina a data class do seu tema. Lembre-se de criar pelo menos 6 atributos. Use pelo menos 2
// tipos diferentes (Strings, Inteiros, Long etc.). Implemente o uso de banco de dados utilizando a
// biblioteca SQFLITE. Você deve implementar métodos para: cadastrar, editar, listar todos, listar por ID.
// Opcionalmente você pode implementar o banco de dados com a biblioteca Floor. (2,0 pontos).
class Tarefa {
  static int _idCounter = 0;

  final int id;
  final String titulo;
  final String descricao;
  final DateTime dataCriacao;
  final DateTime dataValidade;
  final Prioridade prioridade;
  final String responsavelExecucao;

  Tarefa({
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
    required this.dataValidade,
    required this.prioridade,
    required this.responsavelExecucao,
  }) : id = _idCounter++;

  Tarefa.withId({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
    required this.dataValidade,
    required this.prioridade,
    required this.responsavelExecucao,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TAREFAS'),
    );
  }
}
// 1) Crie o aplicativo “segunda_prova” que deve funcionar para dispositivos Android ou iOS. Crie a
// Widget TelaHome que configura um Widget MaterialApp. (0,5 ponto)

//TELA HOME
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Tarefa> tarefas = [];

  void _adicionarTarefa() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _AdicionarTarefaDialog(adicionarTarefa: _adicionarNovaTarefa);
      },
    );
  }

  void _adicionarNovaTarefa(Tarefa novaTarefa) {
    setState(() {
      tarefas.add(novaTarefa);
    });
    Navigator.of(context).pop();

    _exibirSnackBar('Tarefa adicionada com sucesso!');
  }

  void _exibirSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // 6) Crie uma widget chamada TelaAltera que recebe como parâmetro um ID e possui um formulário.
  // Carregue os dados do banco através de uma busca por ID para preencher o formulário. Os dados do
  // formulário (objeto da sua classe do tema escolhido) devem ser validados (não podem ser nulos ou
  // vazios). Adicione um botão “Confirmar” que deve atualizar o registro no banco de dados. Após a
  // alteração navegue para o TelaHome exibindo um SnackBar que informa que a alteração foi realizada
  // com sucesso. (1,0 pontos)
  void _editarTarefa(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TelaAltera(id: id),
      ),
    );
  }

  void _verTelaSobre() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TelaSobre(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _verTelaSobre,
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Tarefas:'),
            Expanded(
                // 3) Crie uma widget TelaHome e Adicione um ListView. Os dados para preencher os itens do ListView
                // devem ser obtidos através de uma busca no banco (listar todos). (1,5 pontos)
                child: ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (context, index) {
                    return CartaoTarefa(
                      id: tarefas[index].id,
                      titulo: tarefas[index].titulo,
                      descricao: tarefas[index].descricao,
                      dataCriacao: tarefas[index].dataCriacao,
                      dataValidade: tarefas[index].dataValidade,
                      prioridade: tarefas[index].prioridade,
                      responsavelExecucao: tarefas[index].responsavelExecucao,
                      onEditar: () => _editarTarefa(tarefas[index].id),
                    );
                  },
                ),
            ),
          ],
        ),
      ),
        // 4) Adicione na widget TelaHome um FloatingActionButton com ícone de + que ao ser clicado deve
        // navegar para a widget TelaCadastro. (1,0 pontos)
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarTarefa,
        tooltip: 'Adicionar tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Crie uma widget chamada TelaCadastro que possui um formulário para cadastro de registros. Os
// dados do formulário (objeto da sua classe do tema escolhido) devem ser validados (não podem ser
// nulos ou vazios). Adicione um botão “Cadastrar” que deve verificar se os dados são válidos e então
// salvar o registro no banco de dados. Após o cadastro navegue para o TelaHome exibindo um
// SnackBar que informa que o cadastro foi realizado com sucesso. (1,0 ponto)

class _AdicionarTarefaDialog extends StatefulWidget {
  final Function(Tarefa) adicionarTarefa;

  const _AdicionarTarefaDialog({Key? key, required this.adicionarTarefa})
      : super(key: key);

  @override
  __AdicionarTarefaDialogState createState() => __AdicionarTarefaDialogState();
}

class __AdicionarTarefaDialogState extends State<_AdicionarTarefaDialog> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController dataCriacaoController = TextEditingController();
  TextEditingController dataValidadeController = TextEditingController();
  TextEditingController responsavelController = TextEditingController();
  Prioridade? prioridadeSelecionada;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar nova tarefa'),
      content: Column(
        children: [
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: dataCriacaoController,
            decoration: const InputDecoration(labelText: 'Data de criação (dd/MM/yy)'),
          ),
          TextField(
            controller: dataValidadeController,
            decoration: const InputDecoration(labelText: 'Validade (dd/MM/yy)'),
          ),
          TextField(
            controller: responsavelController,
            decoration: const InputDecoration(labelText: 'Responsável'),
          ),
          DropdownButton<Prioridade>(
            value: prioridadeSelecionada,
            onChanged: (Prioridade? newValue) {
              setState(() {
                prioridadeSelecionada = newValue;
              });
            },
            items: Prioridade.values.map((Prioridade prioridade) {
              return DropdownMenuItem<Prioridade>(
                value: prioridade,
                child: Text(prioridade.toString().split('.').last),
              );
            }).toList(),
            hint: const Text('Selecione a Prioridade'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (prioridadeSelecionada == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Selecione a prioridade')),
              );
              return;
            }

            Tarefa novaTarefa = Tarefa(
              titulo: tituloController.text,
              descricao: descricaoController.text,
              dataCriacao: DateFormat('dd/MM/yy').parse(dataCriacaoController.text),
              dataValidade: DateFormat('dd/MM/yy').parse(dataValidadeController.text),
              prioridade: prioridadeSelecionada!,
              responsavelExecucao: responsavelController.text,
            );

            widget.adicionarTarefa(novaTarefa);
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
//DETALHES
class CartaoTarefa extends StatelessWidget {
  final int id;
  final String titulo;
  final String descricao;
  final DateTime dataCriacao;
  final DateTime dataValidade;
  final Prioridade prioridade;
  final String responsavelExecucao;
  final VoidCallback onEditar;

  const CartaoTarefa({
    Key? key,
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
    required this.dataValidade,
    required this.prioridade,
    required this.responsavelExecucao,
    required this.onEditar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //8) Adicione uma widget de GestureDetector nos ListItems da TelaHome para que com um toque
    //simples a aplicação navegue para o TelaDetalhes e com o toque longo a aplicação navegue para o
    //TelaAltera
    return GestureDetector(
      onTap: () {
        _verTelaDetalhes(context);
      },
      onLongPress: () {
        _verTelaAltera(context);
      },
      child: Card(
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ID: $id',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: onEditar,
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              Text(
                'Título: $titulo',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Descrição: $descricao',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Data de criação: ${DateFormat('dd/MM/yy').format(dataCriacao.toLocal())}',
              ),
              Text(
                'Validade: ${DateFormat('dd/MM/yy').format(dataValidade.toLocal())}',
              ),
              Text(
                'Prioridade: ${prioridade.toString().split('.').last}',
              ),
              Text(
                'Responsável: $responsavelExecucao',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verTelaDetalhes(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TelaDetalhes(id: id),
      ),
    );
  }

  void _verTelaAltera(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TelaAltera(id: id),
      ),
    );
  }
}

class TelaAltera extends StatefulWidget {
  final int id;

  const TelaAltera({Key? key, required this.id}) : super(key: key);

  @override
  _TelaAlteraState createState() => _TelaAlteraState();
}

class _TelaAlteraState extends State<TelaAltera> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController dataCriacaoController = TextEditingController();
  TextEditingController dataValidadeController = TextEditingController();
  TextEditingController responsavelController = TextEditingController();
  Prioridade? prioridadeSelecionada;

  @override
  void initState() {
    super.initState();
    Tarefa tarefa = obterTarefaPorId(widget.id);
    tituloController.text = tarefa.titulo;
    descricaoController.text = tarefa.descricao;
    dataCriacaoController.text = DateFormat('dd/MM/yy').format(tarefa.dataCriacao);
    dataValidadeController.text = DateFormat('dd/MM/yy').format(tarefa.dataValidade);
    responsavelController.text = tarefa.responsavelExecucao;
    prioridadeSelecionada = tarefa.prioridade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa #${widget.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: dataCriacaoController,
              decoration: const InputDecoration(labelText: 'Data de criação (dd/MM/yy)'),
            ),
            TextField(
              controller: dataValidadeController,
              decoration: const InputDecoration(labelText: 'Validade (dd/MM/yy)'),
            ),
            TextField(
              controller: responsavelController,
              decoration: const InputDecoration(labelText: 'Responsável'),
            ),
            DropdownButton<Prioridade>(
              value: prioridadeSelecionada,
              onChanged: (Prioridade? newValue) {
                setState(() {
                  prioridadeSelecionada = newValue;
                });
              },
              items: Prioridade.values.map((Prioridade prioridade) {
                return DropdownMenuItem<Prioridade>(
                  value: prioridade,
                  child: Text(prioridade.toString().split('.').last),
                );
              }).toList(),
              hint: const Text('Selecione a Prioridade'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarAlteracoes,
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarAlteracoes() {
    Navigator.of(context).pop();
  }

  Tarefa obterTarefaPorId(int id) {
    return Tarefa.withId(
      id: id,
      titulo: 'Tarefa $id',
      descricao: 'Descrição da Tarefa $id',
      dataCriacao: DateTime.now(),
      dataValidade: DateTime.now(),
      prioridade: Prioridade.Alta,
      responsavelExecucao: 'Responsável $id',
    );
  }
}

// 7) Crie uma widget chamada TelaDetalhes que recebe como parâmetro um ID e possui Texts com os
//dados do registro
class TelaDetalhes extends StatelessWidget {
  final int id;

  const TelaDetalhes({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = obterTarefaPorId(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              // Adicione a navegação para a tela de detalhes aqui
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TelaDetalhes(id: id),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetalhe('ID', tarefa.id.toString()),
            _buildDetalhe('Título', tarefa.titulo),
            _buildDetalhe('Descrição', tarefa.descricao),
            _buildDetalhe('Data de Criação', DateFormat('dd/MM/yy').format(tarefa.dataCriacao.toLocal())),
            _buildDetalhe('Data de Validade', DateFormat('dd/MM/yy').format(tarefa.dataValidade.toLocal())),
            _buildDetalhe('Prioridade', tarefa.prioridade.toString().split('.').last),
            _buildDetalhe('Responsável', tarefa.responsavelExecucao),
          ],
        ),
      ),
    );
  }

  Widget _buildDetalhe(String label, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          valor,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Tarefa obterTarefaPorId(int id) {
    return Tarefa.withId(
      id: id,
      titulo: 'Tarefa $id',
      descricao: 'Descrição da Tarefa $id',
      dataCriacao: DateTime.now(),
      dataValidade: DateTime.now(),
      prioridade: Prioridade.Alta,
      responsavelExecucao: 'Responsável $id',
    );
  }

}

//09 -Crie uma widget chamada TelaSobre que mantem informações estáticas sobre os(as)
//desenvolvedores(as) do aplicativo. Adicione aos Scaffolds do seu aplicativo uma AppBar que deve
//apresentar um Icone com link de navegação para o TelaSobre
class TelaSobre extends StatelessWidget {
  const TelaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Desenvolvedores:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDesenvolvedor(nome: 'Luiz Felipe Henrique de Souza', papel: 'Bombril'),
            _buildDesenvolvedor(nome: 'Ramonie Martins de Lima', papel: 'Bombril'),
          ],
        ),
      ),
    );
  }

  Widget _buildDesenvolvedor({required String nome, required String papel})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nome: $nome',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'Função: $papel',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}


void main() {
  runApp(const MyApp());
}