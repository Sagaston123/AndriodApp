
       
# 🎬 Proyecto de Gestión de Actores, Series y Películas

## 📌 Descripción General
Este proyecto es una aplicación desarrollada en **Flutter** que permite visualizar información sobre actores, series, películas y estrenos próximos. La app se conecta con una proyecto en **Node.js** y pide datos a una API externa "The Movie Database" (TMDB).

Para la materia de Laboratorio IV que se dicta en la Universidad Tecnologica Nacional de Bahia Blanca, se nos pidio que realizaramos un primer proyecto con Node.js que haga peticiones a una API exerta, luego con el segundo trabajo debiamos simular mediante mocks la informacion que nos traia la misma api (mediante JSONs) para realizar una aplicacion tanto web como movil. Finalmente cerramos la materia con un proyecto que integra los conceptos vistos en case y los proyectos realizados para poder hacer una aplicacion en Flutter conectada al backend en Node.

## 👥 Integrantes del Equipo
- **[Gaston Sagasti]** - Módulo de ActoreS
- **[Genaro Zottele]** - Módulo de Series
- **[Santiago Schro]** - Módulo de Películas
- **[Genaro Weis]** - Módulo de Estrenos

## ✨ Características del Proyecto
✅ Lista de actores con sus películas destacadas y popularidad.  
✅ Listado de series con sus imagenes  
✅ Listado de peliculas
✅ Listado de estrenos
✅ Posibilidad de marcar favoritos.  
✅ Descripción personal editable para cada actor.  
✅ Datos obtenidos de la API de TMDB a través de un backend en **Node.js**.  
✅ Manejo de estado con **Provider**.  
✅ Interfaz optimizada con **FutureBuilder** para carga eficiente de datos.  

## 🛠️ Requisitos Previos
Para ejecutar este proyecto, necesitarás:
- **Flutter 3.x** instalado.
- **Dart 2.x**.
- **Node.js** y `npm` para ejecutar el backend.
- Dependencias del proyecto Flutter (se instalan con `flutter pub get`).

## 🚀 Cómo Ejecutar el Proyecto
### 1️⃣ Clonar el Repositorio
```bash
git clone [https://github.com/Sagaston123/EntregaFinalWeisZotteleSchrohSagasti.git]
cd [EntregaFinalWeisZotteleSchrohSagasti]
```

### 2️⃣ Configurar Variables de Entorno
Crear un archivo `.env` en la raíz del proyecto Flutter con la siguiente línea:
```
API_URL=http://localhost:3000
```

### 3️⃣ Instalar Dependencias
Ejecutar en la terminal:
```bash
flutter pub get
```

### 4️⃣ Ejecutar la API en Node.js
Ir al directorio del backend y ejecutar:
```bash
npm install
node index.js
```

### 5️⃣ Ejecutar la App en Flutter
```bash
flutter run
```

## 📂 Estructura del Proyecto
```
📦 flutter_application_base
 ┣ 📂 lib
 ┃ ┣ 📂 helpers
 ┃ ┃ ┣ actor_provider.dart
 ┃ ┃ ┣ EstrenosProvider.dart
 ┃ ┃ ┣ apiServiceEstrenos.dart
 ┃ ┃ ┣ apiServiceSeries.dart
 ┃ ┃ ┣ apiServiceActors.dart
 ┃ ┃ ┣ preferences.dart
 ┃ ┣ 📂 models
 ┃ ┃ ┣ actorModel.dart
 ┃ ┃ ┣ estrenosModel.dart
 ┃ ┃ ┣ movieModel.dart
 ┃ ┣ 📂 screens
 ┃ ┃ ┣ ActorDetailScreen.dart
 ┃ ┃ ┣ ActoresListScreen.dart
 ┃ ┃ ┣ custom_list_movies_item.dart
 ┃ ┃ ┣ custom_list_movies_screen.dart
 ┃ ┃ ┣ home_screen.dart
 ┃ ┃ ┣ profile_screen.dart
 ┃ ┃ ┣ estrenos_list_item.dart
 ┃ ┃ ┣ estrenos_list_screen.dart
 ┃ ┃ ┣ record_details_screen.dart
 ┃ ┃ ┣ record_list_screen.dart
 ┃ ┣ 📂 widgets
 ┃ ┃ ┣ actor_card.dart
 ┃ ┃ ┣ custom_card.dart
 ┃ ┃ ┣ drawer_menu.dart
 ┃ ┃ ┣ movie_card.dart
 ┃ ┃ ┣ RatingCircle_card.dart
 ┃ ┃ ┣ widgets.dart
 ┃ ┣ main.dart
 ┣ 📂 backend (API en Node.js)
 ┃ ┣ controllers/
 ┃ ┣ routes/
 ┃ ┣ config/
 ┃ ┣ index.js
 ┣ .env
 ┣ pubspec.yaml
 ┣ README.md
```

## 🛠️ Tecnologías Utilizadas
- **Flutter** (Dart)
- **Provider** (Gestión de Estado)
- **HTTP Package** (Peticiones API)
- **Shared Preferences** (Almacenamiento local)
- **Node.js & Express** (Backend API)
- **The Movie Database API (TMDB)**

## 🔗 Endpoints de la API
📌 La API en **Node.js** maneja los siguientes endpoints:

### 🔹 Actores
- `GET /app/people` → Obtiene la lista de actores populares.
- `GET /app/people/:id` → Obtiene información detallada de un actor.
- `GET /app/people/department` → Obtiene información detallada del departamento de un actor.

### 🔹 Series
- `GET /app/series` → Obtiene la lista de series populares.
- `GET /app/series/serie/:id` → Obtiene detalles de una serie.
- `GET /app/series/top_rated` → Obtiene las mejores series.
- `GET /app/series/filter` → Filterea segun un campo de una serie.

### 🔹 Películas
- `GET /app/movies/popular` → Obtiene la lista de películas populares.
- `GET /app/movies/:id/credits` → Obtiene creditos de una película.
- `GET /app/movies/id/recommendations` → Obtiene las recomendaciones de una pelicula.
- `GET /app/movies/genre` → Obtiene los generos de las películas.

### 🔹 Estrenos
- `GET /app/upcoming` → Obtiene los proximos estrenos.
- `GET /app/upcoming/:id` → Obtiene información detallada de una pelicula en estrenos.
- `GET /app/upcoming/language?original_language=en` → Filtra por lenguaje.



