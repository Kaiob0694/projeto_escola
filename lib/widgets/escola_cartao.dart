import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Cartão branco com cantos arredondados e sombra, do Design System.
class EscolaCartao extends StatelessWidget {
  const EscolaCartao({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    // O Container recebe a decoração pronta e exibe qualquer widget em child.
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: EscolaDS.cartao,
      child: child,
    );
  }
}