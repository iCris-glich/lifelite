import 'package:flutter/material.dart';
import 'package:lifelite/widgets/customButton.dart';
import 'package:lifelite/widgets/customTextField.dart';
import 'package:lifelite/widgets/imcIndicador.dart';

class CalcularPeso extends StatefulWidget {
  const CalcularPeso({super.key});

  @override
  Estado createState() => Estado();
}

class Estado extends State<CalcularPeso> {
  final TextEditingController _pesoKilos = TextEditingController();
  final TextEditingController _pesoLibras = TextEditingController();
  final TextEditingController _altura = TextEditingController();
  double? _resultadoImc;
  String? _mensajeImc;

  void limpiarTexto() {
    setState(() {
      _pesoKilos.clear();
      _pesoLibras.clear();
      _altura.clear();
    });
  }

  void calculoDeLibrasAKilos() {
    double pesoLibras = double.tryParse(_pesoLibras.text) ?? 0;
    double pesoKilos = pesoLibras * 0.45359237;
    setState(() {
      _pesoKilos.text = pesoKilos.toStringAsFixed(2);
    });
  }

  void imc() {
    double alturaMetros = double.tryParse(_altura.text) ?? 0;
    double pesoKilos = double.tryParse(_pesoKilos.text) ?? 0;
    if (alturaMetros > 0) {
      double imc = pesoKilos / (alturaMetros * alturaMetros);
      setState(() {
        _resultadoImc = double.tryParse(imc.toStringAsFixed(2));
        _mensajeImc = imc.toStringAsFixed(2);

        if (imc < 18.5) {
          _mensajeImc =
              'Tu IMC indica que tienes bajo peso. Considera consultar con un especialista.';
        } else if (imc >= 18.5 && imc < 24.9) {
          _mensajeImc =
              'Tu IMC es normal. ¡Mantén tu estilo de vida saludable!';
        } else if (imc >= 25 && imc < 29.9) {
          _mensajeImc =
              'Tu IMC indica sobrepeso. Podría ser beneficioso hacer cambios en tu estilo de vida.';
        } else {
          _mensajeImc =
              'Tu IMC indica obesidad. Te recomendamos consultar con un especialista.';
        }
      });
    } else {
      setState(() {
        _resultadoImc = null;
        _mensajeImc = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff010440),
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.05),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.blue.shade900.withOpacity(0.8),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Este es un medidor de IMC, pero ¿qué es el IMC?\nEl IMC es un indicador confiable de la gordura para la mayoría de la población adulta. Sin embargo, puede ser menos preciso en personas como culturistas o mujeres embarazadas.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _pesoLibras,
                keyboardType: TextInputType.number,
                hintText: 'Ingresa tu peso en libras',
              ),
              const Text(
                '*Ingresa tu peso en Libras si no sabes tu peso en Kilos, aquí lo convertiremos a Kilos',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 15),
              CustomButton(
                  text: 'Convertir a Kilos',
                  onPressed: () {
                    calculoDeLibrasAKilos();
                  }),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _pesoKilos,
                keyboardType: TextInputType.number,
                hintText: 'Ingresa tu peso en kilos',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _altura,
                keyboardType: TextInputType.number,
                hintText: 'Ingresa tu altura en metros',
              ),
              const SizedBox(height: 15),
              anchoPantalla > 600
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: 'Reiniciar calculadora',
                          onPressed: () {
                            limpiarTexto();
                          },
                        ),
                        CustomButton(
                          text: 'Calcula tu IMC',
                          onPressed: () {
                            imc();
                          },
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        CustomButton(
                          text: 'Reiniciar calculadora',
                          onPressed: () {
                            limpiarTexto();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: 'Calcula tu IMC',
                          onPressed: () {
                            imc();
                          },
                        ),
                      ],
                    ),
              const SizedBox(height: 15),
              if (_resultadoImc != null && _mensajeImc != null)
                Column(
                  children: [
                    Text(
                      _resultadoImc.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    ImcMedidor(imc: _resultadoImc!),
                    Text(
                      _mensajeImc!,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
