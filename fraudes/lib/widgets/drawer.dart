import 'package:flutter/material.dart';

class DrawerPrincipal extends StatefulWidget {
  DrawerPrincipal({Key? key}) : super(key: key);

  @override
  State<DrawerPrincipal> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1.2)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/fondo_gris_oscuro.jpeg'),
                      fit: BoxFit.cover)),
              child: 
              Container(
                child: Image(
                  image: AssetImage('assets/images/fondo_drawer_2.png'),
                  // height: 50,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.blueGrey,
            ),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'inicio');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search_outlined,
              color: Colors.blueGrey,
            ),
            title: Text('Búsqueda'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'busqueda');
            },
          ),
          ListTile(
              leading: Icon(Icons.lightbulb_outline, color: Colors.blueGrey),
              title: Text('Tips'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'tips');
              }),
          Divider(
            color: Colors.grey[500],
          ),
          ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blueGrey),
              title: Text('Información'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'informacion');
              }),
          // ListTile(
          //   leading: Icon( Icons.lock_outline, color: Colors.blueGrey),
          //   title: Text('Aviso de privacidad'),
          //   onTap: () {
          //     Navigator.pushReplacementNamed(context, 'privacidad');
          //   },
          // ),
        ],
      ),
    );
  }
}
