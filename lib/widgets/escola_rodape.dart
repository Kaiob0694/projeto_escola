import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Faixa azul escura fixa na parte de baixo da tela.
class EscolaRodape extends StatelessWidget {
  const EscolaRodape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: EscolaDS.azulEscuro,
      // SafeArea evita que o texto fique atrás da barra inferior do celular.
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Sistema Escolar\nAplicativo mobile',
            textAlign: TextAlign.center,
            style: EscolaDS.corpo.copyWith(
              fontSize: 14,
              color: EscolaDS.superficie,
            ),
          ),
        ),
      ),
    );
  }
}