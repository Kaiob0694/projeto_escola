import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/disciplina_controller.dart';
import 'package:projeto_escola/controllers/turma_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/disciplina.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_link.dart';
import '../widgets/escola_pagina.dart';
import '../widgets/escola_tabela.dart';
import 'tela_form_disciplina.dart';

class TelaDisciplinas extends StatefulWidget {
  const TelaDisciplinas({super.key});

  @override
  State<TelaDisciplinas> createState() => _TelaDisciplinasState();
}

class _TelaDisciplinasState extends State<TelaDisciplinas> {
  final controller = DisciplinaController();

  void abrirForm({Disciplina? disciplina}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaFormDisciplina(
          controller: controller,
          disciplina: disciplina,
          aoSalvar: () => setState(() {}), // atualiza a tabela ao voltar
        ),
      ),
    );
  }

  void confirmarExclusao(Disciplina disciplina) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir disciplina'),
        content: Text('Deseja excluir ${disciplina.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              // Disciplina vinculada a uma turma não pode ser excluída.
              if (TurmaController().usaDisciplina(disciplina)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Esta disciplina está vinculada a uma turma e não pode ser excluída.',
                    ),
                  ),
                );
                return;
              }

              controller.excluir(disciplina);
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
    final disciplinas = controller.listar();

    return EscolaPagina(
      titulo: 'Disciplinas',
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lista de Disciplinas', style: EscolaDS.titulo),
            const SizedBox(height: 16),
            EscolaBotao(
              texto: 'Cadastrar Nova Disciplina',
              cor: EscolaDS.verde,
              aoPressionar: () => abrirForm(),
            ),
            const SizedBox(height: 24),
            EscolaTabela(
              colunas: const ['ID', 'Nome', 'Carga Horária'],
              linhas: [
                for (final disciplina in disciplinas)
                  [
                    '${disciplina.id}',
                    disciplina.nome,
                    '${disciplina.cargaHoraria}h',
                  ],
              ],
              acoes: [
                for (final disciplina in disciplinas)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EscolaLink(
                        texto: 'Editar',
                        aoPressionar: () => abrirForm(disciplina: disciplina),
                      ),
                      EscolaLink(
                        texto: 'Excluir',
                        cor: EscolaDS.vermelho,
                        aoPressionar: () => confirmarExclusao(disciplina),
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
