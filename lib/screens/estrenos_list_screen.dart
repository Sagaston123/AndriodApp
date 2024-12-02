import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/estrenos_mock.dart' show peliculasEstrenos;
import 'package:flutter_application_base/widgets/widgets.dart';

class CustomListScreenEstrenos extends StatefulWidget {
  const CustomListScreenEstrenos({super.key});

  @override
  State<CustomListScreenEstrenos> createState() => _CustomListScreenState();
}

class _CustomListScreenState extends State<CustomListScreenEstrenos> {
  List _auxiliarElements = []; // lista para filtrar resultados
  String _searchQuery = ''; // texto de busqueda
  bool _searchActive = false; // estado de la barra de busqueda

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // para manejar el foco en la barra de busqueda

  @override
  void initState() {
    super.initState();
    _auxiliarElements = peliculasEstrenos; // inicializa la lista con todos los estrenos
  }

  @override
  void dispose() {
    // limpia los controladores al cerrar la pantalla
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateSearch(String? query) {
    // filtra los elementos segun lo que escribis en la busqueda
    setState(() {
      _searchQuery = query ?? '';
      if (_searchQuery.isEmpty) {
        _auxiliarElements = peliculasEstrenos;
      } else {
        _auxiliarElements = peliculasEstrenos.where((element) {
          return element[1].toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            searchArea(), // barra de busqueda arriba
            listItemsArea(), // lista de estrenos abajo
          ],
        ),
      ),
    );
  }

  Expanded listItemsArea() {
    // lista de elementos que muestra las peliculas
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _auxiliarElements.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = _auxiliarElements[index]; // info de cada pelicula

          return GestureDetector(
            onTap: () async {
              // navega a los detalles y espera los cambios
              final updatedData = await Navigator.pushNamed(
                context,
                'estrenos_list_item',
                arguments: {
                  'poster': movie[0],
                  'title': movie[1],
                  'category': movie[2],
                  'rating': movie[3],
                  'favorite': movie[4],
                },
              );

              // actualiza la lista si cambiaste el estado de favorito
              if (updatedData != null) {
                setState(() {
                  _auxiliarElements[index][4] = updatedData;
                });
              }
            },
            child: MovieCard(
              // tarjeta para mostrar cada pelicula
              poster: movie[0],
              title: movie[1],
              category: movie[2],
              rating: movie[3],
              isFavorite: movie[4],
              onFavoriteToggle: () {
                setState(() {
                  // cambia el estado de favorito directo desde la tarjeta
                  _auxiliarElements[index][4] = !_auxiliarElements[index][4];
                });
              },
            ),
          );
        },
      ),
    );
  }

  AnimatedSwitcher searchArea() {
    // area que cambia entre barra de busqueda o botones
    return AnimatedSwitcher(
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      duration: const Duration(milliseconds: 300),
      child: (_searchActive)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: (value) {
                        _updateSearch(value); // busca mientras escribis
                      },
                      onFieldSubmitted: (value) {
                        _updateSearch(value); // busca al presionar enter
                      },
                      decoration: const InputDecoration(hintText: 'Buscar...'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // limpia el texto de busqueda
                      _searchController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      _updateSearch('');
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () {
                      // cierra la barra de busqueda
                      setState(() {
                        _searchActive = false;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // vuelve a la pantalla anterior
                    },
                    icon: const Icon(Icons.keyboard_arrow_left_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchActive = !_searchActive; // activa la barra de busqueda
                      });
                      _focusNode.requestFocus();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
    );
  }
}
