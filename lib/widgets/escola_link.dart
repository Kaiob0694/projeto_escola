import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Ação em texto, como "Editar" e "Excluir" nas linhas da tabela.
class EscolaLink extends StatelessWidget {
  const EscolaLink({
    super.key,
    required this.texto,
    required this.aoPressionar,
    this.cor = EscolaDS.azul,
  });

  final String texto;
  final VoidCallback aoPressionar;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    // TextButton é adequado para ações secundárias que parecem links.
    return TextButton(
      onPressed: aoPressionar,
      style: TextButton.styleFrom(
        foregroundColor: cor,
        textStyle: EscolaDS.botao.copyWith(fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        minimumSize: const Size(0, 36),
      ),
      child: Text(texto),
    );
  }
}