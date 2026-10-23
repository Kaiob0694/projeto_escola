import 'package:projeto_escola/models/disciplina.dart';

class DisciplinaController {
  // Instância única compartilhada com Turmas.
  DisciplinaController._();
  static final DisciplinaController _instancia = DisciplinaController._();
  factory DisciplinaController() => _instancia;

  final List<Disciplina> disciplinas = [
    Disciplina(1, 'Matemática', 80),
    Disciplina(2, 'Português', 80),
    Disciplina(3, 'História', 60),
  ];

  List<Disciplina> listar() {
    return disciplinas;
  }

  // Duas disciplinas não podem ter o mesmo nome (ignora o próprio registro).
  bool _nomeEmUso(String nome, {Disciplina? ignorar}) {
    for (final disciplina in disciplinas) {
      if (disciplina != ignorar &&
          disciplina.nome.toLowerCase() == nome.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  bool cadastrar(String nome, int cargaHoraria) {
    if (_nomeEmUso(nome)) {
      return false;
    }

    int id = 1;
    if (disciplinas.isNotEmpty) {
      id = disciplinas.last.id + 1;
    }

    disciplinas.add(Disciplina(id, nome, cargaHoraria));
    return true;
  }

  bool editar(Disciplina disciplina, String nome, int cargaHoraria) {
    if (_nomeEmUso(nome, ignorar: disciplina)) {
      return false;
    }

    disciplina.nome = nome;
    disciplina.cargaHoraria = cargaHoraria;
    return true;
  }

  void excluir(Disciplina disciplina) {
    disciplinas.remove(disciplina);
  }
}
