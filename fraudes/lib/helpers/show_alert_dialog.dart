import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertMessage(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(titulo),
              content: SingleChildScrollView(
                child: Text(subtitulo, textAlign: TextAlign.left,),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('De acuerdo'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
        ],
            ));
    return;
  }

  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(titulo),
            content: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(subtitulo),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('De acuerdo'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
          ));
  return;
}
