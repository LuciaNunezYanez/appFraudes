// To parse this JSON data, do
//
//     final numero = numeroFromMap(jsonString);

import 'dart:convert';

class Numero {
    Numero({
        this.idNumero,
        required this.numeroTelefonico,
        this.claveEntidad,
        this.municipioNumero,
        this.codIdentidad,
        this.clasificacion,
        this.clasificacionUcib,
        this.numIncidencias,
        this.fechaSubida,
        this.idEntidad,
        this.nombreEntidad,
        this.idMunicipio,
        this.claveMunicipio,
        this.nombreMunicipio,
        this.idEstadoMunicipio,
        this.folioClasificacion,
        this.tituloClasificacion,
        this.descripcionClasificacion,
        this.tipoCatalogoClasificacion,
        this.idIdentidad,
        this.identidad,
    });

    int? idNumero;
    String numeroTelefonico;
    int? claveEntidad;
    int? municipioNumero;
    int? codIdentidad;
    int? clasificacion;
    String? clasificacionUcib;
    int? numIncidencias;
    DateTime? fechaSubida;
    int? idEntidad;
    String? nombreEntidad;
    int? idMunicipio;
    int? claveMunicipio;
    String? nombreMunicipio;
    int? idEstadoMunicipio;
    int? folioClasificacion;
    String? tituloClasificacion;
    String? descripcionClasificacion;
    String? tipoCatalogoClasificacion;
    int? idIdentidad;
    String? identidad;

    factory Numero.fromJson(String str) => Numero.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Numero.fromMap(Map<String, dynamic> json) => Numero(
        idNumero: json["id_numero"],
        numeroTelefonico: json["numero_telefonico"],
        claveEntidad: json["clave_entidad"],
        municipioNumero: json["municipio_numero"],
        codIdentidad: json["cod_identidad"],
        clasificacion: json["clasificacion"],
        clasificacionUcib: json["clasificacion_ucib"],
        numIncidencias: json["num_incidencias"],
        fechaSubida: DateTime.parse(json["fecha_subida"]),
        idEntidad: json["id_entidad"],
        nombreEntidad: json["nombre_entidad"],
        idMunicipio: json["id_municipio"],
        claveMunicipio: json["clave_municipio"],
        nombreMunicipio: json["nombre_municipio"],
        idEstadoMunicipio: json["id_estado_municipio"],
        folioClasificacion: json["folio_clasificacion"],
        tituloClasificacion: json["titulo_clasificacion"],
        descripcionClasificacion: json["descripcion_clasificacion"],
        tipoCatalogoClasificacion: json["tipo_catalogo_clasificacion"],
        idIdentidad: json["id_identidad"],
        identidad: json["identidad"],
    );

    Map<String, dynamic> toMap() => {
        "id_numero": idNumero,
        "numero_telefonico": numeroTelefonico,
        "clave_entidad": claveEntidad,
        "municipio_numero": municipioNumero,
        "cod_identidad": codIdentidad,
        "clasificacion": clasificacion,
        "clasificacion_ucib": clasificacionUcib,
        "num_incidencias": numIncidencias,
        "fecha_subida": fechaSubida,
        "id_entidad": idEntidad,
        "nombre_entidad": nombreEntidad,
        "id_municipio": idMunicipio,
        "clave_municipio": claveMunicipio,
        "nombre_municipio": nombreMunicipio,
        "id_estado_municipio": idEstadoMunicipio,
        "folio_clasificacion": folioClasificacion,
        "titulo_clasificacion": tituloClasificacion,
        "descripcion_clasificacion": descripcionClasificacion,
        "tipo_catalogo_clasificacion": tipoCatalogoClasificacion,
        "id_identidad": idIdentidad,
        "identidad": identidad,
    };
}
