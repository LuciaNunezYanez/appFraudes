import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fraudes/blocs/bloc/numeros_bloc.dart';
import 'package:fraudes/helpers/show_alert_dialog.dart';
import 'package:fraudes/widgets/drawer.dart';
import 'package:fraudes/widgets/logotipos.dart';

class BusquedaPage extends StatefulWidget {
  TextEditingController numeroController = new TextEditingController();

  @override
  State<BusquedaPage> createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> with TickerProviderStateMixin {
  late AnimationController controllerCircular;

  @override
  void initState() {
    // Limpiar lista
    BlocProvider.of<NumerosBloc>(context).add(OnReiniciarValores());

    controllerCircular = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controllerCircular.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controllerCircular.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/fondo.JPG",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text(
              'Búsqueda de números',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              // decoration: BoxDecoration(
              //       image: DecorationImage(image: AssetImage('assets/images/perfect.png'), fit: BoxFit.cover)
              //     ),
              child: Column(
                children: [
                  const LogotiposWidget(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Text(
                      'Ingrese un número para consultar si tiene reporte de fraude o extorsión en el estado de Durango.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                              controller: widget.numeroController,
                              textAlign: TextAlign.center,
                              maxLength: 10,
                              autofocus: false,
                              style: TextStyle(fontSize: 18),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  focusColor: Colors.green,
                                  contentPadding: EdgeInsets.all(0.5),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  Colors.green,
                                      width: 1.5
                                    )
                                  ),
                                  hintText: 'Número de teléfono',
                                  alignLabelWithHint: false),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: ButtonTheme(
                            minWidth: 100,
                            height: 300,
                            child: OutlinedButton(
                              // style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                              child: const Icon(
                                Icons.search,
                                color: Colors.green,
                              ),

                              onPressed: () {
                                String numero = widget.numeroController.text;
                                if (numero.length < 7) {
                                  showAlertMessage(context, 'Atención',
                                      'Ingrese al menos 7 dígitos');
                                } else {
                                  BlocProvider.of<NumerosBloc>(context).add(
                                      OnBusquedaNumero(
                                          widget.numeroController.text));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: BlocBuilder<NumerosBloc, NumerosState>(
                        builder: (context, state) {
                          if (state.error) {
                            return _cardError(state);
                          } else if (state.buscando == false &&
                              state.noEncontrado == false &&
                              state.listaNumeros.isEmpty) {
                            return Container();
                          } else if (state.buscando == true) {
                            return _buscando();
                          } else if (state.buscando == false &&
                              state.listaNumeros.isNotEmpty) {
                            return _listaBusqueda(state);
                          } else if (state.noEncontrado == true &&
                              state.listaNumeros.isEmpty) {
                            return _noEncontrado();
                          } else {
                            return const Text('---');
                          }
                        },
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
          drawer: DrawerPrincipal(),
        )
      ],
    );
  }

  _listaBusqueda(NumerosState state) {
    return Column(
      children: [
        // Text('Ultima actualización: '),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('Números que coinciden',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w800)),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 50, right: 50),
            itemCount: state.listaNumeros.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(
                      //   Icons.phone,
                      //   color: Colors.blueGrey,
                      // ),
                      title: Text(
                        state.listaNumeros[index].numeroTelefonico,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              );
              // return _customCard(state.listaNumeros[index].numeroTelefonico);
            }),
      ],
    );
  }

  Column _cardError(NumerosState state) {
    return Column(
      children: [
        Text(
          'Error',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.red[600]),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          state.mensajeError!,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey),
        )
      ],
    );
  }

  Column _buscando() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Buscando',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.blueGrey),
        ),
        const SizedBox(
          height: 15,
        ),
        CircularProgressIndicator(
          color: Colors.grey,
          strokeWidth: 8,
          semanticsLabel: 'Barra de progreso',
          value: controllerCircular.value,
        ),
      ],
    );
  }

  Column _noEncontrado() {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
              'En el estado de Durango no se tiene reporte de fraude o extorsión del número ingresado.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green)),
        ),
        SizedBox(
          height: 15,
        ),
        Image.asset(
          'assets/images/like.png',
          height: 80,
        )
      ],
    );
  }
}
