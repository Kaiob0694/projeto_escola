import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/disciplina_controller.dart';
import 'package:projeto_escola/controllers/professor_controller.dart';
import 'package:projeto_escola/controllers/turma_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/disciplina.dart';
import 'package:projeto_escola/models/professor.dart';
import 'package:projeto_escola/models/turma.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_input.dart';
import '../widgets/escola_pagina.dart';
import '../widgets/escola_selecao.dart';

class TelaFormTurma extends StatefulWidget {
  const TelaFormTurma({
    super.key,
    required this.controller,
    required this.aoSalvar,
    this.turma,
  });

  final TurmaController controller;
  final VoidCallback aoSalvar;
  final Turma? turma;

  @override
  State<TelaFormTurma> createState() => _TelaFormTurmaState();
}

class _TelaFormTurmaState extends State<TelaFormTurma> {
  final nomeController = TextEditingController();
  final anoController = TextEditingController();

  Professor? professor;
  Disciplina? disciplina;

  bool get editando => widget.turma != null;

  bool get podeSalvar =>
      nomeController.text.trim().isNotEmpty &&
      anoController.text.trim().isNotEmpty &&
      professor != null &&
      disciplina != null;

  @override
  void initState() {
    super.initState();
    final turma = widget.turma;
    if (turma != null) {
      nomeController.text = turma.nome;
      anoController.text = turma.ano;
      professor = turma.professor;
      disciplina = turma.disciplina;
    }
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final ano = anoController.text.trim();
    final professorEscolhido = professor;
    final disciplinaEscolhida = disciplina;
    final turma = widget.turma;

    if (professorEscolhido == null || disciplinaEscolhida == null) {
      return;
    }

    final salvou = turma == null
        ? widget.controller.cadastrar(
            nome,
            ano,
            professorEscolhido,
            disciplinaEscolhida,
          )
        : widget.controller.editar(
            turma,
            nome,
            ano,
            professorEscolhido,
            disciplinaEscolhida,
          );

    if (!salvou) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Já existe uma turma com esse nome neste ano.'),
        ),
      );
      return;
    }

    widget.aoSalvar();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nomeController.dispose();
    anoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EscolaPagina(
      titulo: 'Turmas',
      comMenu: false,
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editando ? 'Editar Turma' : 'Cadastrar Nova Turma',
              style: EscolaDS.titulo,
            ),
            const SizedBox(height: 24),
            EscolaInput(
              rotulo: 'Nome',
              controller: nomeController,
              aoMudar: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),
            EscolaInput(
              rotulo: 'Ano',
              controller: anoController,
              teclado: TextInputType.number,
              aoMudar: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),
            EscolaSelecao<Professor>(
              rotulo: 'Professor',
              itens: ProfessorController().listar(),
              textoDe: (item) => item.nome,
              valor: professor,
              aoMudar: (valor) => setState(() => professor = valor),
            ),
            const SizedBox(height: 20),
            EscolaSelecao<Disciplina>(
              rotulo: 'Disciplina',
              itens: DisciplinaController().listar(),
              textoDe: (item) => item.nome,
              valor: disciplina,
              aoMudar: (valor) => setState(() => disciplina = valor),
            ),
            const SizedBox(height: 20),
            EscolaBotao(
              texto: editando ? 'Salvar alterações' : 'Cadastrar',
              aoPressionar: podeSalvar ? salvar : null,
            ),
          ],
        ),
      ),
    );
  }
}
