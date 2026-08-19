import 'package:flutter/material.dart';

class ModalCaminhada extends StatelessWidget {
  final Function(Map<String, dynamic>) onSalvar;

  const ModalCaminhada({super.key, required this.onSalvar});

  @override
  Widget build(BuildContext context) {
    final partidaController = TextEditingController();
    final chegadaController = TextEditingController();
    final distanciaController = TextEditingController();
    final pesoController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nova Caminhada',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            _campo('Partida', partidaController),
            const SizedBox(height: 12),
            _campo('Chegada', chegadaController),
            const SizedBox(height: 12),
            _campo(
              'Distância (km)',
              distanciaController,
              tipo: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _campo(
              'Peso atual (kg)',
              pesoController,
              tipo: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSalvar({
                  'partida': partidaController.text,
                  'chegada': chegadaController.text,
                  'distancia': distanciaController.text,
                  'peso': pesoController.text,
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(
    String label,
    TextEditingController controller, {
    TextInputType tipo = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}