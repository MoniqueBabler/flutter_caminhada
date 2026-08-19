import 'package:flutter/material.dart';
import 'ui/splash.dart';

void main() {
  runApp(const CaminhadasApp());
}

class CaminhadasApp extends StatefulWidget {
  const CaminhadasApp({super.key});

  @override
  State<CaminhadasApp> createState() => _CaminhadasAppState();
}

class _CaminhadasAppState extends State<CaminhadasApp> {
  bool temaEscuro = false;

  void alternarTema(bool valor) {
    setState(() => temaEscuro = valor);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caminhadas',
      themeMode: temaEscuro ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SplashScreen(onTemaChange: alternarTema),
    );
  }
}