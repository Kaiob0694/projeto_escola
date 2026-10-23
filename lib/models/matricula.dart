import 'package:projeto_escola/models/aluno.dart';
import 'package:projeto_escola/models/turma.dart';

class Matricula {
  final int id;
  final Aluno aluno;
  final DateTime data;

  Turma turma;

  Matricula(this.id, this.aluno, this.turma, this.data);

  /// Data no formato dd/mm/aaaa.
  String get dataFormatada {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return '$dia/$mes/${data.year}';
  }
}
