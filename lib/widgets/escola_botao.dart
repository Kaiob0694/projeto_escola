import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Botão padrão do projeto, com cores, tamanho e raio do Design System.
class EscolaBotao extends StatelessWidget {
  const EscolaBotao({
    super.key,
    required this.texto,
    this.aoPressionar,
    this.cor = EscolaDS.azul,
  });

  final String texto;

  // O ? permite receber null. No ElevatedButton, null deixa o botão desabilitado.
  final VoidCallback? aoPressionar;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: aoPressionar,
      style: ElevatedButton.styleFrom(
        // Define a aparência dos estados habilitado e desabilitado.
        backgroundColor: cor,
        foregroundColor: EscolaDS.superficie,
        disabledBackgroundColor: EscolaDS.desabilitado,
        disabledForegroundColor: EscolaDS.textoDesabilitado,
        textStyle: EscolaDS.botao,
        minimumSize: const Size(88, 48),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EscolaDS.raioBotao),
        ),
      ),
      child: Text(texto),
    );
  }
}