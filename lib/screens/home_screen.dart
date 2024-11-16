import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_rm/bloc/weather_bloc_bloc.dart';

//Como buen practica  trabajamos en un archivo diferente al principal
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  //Las dimensiones del objeto
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 77, 207, 75)
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
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      //Para ubicarlo en la parte superior izquierda
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '📍 Ubicación',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Buenos días',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset('assets/1.png'),
                        const Center(
                            child: Text(
                          '31°',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.w600),
                        )),
                        const Center(
                            child: Text(
                          'Tormenta',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )),
                        const Center(
                            child: Text(
                          'Viernes 15 · 9:22 AM',
                          style: TextStyle(
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Soleado',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    '5:34 AM',
                                    style: TextStyle(
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ocaso',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    '5:34 PM',
                                    style: TextStyle(
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Temp. maxima',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    '42°',
                                    style: TextStyle(
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Temp. minima',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    '34°',
                                    style: TextStyle(
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
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
