import 'dart:convert';

RegistroIncidenteModel registroIncidenteFromJson(String str) =>
    RegistroIncidenteModel.fromJson(json.decode(str));

String registroIncidenteToJson(RegistroIncidenteModel data) =>
    json.encode(data.toJson());

class RegistroIncidenteModel {
  RegistroIncidenteModel({
    this.idVehiculo = 9,
    this.idUsuario = 1,
    this.indDescripcion,
    this.indFechaIncidente = "2020/10/25 10:10:10",
    this.indTipoIncidente,
    this.incidenteImage,
  });

  int idVehiculo;
  int idUsuario;
  String indDescripcion;
  String indFechaIncidente;
  String indTipoIncidente;
  String incidenteImage;

  factory RegistroIncidenteModel.fromJson(Map<String, dynamic> json) =>
      RegistroIncidenteModel(
        idVehiculo: json["ID_Vehiculo"],
        idUsuario: json["ID_Usuario"],
        indDescripcion: json["ind_Descripcion"],
        indFechaIncidente: json["ind_Fecha_Incidente"],
        indTipoIncidente: json["ind_Tipo_incidente"],
        incidenteImage: json["incidente_image"],
      );

  Map<String, dynamic> toJson() => {
        "ID_Vehiculo": idVehiculo,
        "ID_Usuario": idUsuario,
        "ind_Descripcion": indDescripcion,
        "ind_Fecha_Incidente": indFechaIncidente,
        "ind_Tipo_incidente": indTipoIncidente,
        "incidente_image": incidenteImage,
      };
}
