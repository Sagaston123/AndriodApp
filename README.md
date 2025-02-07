
       
# 🎬 Proyecto de Gestión de Actores, Series y Películas

## 📌 Descripción General
Este proyecto es una aplicación desarrollada en **Flutter** que permite visualizar información sobre actores, series, películas y estrenos próximos. La app se conecta con una API en **Node.js**, que obtiene datos de The Movie Database (TMDB).

## 👥 Integrantes del Equipo
- **[Tu Nombre]** - Módulo de Actores
- **[Compañero 1]** - Módulo de Series
- **[Compañero 2]** - Módulo de Películas
- **[Compañero 3]** - Módulo de Estrenos

## ✨ Características del Proyecto
✅ Lista de actores con sus películas destacadas y popularidad.  
✅ Listado de series, películas y estrenos.  
✅ Posibilidad de marcar favoritos (guardado con `SharedPreferences`).  
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
git clone [URL_DEL_REPO]
cd [NOMBRE_DEL_PROYECTO]
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
 ┃ ┃ ┣ apiServiceActors.dart
 ┃ ┣ 📂 models
 ┃ ┃ ┣ actorModel.dart
 ┃ ┃ ┣ movieModel.dart
 ┃ ┣ 📂 screens
 ┃ ┃ ┣ actores_list_screen.dart
 ┃ ┃ ┣ actor_detail_screen.dart
 ┃ ┃ ┣ series_list_screen.dart
 ┃ ┃ ┣ peliculas_list_screen.dart
 ┃ ┃ ┣ estrenos_list_screen.dart
 ┃ ┣ 📂 widgets
 ┃ ┃ ┣ actor_card.dart
 ┃ ┃ ┣ series_card.dart
 ┃ ┃ ┣ peliculas_card.dart
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

### 🔹 Series
- `GET /app/series` → Obtiene la lista de series populares.
- `GET /app/series/:id` → Obtiene detalles de una serie.

### 🔹 Películas
- `GET /app/movies` → Obtiene la lista de películas populares.
- `GET /app/movies/:id` → Obtiene detalles de una película.

### 🔹 Estrenos
- `GET /app/estrenos` → Obtiene la lista de próximos estrenos.

## 📧 Contacto
Para más información o dudas, contactar a `sganan81@gmail.com`.

🚀 **¡Listo para el push final!**

