import 'package:projeto_escola/controllers/disciplina_controller.dart';
import 'package:projeto_escola/controllers/professor_controller.dart';
import 'package:projeto_escola/models/disciplina.dart';
import 'package:projeto_escola/models/professor.dart';
import 'package:projeto_escola/models/turma.dart';

class TurmaController {
  // Instância única compartilhada com Matrículas.
  TurmaController._();
  static final TurmaController _instancia = TurmaController._();
  factory TurmaController() => _instancia;

  final List<Turma> turmas = [
    Turma(
      1,
      '1º Ano A',
      '2026',
      ProfessorController().listar()[0],
      DisciplinaController().listar()[0],
    ),
    Turma(
      2,
      '2º Ano B',
      '2026',
      ProfessorController().listar()[1],
      DisciplinaController().listar()[1],
    ),
  ];

  List<Turma> listar() {
    return turmas;
  }

  // Não pode haver duas turmas com o mesmo nome no mesmo ano
  // (ignora o próprio registro ao editar).
  bool _jaExiste(String nome, String ano, {Turma? ignorar}) {
    for (final turma in turmas) {
      if (turma != ignorar &&
          turma.nome.toLowerCase() == nome.toLowerCase() &&
          turma.ano == ano) {
        return true;
      }
    }
    return false;
  }

  bool cadastrar(
    String nome,
    String ano,
    Professor professor,
    Disciplina disciplina,
  ) {
    if (_jaExiste(nome, ano)) {
      return false;
    }

    int id = 1;
    if (turmas.isNotEmpty) {
      id = turmas.last.id + 1;
    }

    turmas.add(Turma(id, nome, ano, professor, disciplina));
    return true;
  }

  bool editar(
    Turma turma,
    String nome,
    String ano,
    Professor professor,
    Disciplina disciplina,
  ) {
    if (_jaExiste(nome, ano, ignorar: turma)) {
      return false;
    }

    turma.nome = nome;
    turma.ano = ano;
    turma.professor = professor;
    turma.disciplina = disciplina;
    return true;
  }

  void excluir(Turma turma) {
    turmas.remove(turma);
  }

  // Usados pelas telas de Professores e Disciplinas para impedir a exclusão
  // de quem ainda está vinculado a uma turma.
  bool usaProfessor(Professor professor) {
    return turmas.any((turma) => turma.professor == professor);
  }

  bool usaDisciplina(Disciplina disciplina) {
    return turmas.any((turma) => turma.disciplina == disciplina);
  }
}
