import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

import '../views/tela_alunos.dart';
import '../views/tela_home.dart';
import '../views/tela_login.dart';
import 'escola_rodape.dart';

/// Estrutura comum das telas internas: barra azul, menu lateral e rodapé.
/// Com comMenu: false a barra mostra a seta de voltar no lugar do menu.
class EscolaPagina extends StatelessWidget {
  const EscolaPagina({
    super.key,
    required this.titulo,
    required this.child,
    this.comMenu = true,
  });

  final String titulo;
  // child é o conteúdo específico que cada tela coloca dentro da estrutura.
  final Widget child;
  // Permite esconder o menu em telas secundárias, como o formulário.
  final bool comMenu;

  // Itens do menu que ainda não têm tela.
  static const _outros = [
    'Professores',
    'Turmas',
    'Disciplinas',
    'Matrículas',
    'Consultas',
  ];

  void _ir(BuildContext context, Widget tela) {
    // Substitui a tela atual para não acumular páginas ao usar o menu.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => tela),
    );
  }

  Widget _menu(BuildContext context) {
    // Drawer cria o menu lateral aberto pelo ícone da AppBar.
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: EscolaDS.azul),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Direção Demonstração (Direcao)',
                style: TextStyle(color: EscolaDS.superficie),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () => _ir(context, const TelaHome()),
          ),
          ListTile(
            title: const Text('Alunos'),
            onTap: () => _ir(context, const TelaAlunos()),
          ),
          for (final item in _outros)
            ListTile(title: Text(item), onTap: () => Navigator.pop(context)),
          ListTile(
            title: const Text('Sair'),
            onTap: () => _ir(context, const TelaLogin()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold organiza as regiões principais de uma tela Material.
      backgroundColor: EscolaDS.fundo,
      appBar: AppBar(
        backgroundColor: EscolaDS.azul,
        foregroundColor: EscolaDS.superficie,
        title: Text(titulo),
      ),
      // Quando drawer é null, a AppBar mostra automaticamente a seta de voltar.
      drawer: comMenu ? _menu(context) : null,
      bottomNavigationBar: const EscolaRodape(),
      body: SingleChildScrollView(
        // Permite rolar o conteúdo quando ele ultrapassa a altura da tela.
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}