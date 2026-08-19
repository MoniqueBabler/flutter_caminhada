import 'package:flutter/material.dart';
import 'modal_caminhada.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> caminhadas = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getString('caminhadas');
    if (dados != null) {
      setState(
        () => caminhadas = List<Map<String, dynamic>>.from(json.decode(dados)),
      );
    }
  }

  Future<void> _salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('caminhadas', json.encode(caminhadas));
  }

  void _adicionarCaminhada(Map<String, dynamic> nova) {
    setState(() {
      caminhadas.add(nova);
    });
    _salvarDados();
  }

  void _excluirCaminhada(int index) {
    setState(() {
      caminhadas.removeAt(index);
    });
    _salvarDados();
  }

  double _calcularCalorias(double peso, double distancia) {
    return 0.7 * peso * distancia;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Caminhadas x Calorias')),
      body: caminhadas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma caminhada registrada',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: caminhadas.length,
              itemBuilder: (context, index) {
                final c = caminhadas[index];
                final calorias = _calcularCalorias(
                  double.tryParse(c['peso'].toString()) ?? 0,
                  double.tryParse(c['distancia'].toString()) ?? 0,
                );
                return Card(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.directions_walk,
                      color: Color(0xFFC2185B),
                    ),
                    title: Text('${c['partida']} → ${c['chegada']}'),
                    subtitle: Text(
                      'Distância: ${c['distancia']} km • Peso: ${c['peso']} kg\nGasto calórico: ${calorias.toStringAsFixed(1)} kcal',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _excluirCaminhada(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFC2185B),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => ModalCaminhada(onSalvar: _adicionarCaminhada),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}