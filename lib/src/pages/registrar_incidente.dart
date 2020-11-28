import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrreaderapp/src/model/RegistroIncidenteModel.dart';
import 'package:qrreaderapp/src/provider/providerRegistrar.dart';

class RegistrarIncidente extends StatefulWidget {
  RegistrarIncidente({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TipoIncidente createState() => _TipoIncidente();
}

class _TipoIncidente extends State<RegistrarIncidente> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final registrarProvider = new RegistrarProvider();
  RegistroIncidenteModel registrar = new RegistroIncidenteModel();
  File foto;
  // var picker = ImagePicker();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Registrar Incidente',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.photo_size_select_actual,
              color: Colors.white,
            ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _mostrarFoto(),
                Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                ),
                _creartipo(),
                Padding(
                  padding: new EdgeInsets.only(top: 15.0),
                ),
                _crearDescripcion(),
                Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                _botonGuardar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _creartipo() {
    return Container(
        child: DropdownButtonFormField(
      value: registrar.indTipoIncidente,
      decoration: InputDecoration(
          hintText: "Tipo Incidente",
          labelText: "Tipo Incidente",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (value) => registrar.indTipoIncidente = value,
      validator: (value) => value == null ? 'Seleccione un Incidente' : null,
      items: <String>[
        '1.Pasarce la luz roja del semáforo',
        '2.Sobre carga de pasajeros',
        '3.Exceso de velocidad',
        '4.Exceso de tiempo de espera',
        '5.Maltrato físico del conductor',
        '6.Accidentes de tránsito'
      ].map((value) {
        return DropdownMenuItem(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          // incidente = val;
        });
      },
    ));
  }

  Widget _crearDescripcion() {
    return TextFormField(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        maxLines: 3,
        initialValue: registrar.indDescripcion,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            hintText: "Descripción",
            labelText: "Descripción",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        onSaved: (value) => registrar.indDescripcion = value,
        validator: (value) {
          if (value.length < 3) {
            return 'Ingrese la descripción del incidente';
          } else {
            return null;
          }
        });
  }

  Widget _botonGuardar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      color: Colors.lightBlueAccent,
      label: Text(
        'Guardar',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      icon: Icon(
        Icons.save,
        color: Colors.white,
      ),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    if (foto != null) {
      registrar.incidenteImage = await registrarProvider.subirImage(foto);
    }

    mostrarSnackbar('Registro guardado');
    print(registrar.indDescripcion);
    print(registrar.indTipoIncidente);
    print(registrar.idUsuario);
    print(registrar.indFechaIncidente);
    print(registrar.idVehiculo);
    print(registrar.incidenteImage);
    //Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto() {
    if (registrar.incidenteImage != null) {
      return FadeInImage(
        image: NetworkImage(registrar.incidenteImage),
        placeholder: AssetImage('assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async {
    procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    procesarImagen(ImageSource.camera);
  }

  Future procesarImagen(ImageSource origen) async {
    var pickedFile = await ImagePicker().getImage(source: origen);
    foto = File(pickedFile.path);
    if (pickedFile != null) {
      registrar.incidenteImage = null;
    } else {
      print('No image selected.');
    }
    setState(() {});
  }
}
