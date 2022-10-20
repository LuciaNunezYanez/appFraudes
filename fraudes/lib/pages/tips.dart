import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fraudes/global/environment.dart';
import 'package:fraudes/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TipsPage extends StatelessWidget {
  TipsPage({Key? key}) : super(key: key);

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
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Card(
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/llamada.png',
                              height: 30,
                            ),
                            title: Text('Quiero hacer una denuncia anónima',
                                textAlign: TextAlign.center),
                          ),
                        ),
                        onTap: () async {
                          await launchUrl(
                            Uri.parse('tel:089'),
                          ).catchError((e) {
                            print('Error al lanzar 089');
                          });
                        },
                      ),
                      InkWell(
                        child: Card(
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/llamada.png',
                              height: 30,
                            ),
                            title: Text('Tengo una emergencia',
                                textAlign: TextAlign.center),
                          ),
                        ),
                        onTap: () async {
                          await launchUrl(
                            Uri.parse('tel:911'),
                          ).catchError((e) {
                            print('Error al lanzar 911');
                          });
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
                          await launchUrl(
                            Uri.parse('https://twitter.com/Cibernetica_Dgo'),
                          ).catchError((e) {
                            print('Error al lanzar twitter');
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
                          await launchUrl(
                            Uri.parse('https://www.facebook.com/ssp.durango'),
                          ).catchError((e) {
                            print('Error al lanzar FB');
                          });
                        },
                      ),
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
                    imageUrl: "https://pbs.twimg.com/media/FfDWYhbWAAACpHi?format=jpg&name=small",
                    placeholder: (context, url) => new Image.asset('assets/images/tips1.jfif'),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CachedNetworkImage(
                    imageUrl: "https://pbs.twimg.com/media/Fezs_-EX0AEWYgT?format=jpg&name=small",
                    placeholder: (context, url) => new Image.asset('assets/images/tips1.jfif'),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: 25, right: 25, bottom: 25), 
                child: InkWell(
                        child: Column(
                          children: const [
                            Text('Envianos tus dudas y/o sugerencias:', style: TextStyle(fontSize: 16),),
                            SizedBox(height: 10,),
                            Text(Environment.correoDudas, style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w600),),
                          ],
                        ),
                        onTap: () async {
                          await launchUrl(
                            Uri.parse('mailto:${Environment.correoDudas}'),
                          ).catchError((e) {
                            print('Error al enviar correo eletrónico');
                          });
                        },
                      ),)
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
