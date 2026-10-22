import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/aluno_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/aluno.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_input.dart';
import '../widgets/escola_pagina.dart';

class TelaFormAluno extends StatefulWidget {
  const TelaFormAluno({
    super.key,
    required this.controller,
    required this.aoSalvar,
    this.aluno,
  });

  final AlunoController controller;
  final VoidCallback aoSalvar;
  final Aluno? aluno;

  @override
  State<TelaFormAluno> createState() => _TelaFormAlunoState();
}

class _TelaFormAlunoState extends State<TelaFormAluno> {
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();

  bool get editando => widget.aluno != null;

  bool get podeSalvar =>
      nomeController.text.trim().isNotEmpty &&
      cpfController.text.trim().isNotEmpty &&
      telefoneController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    final aluno = widget.aluno;
    if (aluno != null) {
      nomeController.text = aluno.nome;
      cpfController.text = aluno.cpf;
      telefoneController.text = aluno.telefone;
    }
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final cpf = cpfController.text.trim();
    final telefone = telefoneController.text.trim();
    final aluno = widget.aluno;

    if (aluno == null) {
      final cadastrou = widget.controller.cadastrar(nome, cpf, telefone);
      if (!cadastrou) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Já existe um aluno com esse CPF.')),
        );
        return;
      }
    } else {
      widget.controller.editar(aluno, nome, telefone);
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
      titulo: 'Alunos',
      comMenu: false,
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editando ? 'Editar Aluno' : 'Cadastrar Novo Aluno',
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