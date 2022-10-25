import 'package:flutter/material.dart';
import 'package:fraudes/widgets/logotipos.dart';
import 'package:fraudes/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class InformacionPage extends StatefulWidget {
  const InformacionPage({Key? key}) : super(key: key);

  @override
  State<InformacionPage> createState() => _InformacionPageState();
}

class _InformacionPageState extends State<InformacionPage> {
  bool _puedeLlamar = false;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _puedeLlamar = result;
      });
    });
  }

  Future<void> _hacerLlamada(String numeroTelefono) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: numeroTelefono,
    );
    await launchUrl(launchUri);
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
              'Información',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const LogotiposWidget(),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(35.0),
                        child: Column(
                          children: const [
                            Text(
                              'La información que se maneja dentro de esta aplicación es generada por el Servicio de Denuncia Anónima 089 del Estado de Durango.',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Si desea denunciar algún número telefónico utilizado para realizar fraude o extorsión presione el siguiente botón.',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // Image.asset(
                      //   'assets/images/089.png',
                      //   height: 80,
                      // ),
                      _puedeLlamar
                          ? OutlinedButton(
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Icon(Icons.call, color: Colors.red, size: 32),
                                  SizedBox(height: 5,),
                                  const Text(
                                    'Quiero hacer una denuncia anónima',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                              onPressed: () {
                                if (_puedeLlamar) {
                                  setState(() {
                                    _launched = _hacerLlamada('089');
                                  });
                                }
                              },
                            )
                          : const Text(
                              'Para una denuncia anónima marque al 089',
                              textAlign: TextAlign.center),
                    ],
                  ),
                )
              ],
            ),
          ),
          drawer: DrawerPrincipal(),
        )
      ],
    );
  }
}
