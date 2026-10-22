import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Cartão branco com cantos arredondados e sombra suave do Design System.
/// Usado como contêiner de conteúdo em todas as telas.
class EscolaCartao extends StatelessWidget {
  const EscolaCartao({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(EscolaDS.s16),
  });

  // Conteúdo que será exibido dentro do cartão.
  final Widget child;

  // Espaço interno entre a borda do cartão e o conteúdo.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ocupa toda a largura disponível, como os cartões das telas.
      width: double.infinity,
      padding: padding,
      decoration: EscolaDS.cartao,
      child: child,
    );
  }
}