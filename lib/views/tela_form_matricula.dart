import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/aluno_controller.dart';
import 'package:projeto_escola/controllers/matricula_controller.dart';
import 'package:projeto_escola/controllers/turma_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/aluno.dart';
import 'package:projeto_escola/models/matricula.dart';
import 'package:projeto_escola/models/turma.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_pagina.dart';
import '../widgets/escola_selecao.dart';

class TelaFormMatricula extends StatefulWidget {
  const TelaFormMatricula({
    super.key,
    required this.controller,
    required this.aoSalvar,
    this.matricula,
  });

  final MatriculaController controller;
  final VoidCallback aoSalvar;
  final Matricula? matricula;

  @override
  State<TelaFormMatricula> createState() => _TelaFormMatriculaState();
}

class _TelaFormMatriculaState extends State<TelaFormMatricula> {
  Aluno? aluno;
  Turma? turma;

  bool get editando => widget.matricula != null;

  bool get podeSalvar => aluno != null && turma != null;

  @override
  void initState() {
    super.initState();
    final matricula = widget.matricula;
    if (matricula != null) {
      aluno = matricula.aluno;
      turma = matricula.turma;
    }
  }

  void salvar() {
    final alunoEscolhido = aluno;
    final turmaEscolhida = turma;
    final matricula = widget.matricula;

    if (alunoEscolhido == null || turmaEscolhida == null) {
      return;
    }

    final salvou = matricula == null
        ? widget.controller.cadastrar(alunoEscolhido, turmaEscolhida)
        : widget.controller.editar(matricula, turmaEscolhida);

    if (!salvou) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este aluno já está matriculado nessa turma.')),
      );
      return;
    }

    widget.aoSalvar();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return EscolaPagina(
      titulo: 'Matrículas',
      comMenu: false,
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editando ? 'Editar Matrícula' : 'Nova Matrícula',
              style: EscolaDS.titulo,
            ),
            const SizedBox(height: 24),
            EscolaSelecao<Aluno>(
              rotulo: 'Aluno',
              itens: AlunoController().listar(),
              textoDe: (item) => item.nome,
              valor: aluno,
              habilitado: !editando, // o aluno não muda depois de matriculado
              aoMudar: (valor) => setState(() => aluno = valor),
            ),
            const SizedBox(height: 20),
            EscolaSelecao<Turma>(
              rotulo: 'Turma',
              itens: TurmaController().listar(),
              textoDe: (item) => '${item.nome} (${item.disciplina.nome})',
              valor: turma,
              aoMudar: (valor) => setState(() => turma = valor),
            ),
            const SizedBox(height: 20),
            EscolaBotao(
              texto: editando ? 'Salvar alterações' : 'Matricular',
              aoPressionar: podeSalvar ? salvar : null,
            ),
          ],
        ),
      ),
    );
  }
}
