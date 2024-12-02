import 'package:flutter/material.dart';

class EstrenosListItem extends StatefulWidget {
  const EstrenosListItem({super.key});

  @override
  State<EstrenosListItem> createState() => _EstrenosListItemState();
}

class _EstrenosListItemState extends State<EstrenosListItem> {
  late bool isFavorite;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // aca agarras los argumentos que vienen al navegar a esta pantalla y verificas si la peli es favorita
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isFavorite = args['favorite'];
  }

  void toggleFavorite(bool value) {
    // esto cambia el estado de favorito de la peli
    setState(() {
      isFavorite = value;
    });
  }

  void saveChanges(BuildContext context) {
    // esto guarda los cambios y vuelve a la pantalla anterior devolviendo si es favorita
    Navigator.pop(context, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    // aca obtenes de nuevo los argumentos enviados con detalles de la peli
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(args['title']), // el titulo es el nombre de la peli o serie
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // icono para volver atras
          onPressed: () {
            Navigator.pop(context, null); // si volves sin guardar no devuelve nada
          },
        ),
      ),
      body: SingleChildScrollView(
        // toda la pantalla se puede scrollear por si hay mucho contenido
        child: Column(
          children: [
            HeaderEstrenosListItem(
              // componente para mostrar el poster y el icono de favorito
              poster: args['poster'],
              isFavorite: isFavorite,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0), // separacion del contenido
              child: BodyEstrenosListItem(
                // componente con la info principal de la peli
                args: args,
                isFavorite: isFavorite,
                onFavoriteToggle: toggleFavorite, // funcion que cambia favorito
              ),
            ),
            const SizedBox(height: 20), // separador entre contenido y boton
            ElevatedButton(
              onPressed: () => saveChanges(context), // boton para guardar cambios
              child: const Text('Guardar'), // texto del boton
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderEstrenosListItem extends StatelessWidget {
  // este widget muestra el poster y un icono que indica si es favorita
  final String poster;
  final bool isFavorite;

  const HeaderEstrenosListItem({
    super.key,
    required this.poster,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // contenedor para el poster
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4, // ocupa 40% de altura
          color: const Color(0xff2d3e4f), // color base del fondo
          child: Image.asset(
            'assets/posters_estrenos/$poster.jpg', // busca la imagen del poster
            fit: BoxFit.cover, // que la imagen ocupe todo el espacio
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          // icono que cambia segun si es favorita o no
          child: Icon(
            isFavorite ? Icons.star : Icons.star_border_outlined, // favorito o no
            color: isFavorite ? Colors.yellow : Colors.grey, // colores del icono
            size: 30,
          ),
        ),
      ],
    );
  }
}

class BodyEstrenosListItem extends StatelessWidget {
  // aca va toda la info de la peli y el switch para agregarla a favoritos
  final Map<String, dynamic> args;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteToggle;

  const BodyEstrenosListItem({
    super.key,
    required this.args,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // todo alineado a la izquierda
      children: [
        Text(
          'Titulo: ${args['title']}', // muestra el titulo de la peli
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // estilo de texto
        ),
        const SizedBox(height: 10), // separador
        Text(
          'Categoria: ${args['category']}', // categoria de la peli
          style: const TextStyle(fontSize: 18), // estilo normal
        ),
        const SizedBox(height: 10),
        Row(
          // fila con la clasificacion y el circulo con la puntuacion
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Clasificacion: ', style: TextStyle(fontSize: 18)),
            RatingCircle(rating: args['rating']), // componente del circulo de puntuacion
          ],
        ),
        const SizedBox(height: 20),
        Row(
          // fila con el texto y el switch de favorito
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // espacio entre texto y switch
          children: [
            const Text(
              'Agregar a favoritos:',
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              value: isFavorite, // estado del switch
              onChanged: onFavoriteToggle, // que pasa cuando se cambia el switch
            ),
          ],
        ),
      ],
    );
  }
}

class RatingCircle extends StatelessWidget {
  // widget para mostrar un circulo de color con la puntuacion
  final double rating;

  const RatingCircle({Key? key, required this.rating}) : super(key: key);

  Color _getRatingColor(double rating) {
    // devuelve un color segun la puntuacion
    if (rating < 50) return Colors.red; // mala puntuacion
    if (rating < 75) return Colors.amber; // puntuacion media
    return Colors.green; // buena puntuacion
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // contenedor para el circulo
      width: 40, // ancho del circulo
      height: 40, // alto del circulo
      decoration: BoxDecoration(
        color: _getRatingColor(rating), // color del circulo segun la puntuacion
        shape: BoxShape.circle, // forma circular
      ),
      alignment: Alignment.center, // centra el texto dentro del circulo
      child: Text(
        rating.toStringAsFixed(1), // muestra la puntuacion con un decimal
        style: const TextStyle(
          color: Colors.white, // texto blanco
          fontWeight: FontWeight.bold, // texto en negrita
        ),
      ),
    );
  }
}
