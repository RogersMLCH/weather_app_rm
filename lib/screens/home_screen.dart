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
