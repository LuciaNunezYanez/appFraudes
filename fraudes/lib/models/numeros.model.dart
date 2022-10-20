import 'dart:convert';

import 'numero.model.dart';

class Numeros {
    Numeros({
        required this.numeros,
    });

    final List<Numero> numeros;

    factory Numeros.fromJson(String str) => Numeros.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Numeros.fromMap(Map<String, dynamic> json) => Numeros(
        numeros: List<Numero>.from(json["numeros"].map((x) => Numero.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "numeros": List<dynamic>.from(numeros.map((x) => x.toMap())),
    };
}

