import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fraudes/blocs/bloc/numeros_bloc.dart';
import 'package:fraudes/pages/busqueda.dart';
import 'package:fraudes/pages/inicio.dart';
import 'package:fraudes/pages/privacidad.dart';
import 'package:fraudes/pages/tips.dart';

void main(){
  
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: ( context ) => NumerosBloc())
    ], child:  MyApp()));
  
  }

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fraudes',
      initialRoute: 'inicio',
      routes: {
        'inicio' : (_) => InicioPage(restorationId: 'main',),
        'busqueda' : (_) => BusquedaPage(),
        'privacidad' : (_) => PrivacidadPage(),
        'tips' : (_) => TipsPage(),
      },
    );
  }
}