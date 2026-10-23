import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/professor_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/professor.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_input.dart';
import '../widgets/escola_pagina.dart';

class TelaFormProfessor extends StatefulWidget {
  const TelaFormProfessor({
    super.key,
    required this.controller,
    required this.aoSalvar,
    this.professor,
  });

  final ProfessorController controller;
  final VoidCallback aoSalvar;
  final Professor? professor;

  @override
  State<TelaFormProfessor> createState() => _TelaFormProfessorState();
}

class _TelaFormProfessorState extends State<TelaFormProfessor> {
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();

  bool get editando => widget.professor != null;

  bool get podeSalvar =>
      nomeController.text.trim().isNotEmpty &&
      cpfController.text.trim().isNotEmpty &&
      telefoneController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    final professor = widget.professor;
    if (professor != null) {
      nomeController.text = professor.nome;
      cpfController.text = professor.cpf;
      telefoneController.text = professor.telefone;
    }
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final cpf = cpfController.text.trim();
    final telefone = telefoneController.text.trim();
    final professor = widget.professor;

    if (professor == null) {
      final cadastrou = widget.controller.cadastrar(nome, cpf, telefone);
      if (!cadastrou) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Já existe um professor com esse CPF.')),
        );
        return;
      }
    } else {
      widget.controller.editar(professor, nome, telefone);
    }

    widget.aoSalvar();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EscolaPagina(
      titulo: 'Professores',
      comMenu: false,
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editando ? 'Editar Professor' : 'Cadastrar Novo Professor',
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
              rotulo: 'CPF',
              controller: cpfController,
              habilitado: !editando, // o CPF não muda depois de cadastrado
              teclado: TextInputType.number,
              aoMudar: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),
            EscolaInput(
              rotulo: 'Telefone',
              controller: telefoneController,
              teclado: TextInputType.phone,
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
