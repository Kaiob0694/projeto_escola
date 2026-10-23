import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

/// Campo de seleção (lista suspensa) com o mesmo visual do EscolaInput.
/// Usado para escolher Professor, Disciplina, Aluno e Turma nos formulários.
class EscolaSelecao<T> extends StatelessWidget {
  const EscolaSelecao({
    super.key,
    required this.rotulo,
    required this.itens,
    required this.textoDe,
    required this.valor,
    required this.aoMudar,
    this.habilitado = true,
  });

  final String rotulo;
  final List<T> itens;

  // Diz qual texto mostrar para cada item (ex.: (aluno) => aluno.nome).
  final String Function(T item) textoDe;

  // null significa que nada foi escolhido ainda.
  final T? valor;
  final ValueChanged<T?> aoMudar;
  final bool habilitado;

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
        // O InputDecorator desenha a borda e o fundo no padrão dos campos.
        InputDecorator(
          decoration: InputDecoration(
            filled: true,
            fillColor: habilitado ? EscolaDS.campo : EscolaDS.fundo,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            enabledBorder: _borda(EscolaDS.borda),
            disabledBorder: _borda(EscolaDS.borda),
            focusedBorder: _borda(EscolaDS.azul),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: valor,
              isExpanded: true,
              hint: Text('Selecione', style: EscolaDS.corpo),
              style: EscolaDS.corpo,
              items: [
                for (final item in itens)
                  DropdownMenuItem<T>(value: item, child: Text(textoDe(item))),
              ],
              // null desabilita a lista (usado ao editar um campo fixo).
              onChanged: habilitado ? aoMudar : null,
            ),
          ),
        ),
      ],
    );
  }
}
