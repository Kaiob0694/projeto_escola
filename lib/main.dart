import 'package:flutter/material.dart';
import 'package:projeto_escola/core/escola_ds.dart';

import 'views/tela_login.dart';

void main() => runApp(const EscolaApp());

class EscolaApp extends StatelessWidget {
  const EscolaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Escola',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: EscolaDS.azul),
      ),
      home: const TelaLogin(),
    );
  }
}