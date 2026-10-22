import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design System do projeto.
abstract final class EscolaDS {
  static const azul = Color(0xFF2563EB);
  static const azulEscuro = Color(0xFF1E3A8A);
  static const fundo = Color(0xFFEEF2F7);
  static const superficie = Color(0xFFFFFFFF);
  static const campo = Color(0xFFFFFFFF);
  static const texto = Color(0xFF333333);
  static const secundario = Color(0xFF555555);
  static const borda = Color(0xFFDDDDDD);
  static const desabilitado = Color(0xFFD1D5DB);
  static const textoDesabilitado = Color(0xFF6B7280);
  static const verde = Color(0xFF16A34A);
  static const vermelho = Color(0xFFDC2626);

  static const s8 = 8.0;
  static const s16 = 16.0;
  static const s24 = 24.0;

  static const raioCampo = 12.0;
  static const raioBotao = 12.0;
  static const raioCartao = 20.0;

  static BoxDecoration get cartao => BoxDecoration(
        color: superficie,
        borderRadius: BorderRadius.circular(raioCartao),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      );

  static TextStyle get corpo =>
      GoogleFonts.inter(fontSize: 16, height: 1.5, color: secundario);
  static TextStyle get rotulo => GoogleFonts.inter(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: texto,
      );
  static TextStyle get botao => GoogleFonts.inter(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get titulo => GoogleFonts.inter(
        fontSize: 26,
        height: 34 / 26,
        fontWeight: FontWeight.w700,
        color: azulEscuro,
      );
}