import 'package:flutter/material.dart';

class ImcMedidor extends StatelessWidget {
  final double imc;

  ImcMedidor({required this.imc});

  double getIndicatorPosition(double imc) {
    if (imc < 18.5) {
      return 0.15; // Bajo peso
    } else if (imc >= 18.5 && imc < 24.9) {
      return 0.5; // Normal
    } else if (imc >= 25 && imc < 29.9) {
      return 0.75; // Sobrepeso
    } else {
      return 0.9; // Obesidad
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Tu IMC',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 300,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Colors.blue, // Bajo peso
                    Colors.green, // Normal
                    Colors.yellow, // Sobrepeso
                    Colors.red, // Obesidad
                  ],
                  stops: [0.15, 0.5, 0.75, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 300 * getIndicatorPosition(imc) - 10,
              child: Icon(
                Icons.arrow_drop_up,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          imc < 18.5
              ? 'Bajo peso'
              : imc >= 18.5 && imc < 24.9
                  ? 'Normal'
                  : imc >= 25 && imc < 29.9
                      ? 'Sobrepeso'
                      : 'Obesidad',
          style: TextStyle(
            color: imc < 18.5
                ? Colors.blue
                : imc >= 18.5 && imc < 24.9
                    ? Colors.green
                    : imc >= 25 && imc < 29.9
                        ? Colors.yellow
                        : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
