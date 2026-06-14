import 'package:flutter/material.dart';
import 'pantalla_juego.dart';

// Función principal, lo primero que se ejecuta al abrir la app.
void main() {
  runApp(const AdivinaElNumeroApp());
}

// Clase "raíz" o el esqueleto de tu aplicación.
class AdivinaElNumeroApp extends StatelessWidget {
  const AdivinaElNumeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina el Número',
      // Diseño
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      // Cargar  PantallaJuego
      home: const PantallaJuego(),
      //  Quita la etiqueta de "debuf" 
      debugShowCheckedModeBanner: false,
    );
  }
}