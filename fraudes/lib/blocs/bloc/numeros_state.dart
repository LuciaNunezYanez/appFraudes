part of 'numeros_bloc.dart';

@immutable
class NumerosState extends Equatable{

  List<Numero> listaNumeros;
  bool buscando = false;
  bool noEncontrado = false;

  bool error = false;
  String? mensajeError;

  NumerosState({
    this.listaNumeros = const [], 
    this.buscando = false, 
    this.noEncontrado = false, 

    this.error = false,
    this.mensajeError
  });

  NumerosState copyWith({
    List<Numero>? listaNumeros, 
    bool? buscando, 
    bool? noEncontrado, 

    bool? error, 
    String? mensajeError
  }){
    return NumerosState(
      listaNumeros: listaNumeros ?? this.listaNumeros,
      buscando: buscando ?? this.buscando,
      noEncontrado: noEncontrado ?? this.noEncontrado,
      
      error: error ?? this.error,
      mensajeError: mensajeError ?? this.mensajeError
    );
  }
  
  @override
  List<Object?> get props => [listaNumeros, buscando, noEncontrado, error, mensajeError];
}

class NumerosInitial extends NumerosState {
  NumerosInitial(): super(listaNumeros: []);
}
