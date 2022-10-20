import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fraudes/global/environment.dart';
import 'package:fraudes/models/numero.model.dart';
import 'package:fraudes/models/numeros.model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'numeros_event.dart';
part 'numeros_state.dart';

class NumerosBloc extends Bloc<NumerosEvent, NumerosState> {
  NumerosBloc() : super(NumerosInitial()) {
    on<OnCargarLista>((event, emit) {
      emit(state.copyWith(listaNumeros: event.listaNumeros));
    });
    on<OnBusquedaNumero>(_busquedaNumero);
  }

  FutureOr<void> _busquedaNumero(event, emit) async {
    try {
      emit(state.copyWith(
          listaNumeros: [], buscando: true, noEncontrado: false, error: false));

      final http.Response resp = await http
          .get(Uri.parse(
              '${Environment.url}/api/numeros/${event.numero.toString()}'))
          .timeout(Duration(seconds: 10), onTimeout: () {
              emit(state.copyWith(
                  listaNumeros: [],
                  buscando: false,
                  noEncontrado: true,
                  error: true,
                  mensajeError:
                      'Se excedió el tiempo de respuesta, verifique su conexión.'));
              return throw TimeoutException(
                  'El servidor tardó demasiado en responder');
            })
            .catchError((e){
              emit(state.copyWith(
                  listaNumeros: [],
                  buscando: false,
                  noEncontrado: true,
                  error: true,
                  mensajeError:
                    'Verifique su conexión a internet'));
              return throw TimeoutException(
                  'Verifique su conexión');
            });

      

      final Numeros numerosResponse = Numeros.fromJson(resp.body);
      List<Numero> listaNumeros = numerosResponse.numeros;
      (listaNumeros.isNotEmpty)
          ? emit(state.copyWith(
              listaNumeros: listaNumeros,
              buscando: false,
              noEncontrado: false,
              error: false))
          : emit(state.copyWith(
              listaNumeros: listaNumeros,
              buscando: false,
              noEncontrado: true,
              error: false));
      // print(listaNumeros);
    } on Exception catch (exception) {
      // TODO: Emitir que no hubo ningun número
    }
  }
}
