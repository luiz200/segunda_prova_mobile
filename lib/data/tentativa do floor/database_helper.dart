import '../app_database.dart';
import '../tarefa.dart';

import '../../main.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  late final Future<AppDatabase> _database = $FloorAppDatabase.databaseBuilder('app_database.db').build();

  Future<AppDatabase> get database async {
    return _database;
  }

  Future<void> insertTarefa(Tarefa tarefa) async {
    try {
      final db = await database;
      await db.tarefaDao.insertTarefa(tarefa);
      print('Tarefa inserida com sucesso: $tarefa');
    } catch (e) {
      print('Erro ao inserir tarefa: $e');
    }
  }

  Future<List<Tarefa>> getTarefas() async {
    try {
      final db = await database;
      final tarefas = await db.tarefaDao.findAllTarefas();
      print('Tarefas recuperadas com sucesso: $tarefas');
      return tarefas;
    } catch (e) {
      print('Erro ao recuperar tarefas: $e');
      return [];
    }
  }
}