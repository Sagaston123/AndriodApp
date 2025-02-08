import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _menuItems = [
    {'route': 'home', 'title': 'Inicio', 'icon': Icons.home},
    {'route': 'estrenos_list_screen', 'title': 'Estrenos', 'icon': Icons.movie_filter_outlined}, // Weis
    {'route': 'actores', 'title': 'Actores', 'icon': Icons.person},   // Sagasti
    {'route': 'record_list', 'title': 'Series', 'icon': Icons.tv},  // Zottele
    {'route': 'custom_list_movies_screen', 'title': 'Películas', 'icon': Icons.local_movies}, // Schroh
    {'route': 'profile', 'title': 'Perfil', 'icon': Icons.account_circle_outlined},
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const _DrawerHeader(),
          Expanded(
            child: ListView.separated(
              itemCount: _menuItems.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return ListTile(
                  leading: Icon(item['icon'], color: Colors.blueGrey),
                  title: Text(
                    item['title'],
                    style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, item['route']);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade700, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.movie, size: 50, color: Colors.amber),
          const SizedBox(height: 10),
          Text(
            "Películas y Series",
            style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "Explora tu contenido favorito",
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
