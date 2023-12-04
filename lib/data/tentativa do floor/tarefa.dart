import 'package:floor/floor.dart';

@entity
class Tarefa {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String titulo;
  final String descricao;
  final DateTime dataCriacao;
  final DateTime dataValidade;
  final String prioridade;
  final String responsavelExecucao;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
    required this.dataValidade,
    required this.prioridade,
    required this.responsavelExecucao,
  });
}