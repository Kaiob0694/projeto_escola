import 'package:projeto_escola/controllers/aluno_controller.dart';
import 'package:projeto_escola/controllers/turma_controller.dart';
import 'package:projeto_escola/models/aluno.dart';
import 'package:projeto_escola/models/matricula.dart';
import 'package:projeto_escola/models/turma.dart';

class MatriculaController {
  MatriculaController._();
  static final MatriculaController _instancia = MatriculaController._();
  factory MatriculaController() => _instancia;

  final List<Matricula> matriculas = [
    Matricula(
      1,
      AlunoController().listar()[0],
      TurmaController().listar()[0],
      DateTime(2026, 2, 2),
    ),
    Matricula(
      2,
      AlunoController().listar()[1],
      TurmaController().listar()[0],
      DateTime(2026, 2, 2),
    ),
    Matricula(
      3,
      AlunoController().listar()[2],
      TurmaController().listar()[1],
      DateTime(2026, 2, 3),
    ),
  ];

  List<Matricula> listar() {
    return matriculas;
  }

  // Um aluno não pode ser matriculado duas vezes na mesma turma
  // (ignora o próprio registro ao editar).
  bool _jaMatriculado(Aluno aluno, Turma turma, {Matricula? ignorar}) {
    for (final matricula in matriculas) {
      if (matricula != ignorar &&
          matricula.aluno == aluno &&
          matricula.turma == turma) {
        return true;
      }
    }
    return false;
  }

  bool cadastrar(Aluno aluno, Turma turma) {
    if (_jaMatriculado(aluno, turma)) {
      return false;
    }

    int id = 1;
    if (matriculas.isNotEmpty) {
      id = matriculas.last.id + 1;
    }

    matriculas.add(Matricula(id, aluno, turma, DateTime.now()));
    return true;
  }

  // O aluno não muda depois da matrícula; só a turma pode ser trocada.
  bool editar(Matricula matricula, Turma turma) {
    if (_jaMatriculado(matricula.aluno, turma, ignorar: matricula)) {
      return false;
    }

    matricula.turma = turma;
    return true;
  }

  void excluir(Matricula matricula) {
    matriculas.remove(matricula);
  }

  // Usados pelas telas de Alunos e Turmas.
  void removerPorAluno(Aluno aluno) {
    matriculas.removeWhere((matricula) => matricula.aluno == aluno);
  }

  bool temTurma(Turma turma) {
    return matriculas.any((matricula) => matricula.turma == turma);
  }
}
