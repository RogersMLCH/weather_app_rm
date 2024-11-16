import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_rm/bloc/weather_bloc_bloc.dart';

//Como buen practica  trabajamos en un archivo diferente al principal
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  Widget getWeatherIcon(int code)
  {
    switch (code) {
		  case >= 200 && < 300 :
		    return Image.asset(
					'assets/1.png'
				);
			case >= 300 && < 400 :
		    return Image.asset(
					'assets/2.png'
				);
			case >= 500 && < 600 :
		    return Image.asset(
					'assets/3.png'
				);
			case >= 600 && < 700 :
		    return Image.asset(
					'assets/4.png'
				);
			case >= 700 && < 800 :
		    return Image.asset(
					'assets/5.png'
				);
			case == 800 :
		    return Image.asset(
					'assets/6.png'
				);
			case > 800 && <= 804 :
		    return Image.asset(
					'assets/7.png'
				);
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
      //Barra de apps
      appBar: AppBar(
        //Colores
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
            //El hijo contiene lso elementos
            children: [
              Align(
                //Aliniamieto en lso ejes
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
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
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
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      color: const Color.fromARGB(255, 48, 113, 197)),
                ),
              ),
              //Aqui le aplicamos blur a los elementos
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSucess){
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      //Para ubicarlo en la parte superior izquierda
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          '📍 ${state.weather.areaName}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          //'Buenos días',
                          ' ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        //Image.asset('assets/3.png'),
                        getWeatherIcon(state.weather.weatherConditionCode!),
                         Center(
                            child: Text(
                          '${state.weather.temperature!.celsius!.round()}°C',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600),
                        )),
                         Center(
                            child: Text(
                          state.weather.weatherMain!.toUpperCase() ,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            color: Color.fromARGB(255, 67, 186, 161),
                          ),
                        ),
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
