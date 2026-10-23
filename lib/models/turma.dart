import 'package:projeto_escola/models/disciplina.dart';
import 'package:projeto_escola/models/professor.dart';

class Turma {
  final int id;

  String nome;
  String ano;
  Professor professor;
  Disciplina disciplina;

  Turma(this.id, this.nome, this.ano, this.professor, this.disciplina);
}
