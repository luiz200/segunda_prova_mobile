import 'dart:async';

import 'package:floor/floor.dart';
import './tarefa.dart';
import 'package:sqflite/sqflite.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Tarefa])
abstract class AppDatabase extends FloorDatabase {
  TarefaDao get tarefaDao;
}

@dao
abstract class TarefaDao {
  @Query('SELECT * FROM Tarefa')
  Future<List<Tarefa>> findAllTarefas();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTarefa(Tarefa tarefa);
}