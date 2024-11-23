author: RogersMLCH
summary:
id: proyecto
tags:
categories:
environments: Web
status: Published
feedback link: https://github.com/SolaceDev/solace-dev-codelabs/blob/master/markdown/proyecto

# App clone del clima con API de Roger M para la clase de disositivos moviles

## Creando el proyecto

Duration: 0:02:00

Para crear un proyecto en Flutter que sea compatible con Android, iOS y Web desde cero, primero necesitas instalar Flutter en tu computadora. Dirígete al sitio oficial de Flutter ([flutter.dev](https://flutter.dev/docs/get-started/install)) y sigue las instrucciones de instalación para tu sistema operativo (Windows, macOS o Linux). Asegúrate de agregar Flutter al PATH de tu sistema y de tener las herramientas necesarias, como Android Studio para el desarrollo de Android, y Xcode para iOS en macOS.

Una vez instalado Flutter, abre una terminal y ejecuta el comando `flutter doctor` para verificar que tu entorno de desarrollo está correctamente configurado. Esto te indicará si necesitas instalar componentes adicionales, como las herramientas de Android o Xcode.

Luego, para crear un nuevo proyecto Flutter, abre una terminal y navega a la carpeta donde quieras crear el proyecto. Ejecuta el comando `flutter create nombre_del_proyecto`. Esto generará la estructura básica de un proyecto Flutter que incluye una aplicación de ejemplo.

Flutter es compatible con Android, iOS y Web de forma predeterminada, por lo que ya tendrás soporte para estas plataformas al crear el proyecto. Para comprobar que las plataformas están habilitadas, puedes ejecutar el comando `flutter devices`, que te mostrará los dispositivos disponibles para desarrollo.

Cuando estés listo para comenzar a desarrollar, puedes ejecutar el proyecto en el emulador de Android, un dispositivo iOS conectado o un navegador web. Para esto, usa el comando `flutter run -d` seguido del nombre del dispositivo: `flutter run -d android` para Android, `flutter run -d ios` para iOS (solo en macOS), o `flutter run -d chrome` para ejecutar en el navegador.

Para crear versiones de producción de tu aplicación, puedes usar los comandos `flutter build apk` para generar el archivo APK para Android, `flutter build ios` para generar el archivo IPA para iOS (esto solo es posible en macOS), y `flutter build web` para generar los archivos de tu aplicación web. Estos archivos estarán ubicados en la carpeta `build` de tu proyecto.

La estructura de la creación de archivos es:

```markdown
lib/
├── bloc/
│   ├── weather_bloc_bloc.dart
│   ├── weather_bloc_event.dart
│   └── weather_bloc_state.dart
├── data/
│   └── my_data.dart
└── screens/
    └── home_screen.dart
```

Este proyecto se desarrolla utilizando Flutter y está estructurado de la siguiente manera dentro de la carpeta `lib`:


- **Bloc**: 
  - `weather_bloc_bloc.dart`: Lógica principal del Bloc, donde se gestionan los estados relacionados con la obtención y presentación de datos del clima.
  - `weather_bloc_event.dart`: Define los eventos que dispararán las acciones en el Bloc, como la solicitud de clima.
  - `weather_bloc_state.dart`: Define los estados posibles de la aplicación, como el estado de carga, éxito o error.

- **Data**:
  - `my_data.dart`: Aquí se gestionan los datos relacionados con el clima, como las consultas a la API o cualquier almacenamiento local de información.

- **Screens**:
  - `home_screen.dart`: Pantalla principal de la aplicación donde el usuario puede ver la información del clima y realizar interacciones.

- **Raíz**:
  - `main.dart`: Archivo principal que inicializa la aplicación, configura los servicios y enlaza los componentes de las carpetas `bloc`, `data` y `screens`.


## Prerequisitos

Duration: 0:02:00

Antes de comenzar con el proyecto, asegúrate de tener Flutter instalado en tu entorno de desarrollo. Si no lo has hecho aún, puedes seguir la guía de instalación oficial de Flutter [aquí](https://flutter.dev/docs/get-started/install).

- **Imágenes del clima**:  
  Necesitarás imágenes representativas para los diferentes estados del clima (por ejemplo, soleado, lluvioso, nublado, tormentoso, etc.). Estas imágenes deben ser almacenadas en la carpeta de recursos de tu proyecto y ser accesibles desde la UI para mostrar el clima de acuerdo con el estado obtenido. 

  Asegúrate de incluir las imágenes en el archivo `pubspec.yaml` bajo la sección `assets` para que Flutter las cargue correctamente:

  ```yaml
  flutter:
    assets:
      - assets/images/1.png


## Backend
Duration: 0:05:00

En main.dart, configura tu aplicación y enlaza los componentes necesarios de las carpetas bloc y data.


### `lib/bloc/weather_bloc_bloc.dart`

Este archivo es el núcleo del sistema de gestión de estados utilizando el patrón BLoC. Aquí es donde se define la lógica de negocio relacionada con la obtención del clima. En este archivo, se manejan los eventos (acciones que desencadenan la lógica) y los estados (resultados o respuestas a esos eventos).

# `lib/bloc/weather_bloc_bloc.dart`

```dart
// Importaciones de paquetes
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/my_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  // Constructor del Bloc, inicializa el estado con 'WeatherBlocInitial'.
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    
    // Define la reacción del Bloc a un evento de tipo 'FechWeather'.
    on<FechWeather>((event, emit) async {
      
      // Emite el estado de carga mientras se obtienen los datos del clima.
      emit(WeatherBlocLoading());

      try {
        // Crea una instancia de 'WeatherFactory' usando una clave API y especificando el idioma.
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        
        // Obtiene el clima actual basado en la latitud y longitud proporcionada en el evento.
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude, 
          event.position.longitude
        );
        
        // Imprime la información del clima en la consola para depuración.
        print(weather);

        // Cambia el estado a 'WeatherBlocSucess' con los datos del clima obtenidos.
        emit(WeatherBlocSucess(weather));
        
      } catch (e) {
        // Cambia el estado a 'WeatherBlocFailure' si ocurre un error al obtener el clima.
        emit(WeatherBlocFailure());
      }
    });
  }
}
```


# `lib/bloc/weather_bloc_event.dart`

```dart
// Importación de parte del archivo 'weather_bloc_bloc.dart' que contiene las definiciones del bloque del clima.
part of 'weather_bloc_bloc.dart';

// Definición de la clase abstracta 'WeatherBlocEvent', que representa eventos relacionados con la obtención del clima.
// La palabra clave 'sealed' indica que esta clase está cerrada y solo puede ser extendida por clases en el mismo archivo.
sealed class WeatherBlocEvent extends Equatable {
    // Constructor constante para 'WeatherBlocEvent', lo que permite crear instancias inmutables.
  const WeatherBlocEvent();

  // Sobrescribe la propiedad 'props' para Equatable, utilizada para la comparación de igualdad entre instancias.
  // Retorna una lista vacía por defecto, lo que significa que no tiene propiedades adicionales por defecto.
  @override
  List<Object> get props => [];
}

// Definición de la clase 'FechWeather', que extiende 'WeatherBlocEvent'.
// Este evento específico se utiliza para solicitar la obtención del clima en función de una posición geográfica.
class FechWeather extends WeatherBlocEvent
{
    // Propiedad final que almacena la posición geográfica para la solicitud del clima.
  final Position position;
    // Constructor constante que inicializa la propiedad 'position' al crear una instancia de 'FechWeather'.
  const FechWeather(this.position);
  // Sobrescribe la propiedad 'props' para incluir la 'position', permitiendo que Equatable compare instancias
  // de 'FechWeather' considerando la posición geográfica.
  @override
    List<Object> get props => [position];
  }
```

# `lib/bloc/weather_bloc_state.dart`

```dart
part of 'weather_bloc_bloc.dart';
// Parte del archivo 'weather_bloc_bloc.dart'.

// Declaración de la clase base para los estados del WeatherBloc. 
// Utiliza la palabra clave 'sealed' para indicar que esta clase solo puede ser extendida dentro del mismo archivo.
// 'Equatable' se utiliza para facilitar la comparación de objetos, lo que es útil en el patrón BLoC para detectar cambios en el estado.
sealed class WeatherBlocState extends Equatable {
    // Constructor constante de la clase base de estado.
  const WeatherBlocState();
  
  @override
   // Sobrescribe la propiedad 'props' de Equatable para comparar estados.
  // Devuelve una lista vacía, indicando que por defecto, no hay propiedades a comparar.
  List<Object> get props => [];
}
// Estado inicial del WeatherBloc. Representa el estado inicial del bloque.
final class WeatherBlocInitial extends WeatherBlocState {}

// Estado de carga del WeatherBloc. Representa cuando los datos meteorológicos están en proceso de carga.
final class WeatherBlocLoading extends WeatherBlocState {}

// Estado de fallo del WeatherBloc. Representa un error al intentar cargar los datos meteorológicos.
final class WeatherBlocFailure extends WeatherBlocState {}

// Estado de éxito del WeatherBloc. Representa cuando los datos meteorológicos se han cargado con éxito.
final class WeatherBlocSucess extends WeatherBlocState 
{
    // Propiedad que contiene la información meteorológica cargada exitosamente.
  final Weather weather; 

  // Constructor constante que inicializa la propiedad 'weather'.
  const WeatherBlocSucess(this.weather);

 @override
   // Sobrescribe la propiedad 'props' para incluir 'weather' en la comparación.
  // Esto significa que dos instancias de WeatherBlocSucess solo se considerarán iguales si la propiedad 'weather' es igual.
  List<Object> get props => [weather];
}
```

### Detalles de los archivoc bloc:

- **Eventos** (`weather_bloc_event.dart`): Lo que la aplicación quiere hacer.
- **Estados** (`weather_bloc_state.dart`): La situación actual de la aplicación después de un evento.
- **Bloc** (`weather_bloc_bloc.dart`): El "cerebro" que toma los eventos y decide qué hacer con ellos, emitiendo estados que pueden ser observados por la UI para actualizarse.

# `lib/data`
```dart

//Solo es la clase sonde esta la API_KEY
String API_KEY ="f40ab426259e71145b219b2fa6aa5b7f";
```

## Frontend

Implementar la lógica relacionada con el clima en weather_bloc_bloc.dart y maneja las interacciones del usuario en home_screen.dart.


El main alimenta el inicio de todos los widgets y se enlaza con la información de los bloc en cada una de sus fases. 
# `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_rm/bloc/weather_bloc_bloc.dart';
import 'package:weather_app_rm/screens/home_screen.dart';

// Principal de la clase
void main() {
  runApp(const MyApp());
}

// Definición de la clase MyApp que extiende StatelessWidget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    // Método build que retorna el widget principal de la aplicación.
  Widget build(BuildContext context) {
    return MaterialApp(
        // Título de la aplicación.
        title: 'Weather App RM',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Llama a la función _determinePosition que obtiene la posición del usuario.
          future: _determinePosition(),
           // Constructor que construye el widget basado en el estado del Future.
          builder: (context,snap)
          {
            // Si el Future contiene datos (la posición del usuario).
            if(snap.hasData)
            {
              return BlocProvider<WeatherBlocBloc>(
          // Proveedor de Bloc para la gestión del estado de la aplicación del clima.
          create: (context) => WeatherBlocBloc()..add(FechWeather(snap.data as Position)),
          // Crea una instancia de WeatherBlocBloc y agrega un evento para obtener el clima basado en la posición.
          child: const HomeScreen() // Muestra la pantalla principal de la aplicación (Home Screen).
              );
            }else
            {
              // Imprime un mensaje de error en caso de que no haya datos.
              print('Error');
              return const Scaffold(
                // Muestra una pantalla de carga mientras se obtiene la posición.
                body: Center(
                  // Indicador de progreso circular.
                  child: CircularProgressIndicator(),
                ),
                
              );
            }
            }
            )
        );
      }
      }
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
```


screens maneja la logica de la información recibida para desplegar como vista tambien. 

# `lib/screens/home_screen.dart`

```dart
import 'dart:ui';

// Importaciones necesarias para Flutter, Bloc y formateo de fechas
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_rm/bloc/weather_bloc_bloc.dart';

// Como buen practica  trabajamos en un archivo diferente al principal
// Se define una clase StatefulWidget llamada HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
    State<HomeScreen> createState() => _HomeScreenState();
}
// Estado asociado al widget HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  
  // Función que devuelve un widget Image basado en un código de condición climática
  Widget getWeatherIcon(int code)
  {
    // Uso de un switch para seleccionar la imagen correcta según el código del clima
    switch (code) {
      // Condiciones para códigos entre 200 y 299
		  case >= 200 && < 300 :
		    return Image.asset(
					'assets/1.png'
				);
        // Condiciones para códigos entre 300 y 399
			case >= 300 && < 400 :
		    return Image.asset(
					'assets/2.png'
				);
        // Condiciones para códigos entre 500 y 599
			case >= 500 && < 600 :
		    return Image.asset(
					'assets/3.png'
				);
        // Condiciones para códigos entre 600 y 699
			case >= 600 && < 700 :
		    return Image.asset(
					'assets/4.png'
				);
        // Condiciones para códigos entre 700 y 799
			case >= 700 && < 800 :
		    return Image.asset(
					'assets/5.png'
				);
        // Código exacto de 800
			case == 800 :
		    return Image.asset(
					'assets/6.png'
				);
        // Códigos entre 801 y 804
			case > 800 && <= 804 :
		    return Image.asset(
					'assets/7.png'
				);
        // Valor predeterminado si no coincide ninguna condición anterior
		  default:
			return Image.asset(
				'assets/7.png'
			);
		}

  }
  @override
  Widget build(BuildContext context) {
    //Crea una zona de contenido para mostrar en la vista
    return Scaffold(
      //Color de fondo de la app
      backgroundColor: Colors.black,
      //Permite que el cuerpo de la pantalla se extienda detrás de la AppBar
      extendBodyBehindAppBar: true,
      //Definición de la barra de apps
      appBar: AppBar(
        // La AppBar es transparente
        backgroundColor: Colors.transparent,
        //Elimina la sombra
        elevation: 0,
        //Permite personalizar el estilo de la barra de estado
        systemOverlayStyle: const SystemUiOverlayStyle(
            // Establece el brillo de la barra de estado del sistema en modo oscuro
            statusBarBrightness: Brightness.dark),
      ),

      //Define el contenido principal de la pantalla y lo envuelve en un widget Padding
      body: Padding(
        //Especifica los márgenes internos en el widget Padding, con la función EdgeInsets.fromLTRB que recibe los valores en el orden izquierda, arriba, derecha y abajo
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        //Al envolver el contenido en un SizedBox, que permite definir un tamaño fijo para su hijo
        child: SizedBox(
          //Tamaño automatico que se adapta al dispositivo por el MediaQuery
          height: MediaQuery.of(context).size.height,
          //Empaquetar en una pila los elemtos y sus caracteristicas
          child: Stack(
            //El hijo contiene los elementos
            children: [
              Align(
                //Aliniamieto en los ejes
                alignment: const  AlignmentDirectional(3, -0.3),
                child: Container(
                  //Las dimensiones del objeto
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color:  Color.fromARGB(255, 77, 207, 75)
                      //color: Colors.deepPurple
                      ),
                ),
              ),
              //Para el otro color solo es replicar
              Align(
                //Este tiene aliniamiento negativo
                // Alinea otro contenedor similar en el lado opuesto con valores negativos
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                    // Tamaño del contenedor
                  height: 300,
                  width: 300,
                  //La decoracion del objeto
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 77, 207, 75)
                      //color: Colors.deepPurple
                      ),
                ),
              ),
              //Para el otro color solo es replicar
              Align(
                alignment: AlignmentDirectional(3, -1.2),
                child: Container(
                  // Tamaño del contenedor
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      color: const Color.fromARGB(255, 48, 113, 197)),
                ),
              ),
              // Aplica un efecto de desenfoque a los elementos subyacentes
              //Aqui le aplicamos blur a los elementos
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  // Un contenedor transparente para mantener el diseño visual
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              // Construcción dinámica del contenido basado en el estado usando BlocBuilder
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  // Si el estado es de éxito (datos disponibles)
                  if (state is WeatherBlocSucess){
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    // Coloca el contenido en una columna vertical
                    child: Column(
                      //Para ubicarlo en la parte superior izquierda
                      // Alineación del contenido al inicio de la columna
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Muestra el área del clima
                         Text(
                          '📍 ${state.weather.areaName}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          //'Buenos días',
                          ' ',// Texto genérico "Buenos días" (actualmente en blanco) cambian segpun la hora del día
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        //Image.asset('assets/3.png'),
                        // Muestra el ícono del clima basado en el código de condición
                        getWeatherIcon(state.weather.weatherConditionCode!),
                          // Muestra la temperatura en grados Celsius centrada en la pantalla
                         Center(
                            child: Text(
                          '${state.weather.temperature!.celsius!.round()}°C',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600),
                        )),
                         // Muestra la descripción principal del clima en mayúsculas
                         Center(
                            child: Text(
                          state.weather.weatherMain!.toUpperCase() ,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )),
                          // Muestra la fecha formateada y la hora
                         Center(
                            child: Text(
                              //DateFormat().format(state.weather.date!),
                                                            //DateFormat().format(state.weather.date!),
                              DateFormat('EEEE dd · ').add_jm().format(state.weather.date!),
                          //'Viernes 15 · 9:22 AM',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        )),
                        const SizedBox(height: 30),
                         // Fila con información del amanecer y el ocaso
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Información del amanecer
                            Row(children: [
                              Image.asset(
                                'assets/11.png',
                                scale: 8,
                              ),
                              //Es importante saber que esta dentro de que
                              const SizedBox(width: 5),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Salida del sol',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(width: 3),
                                  // Muestra la hora del amanecer
                                  Text(
                                    //'5:34 AM',
                                    DateFormat('').add_jm().format(state.weather.sunrise!),

                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ]),
                            // Información del ocaso
                            Row(children: [
                              Image.asset(
                                'assets/12.png',
                                scale: 8,
                              ),
                              //Es importante saber que esta dentro de que
                              const SizedBox(width: 5),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Ocaso',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(width: 3),
                                  // Muestra la hora del ocaso
                                  Text(
                                    //'5:34 PM',
                                    DateFormat('').add_jm().format(state.weather.sunset!),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ])
                          ],
                        ),
                        // Línea divisoria decorativa
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            color: Color.fromARGB(255, 67, 186, 161),
                          ),
                        ),
                         // Fila con la temperatura máxima y mínima
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.asset(
                                'assets/13.png',
                                scale: 8,
                              ),
                              //Es importante saber que esta dentro de que
                              const SizedBox(width: 5),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Temp. maxima',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    //'42°',
                                    '${state.weather.tempMax!.celsius!.round().toString() } C°',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ]),
                            Row(children: [
                              Image.asset(
                                'assets/14.png',
                                scale: 8,
                              ),
                              //Es importante saber que esta dentro de que
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Temp. minima',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(width: 3),
                                   Text(
                                    //'34°',
                                    '${state.weather.tempMin!.celsius!.round().toString() } C°',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ])
                          ],
                        ),
                      ],
                    ),
                  );
                  }else{
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
```