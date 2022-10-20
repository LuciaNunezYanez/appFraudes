part of 'numeros_bloc.dart';

@immutable
class NumerosEvent {}


class OnCargarLista extends NumerosEvent {
  final List<Numero> listaNumeros;
  OnCargarLista(this.listaNumeros);
}

class OnBusquedaNumero extends NumerosEvent {
  final String numero;
  OnBusquedaNumero(this.numero);
}