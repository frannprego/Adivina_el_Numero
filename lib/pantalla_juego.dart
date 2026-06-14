import 'package:flutter/material.dart';
import 'dart:math';

// Creamos pantalla juegos. "Stateful" su estado cambia
class PantallaJuego extends StatefulWidget {
  const PantallaJuego({super.key});

  @override
  State<PantallaJuego> createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  // Lee lo que el usuario escribe en la caja de texto
  final TextEditingController _controlador = TextEditingController();

  // Variables
  int _numeroSecreto = 0; 
  String _mensaje = 'Escribe un número del 1 al 100'; 
  bool _haAcertado = false; 

  //  Iniciar pantalla
  @override
  void initState() {
    super.initState();
    _iniciarJuego(); // 
  }

  // Función para resetear el juego y generar un número nuevo
  void _iniciarJuego() {
    setState(() {
      // Genera un número aleatorio entre 1 y 100
      _numeroSecreto = Random().nextInt(100) + 1;
      _mensaje = 'Escribe un número del 1 al 100';
      _haAcertado = false;
      _controlador.clear(); 
    });
  }

  // Funcion para comporbar el numemero
  void _comprobarNumero() {
    // Convertir texto en numero
    int? numeroIntroducido = int.tryParse(_controlador.text);

    
    if (numeroIntroducido == null || numeroIntroducido < 1 || numeroIntroducido > 100) {
      setState(() {
        _mensaje = 'Por favor, introduce un número válido (1-100).';
      });
      return; 
    }

    // Actualizamos la pantalla 
    setState(() {
      if (numeroIntroducido == _numeroSecreto) {
        _mensaje = '¡Has acertado! El número era $_numeroSecreto.';
        _haAcertado = true; 
      } else if (numeroIntroducido < _numeroSecreto) {
        _mensaje = 'El número secreto es MAYOR. ¡Sigue intentándolo!';
      } else {
        _mensaje = 'El número secreto es MENOR. ¡Sigue intentándolo!';
      }
      _controlador.clear(); // Vaciamos 
    });
  }

  // Interfaz gráfica
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el Número', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Márgenes lados
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra todo 
          children: [
            // Texto que da las pistas
            Text(
              _mensaje,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _haAcertado ? Colors.green : Colors.black87,
              ),
            ),
            const SizedBox(height: 30), // Espacio en blanco

            // Caja para escribir los números
            TextField(
              controller: _controlador,
              keyboardType: TextInputType.number, // Abre el teclado de números
              enabled: !_haAcertado, // Si ya ganaste, bloquea la caja
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tu número',
                hintText: 'Ej: 42',
              ),
            ),
            const SizedBox(height: 20), // Espacio en blanco

            // Si no has acertado, dibuja el botón de "Comprobar"
            if (!_haAcertado)
              ElevatedButton(
                onPressed: _comprobarNumero,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Comprobar', style: TextStyle(fontSize: 18)),
              ),

            // Si aciertas, dibuja el botón verde de "Volver a jugar"
            if (_haAcertado)
              ElevatedButton(
                onPressed: _iniciarJuego,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Volver a jugar', style: TextStyle(fontSize: 18)),
              ),
          ],
        ),
      ),
    );
  }
}