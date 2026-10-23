import 'package:flutter/material.dart';
import 'package:projeto_escola/controllers/matricula_controller.dart';
import 'package:projeto_escola/core/escola_ds.dart';
import 'package:projeto_escola/models/matricula.dart';

import '../widgets/escola_botao.dart';
import '../widgets/escola_cartao.dart';
import '../widgets/escola_link.dart';
import '../widgets/escola_pagina.dart';
import '../widgets/escola_tabela.dart';
import 'tela_form_matricula.dart';

class TelaMatriculas extends StatefulWidget {
  const TelaMatriculas({super.key});

  @override
  State<TelaMatriculas> createState() => _TelaMatriculasState();
}

class _TelaMatriculasState extends State<TelaMatriculas> {
  final controller = MatriculaController();

  void abrirForm({Matricula? matricula}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaFormMatricula(
          controller: controller,
          matricula: matricula,
          aoSalvar: () => setState(() {}), // atualiza a tabela ao voltar
        ),
      ),
    );
  }

  void confirmarExclusao(Matricula matricula) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir matrícula'),
        content: Text(
          'Deseja excluir a matrícula de ${matricula.aluno.nome} '
          'na turma ${matricula.turma.nome}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              controller.excluir(matricula);
              setState(() {});
              Navigator.pop(dialogContext);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matriculas = controller.listar();

    return EscolaPagina(
      titulo: 'Matrículas',
      child: EscolaCartao(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lista de Matrículas', style: EscolaDS.titulo),
            const SizedBox(height: 16),
            EscolaBotao(
              texto: 'Nova Matrícula',
              cor: EscolaDS.verde,
              aoPressionar: () => abrirForm(),
            ),
            const SizedBox(height: 24),
            EscolaTabela(
              colunas: const ['ID', 'Aluno', 'Turma', 'Disciplina', 'Data'],
              linhas: [
                for (final matricula in matriculas)
                  [
                    '${matricula.id}',
                    matricula.aluno.nome,
                    matricula.turma.nome,
                    matricula.turma.disciplina.nome,
                    matricula.dataFormatada,
                  ],
              ],
              acoes: [
                for (final matricula in matriculas)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EscolaLink(
                        texto: 'Editar',
                        aoPressionar: () => abrirForm(matricula: matricula),
                      ),
                      EscolaLink(
                        texto: 'Excluir',
                        cor: EscolaDS.vermelho,
                        aoPressionar: () => confirmarExclusao(matricula),
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
