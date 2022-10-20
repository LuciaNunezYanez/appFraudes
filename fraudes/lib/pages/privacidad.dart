import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fraudes/global/environment.dart';
import 'package:fraudes/widgets/widgets.dart';

class PrivacidadPage extends StatelessWidget {
  PrivacidadPage({Key? key}) : super(key: key);

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
              'Aviso de privacidad',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('${Environment.aPrivacidad}', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16),)
                ],
              ),
            ),
          ),
          drawer: DrawerPrincipal(),
        )
      ],
    );
  }
}
