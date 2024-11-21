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
