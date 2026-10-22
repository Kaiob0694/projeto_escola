import 'package:projeto_escola/models/aluno.dart';

class AlunoController {
  final List<Aluno> alunos = [
    Aluno(2, 'Maria Clara', '222.222.222-22', '(11)97777-2222'),
    Aluno(3, 'André Silva', '123.456.789-09', '123456789'),
    Aluno(4, 'Tainá Couto', '123.456.098-09', '(12)345678654'),
  ];

  List<Aluno> listar() {
    return alunos;
  }

  bool cadastrar(String nome, String cpf, String telefone) {
    for (final aluno in alunos) {
      if (aluno.cpf == cpf) {
        return false;
      }
    }

    int id = 1;
    if (alunos.isNotEmpty) {
      id = alunos.last.id + 1;
    }

    alunos.add(Aluno(id, nome, cpf, telefone));
    return true;
  }

  void editar(Aluno aluno, String nome, String telefone) {
    aluno.nome = nome;
    aluno.telefone = telefone;
  }

  void excluir(Aluno aluno) {
    alunos.remove(aluno);
  }
}