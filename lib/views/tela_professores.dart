import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/professor_controller.dart';
import 'package:projeto_escola/controllers/turma_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/professor.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_link.dart';
import '../widgets/escola_pagina.dart';
import '../widgets/escola_tabela.dart';
import 'tela_form_professor.dart';

class TelaProfessores extends StatefulWidget {
  const TelaProfessores({super.key});

  @override
  State<TelaProfessores> createState() => _TelaProfessoresState();
}

class _TelaProfessoresState extends State<TelaProfessores> {
  final controller = ProfessorController();

  void abrirForm({Professor? professor}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaFormProfessor(
          controller: controller,
          professor: professor,
          aoSalvar: () => setState(() {}), // atualiza a tabela ao voltar
        ),
      ),
    );
  }

  void confirmarExclusao(Professor professor) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir professor'),
        content: Text('Deseja excluir ${professor.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              // Professor vinculado a uma turma não pode ser excluído.
              if (TurmaController().usaProfessor(professor)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Este professor está vinculado a uma turma e não pode ser excluído.',
                    ),
                  ),
                );
                return;
              }

              controller.excluir(professor);
              setState(() {});
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final professores = controller.listar();

    return EscolaPagina(
      titulo: 'Professores',
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lista de Professores', style: EscolaDS.titulo),
            const SizedBox(height: 16),
            EscolaBotao(
              texto: 'Cadastrar Novo Professor',
              cor: EscolaDS.verde,
              aoPressionar: () => abrirForm(),
            ),
            const SizedBox(height: 24),
            EscolaTabela(
              colunas: const ['ID', 'Nome', 'CPF', 'Telefone'],
              linhas: [
                for (final professor in professores)
                  [
                    '${professor.id}',
                    professor.nome,
                    professor.cpf,
                    professor.telefone,
                  ],
              ],
              acoes: [
                for (final professor in professores)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EscolaLink(
                        texto: 'Editar',
                        aoPressionar: () => abrirForm(professor: professor),
                      ),
                      EscolaLink(
                        texto: 'Excluir',
                        cor: EscolaDS.vermelho,
                        aoPressionar: () => confirmarExclusao(professor),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
