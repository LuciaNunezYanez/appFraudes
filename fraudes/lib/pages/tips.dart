import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fraudes/global/environment.dart';
import 'package:fraudes/widgets/logotipos.dart';
import 'package:fraudes/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TipsPage extends StatefulWidget {
  TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  bool _puedeLlamar = false;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _puedeLlamar = result;
      });
    });
  }

  Future<void> _lanzarNavegador(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'No se puede lanzar $url';
    }
  }

  Future<void> _hacerLlamada(String numeroTelefono) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: numeroTelefono,
    );
    await launchUrl(launchUri);
  }

  Future<void> _enviarCorreo(String correo) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: correo,
    );
    await launchUrl(launchUri);
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
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
              'Tips',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                LogotiposWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0 ),
                  child: Column(
                    children: [
                      InkWell(
                          child: Card(
                            child: ListTile(
                              leading: Image.asset(
                                'assets/images/llamada.png',
                                height: 30,
                              ),
                              title: _puedeLlamar
                                  ? const Text(
                                      'Quiero hacer una denuncia anónima',
                                      textAlign: TextAlign.center)
                                  : const Text(
                                      'Para una denuncia anónima marque al 089',
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          onTap: () async {
                            // print('Voy a llamar');
                            if (_puedeLlamar) {
                              setState(() {
                                _launched = _hacerLlamada('089');
                              });
                            }
                          }),
                      InkWell(
                        child: Card(
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/llamada.png',
                              height: 30,
                            ),
                            title: _puedeLlamar
                                ? const Text('Tengo una emergencia',
                                    textAlign: TextAlign.center)
                                : const Text('Para una emergencia llame a 911',
                                    textAlign: TextAlign.center),
                          ),
                        ),
                        onTap: () async {
                          // print('Voy a llamar');
                          if (_puedeLlamar) {
                            setState(() {
                              _launched = _hacerLlamada('911');
                            });
                          }
                        },
                      ),
                      InkWell(
                        child: Card(
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/twitter.png',
                              height: 30,
                            ),
                            title: Text(
                                'Policía Cibernética del Estado de Durango',
                                textAlign: TextAlign.center),
                          ),
                        ),
                        onTap: () async {
                          setState(() {
                            _launched = _lanzarNavegador(Uri.parse(
                                'https://twitter.com/Cibernetica_Dgo'));
                          });
                        },
                      ),
                      InkWell(
                        child: Card(
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/facebook.png',
                              height: 30,
                            ),
                            title: Text('SSP Durango',
                                textAlign: TextAlign.center),
                          ),
                        ),
                        onTap: () async {
                          setState(() {
                            _launched = _lanzarNavegador(Uri.parse(
                                'https://www.facebook.com/ssp.durango'));
                          });
                        },
                      ),
                      FutureBuilder<void>(
                          future: _launched, builder: _launchStatus),
                    ],
                  ),
                ),

                // Comienzan las imagenes
                // Comienzan las imagenes
                // Comienzan las imagenes
                // Comienzan las imagenes

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://pbs.twimg.com/media/Fdxm_F4XEBINlMv?format=jpg&name=small",
                    placeholder: (context, url) =>
                        new Image.asset('assets/images/tips1.jfif'),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://pbs.twimg.com/media/FfDWYhbWAAACpHi?format=jpg&name=small",
                    placeholder: (context, url) =>
                        new Image.asset('assets/images/tips1.jfif'),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://pbs.twimg.com/media/Fezs_-EX0AEWYgT?format=jpg&name=small",
                    placeholder: (context, url) =>
                        new Image.asset('assets/images/tips1.jfif'),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: InkWell(
                    child: Column(
                      children: const [
                        Text(
                          'Envianos tus dudas y/o sugerencias:',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Environment.correoDudas,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    onTap: () async {
                      setState(() {
                        _launched = _enviarCorreo('${Environment.correoDudas}');
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Image.network('https://pbs.twimg.com/media/FfIlkUwXoAI_gHL?format=jpg&name=small',
          // errorBuilder: (context, error, stackTrace) {
          //   throw TimeoutException('sadasd');
          //   return Image.asset('assets/images/perfect.png');
          // },
          // loadingBuilder: (context, child, loadingProgress) {
          //   if(loadingProgress == null ) return child;
          //   return Image.asset('assets/images/perfect.png');
          // },
          // ),

          // Container(
          //   child: FadeInImage.assetNetwork(
          //     placeholder: 'assets/images/perfect.png',
          //     image: 'https://pbs.twimg.com/media/FfIlkUwXoAI_gHL?format=jpg&name=small',
          //     imageErrorBuilder: (context, error, stackTrace) => new Icon(Icons.ac_unit),),
          // ),
          drawer: DrawerPrincipal(),
        )
      ],
    );
  }
}
