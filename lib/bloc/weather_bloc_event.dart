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