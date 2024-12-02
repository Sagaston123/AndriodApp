import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PELÍCULAS Y SERIES',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: isDarkMode 
                ? Colors.white // Letras blancas en dark mode
                : Colors.black, // Letras negras en light mode
            letterSpacing: 2.0,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
        backgroundColor: isDarkMode 
            ? Colors.black // Header negro en dark mode
            : Colors.white, // Header blanco en light mode
        elevation: 10,
      ),
      drawer: DrawerMenu(),
      body: Stack(
        children: [
          // Fondo con difuminado
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  isDarkMode 
                      ? Colors.black.withOpacity(0.5) // Difuminado oscuro en dark mode
                      : Colors.white.withOpacity(0.9), // Difuminado claro en light mode
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Contenido
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.movie,
                  size: 100,
                  color: isDarkMode 
                      ? Colors.amber // Icono amarillo en dark mode
                      : Colors.white, // Icono blanco en light mode
                ),
                const SizedBox(height: 20),
                Text(
                  'BIENVENIDO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Letras blancas en ambos modos
                    fontFamily: 'OpenSans',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'EXPLORA TUS ACTORES, PELÍCULAS Y SERIES FAVORITAS, SIN PERDERTE DE NINGÚN ESTRENO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.7), // Letras blancas semi-transparentes
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
