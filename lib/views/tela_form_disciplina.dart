import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/disciplina_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/disciplina.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_input.dart';
import '../widgets/escola_pagina.dart';

class TelaFormDisciplina extends StatefulWidget {
  const TelaFormDisciplina({
    super.key,
    required this.controller,
    required this.aoSalvar,
    this.disciplina,
  });

  final DisciplinaController controller;
  final VoidCallback aoSalvar;
  final Disciplina? disciplina;

  @override
  State<TelaFormDisciplina> createState() => _TelaFormDisciplinaState();
}

class _TelaFormDisciplinaState extends State<TelaFormDisciplina> {
  final nomeController = TextEditingController();
  final cargaController = TextEditingController();

  bool get editando => widget.disciplina != null;

  // A carga horária precisa ser um número inteiro maior que zero.
  int? get cargaHoraria {
    final valor = int.tryParse(cargaController.text.trim());
    if (valor == null || valor <= 0) {
      return null;
    }
    return valor;
  }

  bool get podeSalvar =>
      nomeController.text.trim().isNotEmpty && cargaHoraria != null;

  @override
  void initState() {
    super.initState();
    final disciplina = widget.disciplina;
    if (disciplina != null) {
      nomeController.text = disciplina.nome;
      cargaController.text = '${disciplina.cargaHoraria}';
    }
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final carga = cargaHoraria;
    final disciplina = widget.disciplina;

    if (carga == null) {
      return;
    }

    final salvou = disciplina == null
        ? widget.controller.cadastrar(nome, carga)
        : widget.controller.editar(disciplina, nome, carga);

    if (!salvou) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Já existe uma disciplina com esse nome.')),
      );
      return;
    }

    widget.aoSalvar();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nomeController.dispose();
    cargaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EscolaPagina(
      titulo: 'Disciplinas',
      comMenu: false,
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editando ? 'Editar Disciplina' : 'Cadastrar Nova Disciplina',
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
              rotulo: 'Carga Horária (horas)',
              controller: cargaController,
              teclado: TextInputType.number,
              aoMudar: (_) => setState(() {}),
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
