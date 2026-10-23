import 'package:projeto_escola/models/professor.dart';

class ProfessorController {
  // Instância única compartilhada com Turmas.
  ProfessorController._();
  static final ProfessorController _instancia = ProfessorController._();
  factory ProfessorController() => _instancia;

  final List<Professor> professores = [
    Professor(1, 'Carlos Mendes', '111.111.111-11', '(12)98888-1111'),
    Professor(2, 'Helena Duarte', '333.333.333-33', '(12)97777-3333'),
  ];

  List<Professor> listar() {
    return professores;
  }

  bool cadastrar(String nome, String cpf, String telefone) {
    for (final professor in professores) {
      if (professor.cpf == cpf) {
        return false;
      }
    }

    int id = 1;
    if (professores.isNotEmpty) {
      id = professores.last.id + 1;
    }

    professores.add(Professor(id, nome, cpf, telefone));
    return true;
  }

  void editar(Professor professor, String nome, String telefone) {
    professor.nome = nome;
    professor.telefone = telefone;
  }

  void excluir(Professor professor) {
    professores.remove(professor);
  }
}
