import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacucha_app_v2/bloc/usuario/bloc.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/services/login_services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<Sesion> futureSesion;

  UsuarioBloc _usuarioBloc;
  String _username;
  String _password;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loading;

  @override
  void initState() {
    _loading = false;
    _usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
    super.initState();
  }

  Widget _loginHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.85,
            focal: Alignment.center,
            focalRadius: 0.3,
            colors: [Colors.white, Theme.of(context).primaryColorDark]),
        image: DecorationImage(
          image: AssetImage("assets/Perro.jpeg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(secondaryColor.withOpacity(0.5), BlendMode.colorBurn),
        ),
      ),
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("La", style: Theme.of(context).textTheme.headline4.apply(color: Colors.white, fontWeightDelta: 300)),
          SizedBox(width: 16),
          Text("Cucha", style: Theme.of(context).textTheme.headline4.apply(color: Colors.white, fontWeightDelta: 300)),
        ],
      ),
    );
  }

  Widget _usernameInput(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        initialValue: _username,
        decoration: InputDecoration(prefixIcon: Icon(Icons.person), filled: true, labelText: "Username"),
        onChanged: (value) => setState(() => _username = value),
        validator: (value) {
          if (value.isEmpty) {
            return 'Por favor ingrese el usuario';
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordInput(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        initialValue: _password,
        decoration: InputDecoration(prefixIcon: Icon(Icons.lock), filled: true, labelText: "Password"),
        obscureText: true,
        onChanged: (value) => setState(() => _password = value),
        validator: (value) {
          if (value.isEmpty) {
            return 'Por favor ingrese la clave';
          }
          return null;
        },
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
            child: Text(
              "Ingresar con Email",
              style: Theme.of(context).textTheme.button.apply(color: Colors.white, fontWeightDelta: 0),
            ),
            color: secondaryColorLight,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            onPressed: () async {
              setState(() {
                _loading = true;
              });
              if (_formKey.currentState.validate()) {
                try {
                  String error = await AuthenticationService.signInWithEmail(username: _username, password: _password);
                  if (error != null) {
                    _usuarioBloc.add(UsuarioFirebaseError(mensaje: error));
                  }
                } catch (e) {
                  _usuarioBloc.add(UsuarioFirebaseError(mensaje: "Completar los Campos"));
                }
              }
              setState(() {
                _loading = false;
              });
            }),
      ],
    );
  }

  Widget _loginWithGoogleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(right: 24.0),
                  height: 48.0,
                  width: 48.0,
                  child: Image.asset("assets/g-logo.png"),
                ),
                Text(
                  "Ingresar con Google",
                  style: Theme.of(context).textTheme.button.apply(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            color: googleBackgroundColor,
            padding: EdgeInsets.only(top: 1.0, bottom: 1.0, left: 1.0, right: 24.0),
            onPressed: () async {
              setState(() {
                _loading = true;
              });
              String error = await AuthenticationService.signInWithGoogle();
              if (error != null) {
                _usuarioBloc.add(UsuarioFirebaseError(mensaje: error));
                setState(() {
                  _loading = false;
                });
              }
            }),
      ],
    );
  }

  void _errorMessage(BuildContext context) {
    UsuarioState state = _usuarioBloc.state;
    if (state is UsuarioUnauthenticated) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red[200],
          content: Text(
            "${state.mensaje}",
            style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.white70),
          )));
    } else if (state is UsuarioFailure) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[200],
          content: Text(
            "Error de conexión con el servidor.",
            style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.white70),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loading) _errorMessage(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Log In"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _loginHeader(context),
          _loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 0), blurRadius: 0.0, color: Theme.of(context).primaryColorLight),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 166.0, left: 16.0, right: 16.0),
                  padding: EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "Ingresar",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        _usernameInput(context),
                        SizedBox(
                          height: 32.0,
                        ),
                        _passwordInput(context),
                        SizedBox(
                          height: 32.0,
                        ),
                        _loginButton(context),
                        Divider(
                          height: 48.0,
                          thickness: 1,
                        ),
                        _loginWithGoogleButton(context),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
