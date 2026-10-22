import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Campo de texto padrão do projeto: rótulo acima e caixa com borda
/// arredondada do Design System.
class EscolaInput extends StatelessWidget {
  const EscolaInput({
    super.key,
    required this.rotulo,
    required this.controller,
    this.teclado,
    this.ocultarTexto = false,
    this.habilitado = true,
    this.aoMudar,
  });

  // Texto exibido acima do campo.
  final String rotulo;
  final TextEditingController controller;

  // Tipo de teclado: e-mail, número, telefone etc. Null usa o teclado padrão.
  final TextInputType? teclado;

  // Esconde o texto digitado, usado em campos de senha.
  final bool ocultarTexto;

  // Quando false, o campo aparece bloqueado (ex.: CPF ao editar).
  final bool habilitado;

  // Chamado a cada alteração do texto. O ? permite não receber nada.
  final ValueChanged<String>? aoMudar;

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
        const SizedBox(height: EscolaDS.s8),
        TextField(
          controller: controller,
          keyboardType: teclado,
          obscureText: ocultarTexto,
          enabled: habilitado,
          onChanged: aoMudar,
          style: EscolaDS.rotulo,
          decoration: InputDecoration(
            filled: true,
            // Campo bloqueado fica cinza para indicar que não pode ser editado.
            fillColor: habilitado ? EscolaDS.campo : EscolaDS.desabilitado,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: EscolaDS.s16,
              vertical: 14,
            ),
            border: _borda(EscolaDS.borda),
            enabledBorder: _borda(EscolaDS.borda),
            disabledBorder: _borda(EscolaDS.borda),
            focusedBorder: _borda(EscolaDS.azul),
          ),
        ),
      ],
    );
  }
}