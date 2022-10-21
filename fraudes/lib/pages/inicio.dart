import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fraudes/blocs/bloc/numeros_bloc.dart';
import 'package:fraudes/widgets/drawer.dart';
import 'package:fraudes/widgets/logotipos.dart';

class InicioPage extends StatefulWidget {
  InicioPage({this.restorationId});

  final String? restorationId;

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage>
    with TickerProviderStateMixin, RestorationMixin {
  late AnimationController controllerCircular;

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _fechaSeleccionada =
      RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _seleccionarFecha,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _fechaSeleccionada.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2015),
          lastDate: DateTime.now(),
          cancelText: 'Cancelar',
          confirmText: 'Seleccionar',
          helpText:'Seleccione una fecha'          
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_fechaSeleccionada, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _seleccionarFecha(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _fechaSeleccionada.value = newSelectedDate;
        BlocProvider.of<NumerosBloc>(context).add(OnBusquedaPorFecha('${_fechaSeleccionada.value.year}-${_fechaSeleccionada.value.month}-${_fechaSeleccionada.value.day}'));
      });
    }
  }

  @override
  void initState() {
    // Limpiar lista
    BlocProvider.of<NumerosBloc>(context).add(OnReiniciarValores());

    // Cargar lista con los números del día
    DateTime _hoy = DateTime.now();
    BlocProvider.of<NumerosBloc>(context).add(OnBusquedaPorFecha('${_hoy.year}-${_hoy.month}-${_hoy.day}'));

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
              'Números de extorsión Durango',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const LogotiposWidget(),
                const SizedBox(height: 20,),
                const Text('Números del día', 
                style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: Colors.blueGrey
                ),),
                OutlinedButton(
                  // style: ButtonStyle(foregroundColor: Colors.red),
                  onPressed: () {
                    // Abrir Date picker
                    _restorableDatePickerRouteFuture.present();
                  },
                  child: Text('${_fechaSeleccionada.value.day}/${_fechaSeleccionada.value.month}/${_fechaSeleccionada.value.year}',
                    style: TextStyle(color: Colors.blueGrey[700], fontSize: 14),),
                ),
                BlocBuilder<NumerosBloc, NumerosState>(
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
                )
              ],
            ),
          ),
          drawer: DrawerPrincipal(),
        )
      ],
    );
  }

  ListView _listaBusqueda(NumerosState state) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
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
        });
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
              'No hay ningún número registrado de fraude o extorsión en la fecha seleccionada.',
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
          'assets/images/ok_phone.png',
          height: 80,
        )
      ],
    );
  }
}
