import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/api/my_api-.dart';
import 'package:qrreaderapp/src/utils/responsive.dart';
import 'package:qrreaderapp/src/widgets/input_text.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _nombres = '', _apellidos = '', _email = '', _password = '';

  _submit() async {
    final isOk = _formKey.currentState.validate();
    print("form isOk $isOk");
    if (isOk) {
      await MyAPI.instance.register(
        context,
        nombres: _nombres,
        apellidos: _apellidos,
        email: _email,
        password: _password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 10,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 360 : 300,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "NOMBRES",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _nombres = text;
                },
                validator: (text) {
                  if (text.trim().length < 3) {
                    return "Nombre Invalido";
                  }
                  return null;
                },
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "APELLIDOS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _apellidos = text;
                },
                validator: (text) {
                  if (text.trim().length < 3) {
                    return "Apellido Invalido ";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "CORREO ELECTRÓNICO",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (!text.contains("@")) {
                    return "Correo Invalido ";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "CONTRASEÑA",
                obscureText: true,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text.trim().length < 6) {
                    return "Contraseña Ivalida";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  onPressed: this._submit,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "¿Ya tienes una cuenta?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              SizedBox(height: responsive.dp(1)),
            ],
          ),
        ),
      ),
    );
  }
}
