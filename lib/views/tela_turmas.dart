import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/matricula_controller.dart';
import 'package:projeto_escola/controllers/turma_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/turma.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_link.dart';
import '../widgets/escola_pagina.dart';
import '../widgets/escola_tabela.dart';
import 'tela_form_turma.dart';

class TelaTurmas extends StatefulWidget {
  const TelaTurmas({super.key});

  @override
  State<TelaTurmas> createState() => _TelaTurmasState();
}

class _TelaTurmasState extends State<TelaTurmas> {
  final controller = TurmaController();

  void abrirForm({Turma? turma}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaFormTurma(
          controller: controller,
          turma: turma,
          aoSalvar: () => setState(() {}), // atualiza a tabela ao voltar
        ),
      ),
    );
  }

  void confirmarExclusao(Turma turma) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir turma'),
        content: Text('Deseja excluir ${turma.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              // Turma com alunos matriculados não pode ser excluída.
              if (MatriculaController().temTurma(turma)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Esta turma possui alunos matriculados e não pode ser excluída.',
                    ),
                  ),
                );
                return;
              }

              controller.excluir(turma);
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
    final turmas = controller.listar();

    return EscolaPagina(
      titulo: 'Turmas',
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lista de Turmas', style: EscolaDS.titulo),
            const SizedBox(height: 16),
            EscolaBotao(
              texto: 'Cadastrar Nova Turma',
              cor: EscolaDS.verde,
              aoPressionar: () => abrirForm(),
            ),
            const SizedBox(height: 24),
            EscolaTabela(
              colunas: const ['ID', 'Nome', 'Ano', 'Professor', 'Disciplina'],
              linhas: [
                for (final turma in turmas)
                  [
                    '${turma.id}',
                    turma.nome,
                    turma.ano,
                    turma.professor.nome,
                    turma.disciplina.nome,
                  ],
              ],
              acoes: [
                for (final turma in turmas)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EscolaLink(
                        texto: 'Editar',
                        aoPressionar: () => abrirForm(turma: turma),
                      ),
                      EscolaLink(
                        texto: 'Excluir',
                        cor: EscolaDS.vermelho,
                        aoPressionar: () => confirmarExclusao(turma),
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
