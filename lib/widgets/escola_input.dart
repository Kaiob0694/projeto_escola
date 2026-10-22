import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Campo de texto reutilizável com rótulo e estados padronizados.
class EscolaInput extends StatelessWidget {
  const EscolaInput({
    super.key,
    required this.rotulo,
    required this.controller,
    this.ocultarTexto = false,
    this.habilitado = true,
    this.teclado = TextInputType.text,
    this.aoMudar,
  });

  final String rotulo;
  final TextEditingController controller;
  final bool ocultarTexto;
  final bool habilitado;
  final TextInputType teclado;
  final ValueChanged<String>? aoMudar;

  // Método auxiliar para criar todas as bordas com o mesmo formato.
  OutlineInputBorder _borda(Color cor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(EscolaDS.raioCampo),
      borderSide: BorderSide(color: cor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rotulo, style: EscolaDS.rotulo),
        const SizedBox(height: 5),
        TextField(
          // O controller permite ler e alterar o conteúdo do campo.
          controller: controller,
          // Usado em senhas para substituir os caracteres por pontos.
          obscureText: ocultarTexto,
          enabled: habilitado,
          keyboardType: teclado,
          onChanged: aoMudar,
          style: EscolaDS.corpo,
          cursorColor: EscolaDS.azul,
          decoration: InputDecoration(
            filled: true,
            fillColor: habilitado ? EscolaDS.campo : EscolaDS.fundo,
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            enabledBorder: _borda(EscolaDS.borda),
            disabledBorder: _borda(EscolaDS.borda),
            // A borda azul informa visualmente que o campo está com foco.
            focusedBorder: _borda(EscolaDS.azul),
          ),
        ),
      ],
    );
  }
}