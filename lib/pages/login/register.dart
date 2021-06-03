import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:lacucha_app_v2/bloc/usuario/bloc.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/genero.dart';
import 'package:lacucha_app_v2/models/nivel.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/services/usuario_service.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<Sesion> futureSesion;

  UsuarioBloc _usuarioBloc;
  String _username;
  String _nombre;
  String _apellido;
  DateTime _fechaNacimiento;
  final _fechaNacimientoController = TextEditingController();
  Genero _genero;
  double _peso;
  double _altura;

  bool _loading;

  User _currentUser;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loading = false;
    _usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
    _currentUser = FirebaseAuth.instance.currentUser;
    _peso = 0;
    _altura = 0;
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Cancelar Registro?'),
            content: new Text('Se van a perder los datos ingresados'),
            actions: <Widget>[
              new RaisedButton(
                onPressed: () => Navigator.of(context).pop(false),
                color: Colors.red[200],
                child: Text("No"),
              ),
              new RaisedButton(
                onPressed: () {
                  _usuarioBloc.add(UsuarioLogOut());
                  Navigator.of(context).pop(true);
                },
                color: Colors.lightGreen[200],
                child: Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _loginHeader(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Registro", style: Theme.of(context).textTheme.headline4.apply(color: Colors.white, fontWeightDelta: 0)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24.0),
    );
  }

  Widget _textInput(BuildContext context, String field, String label, Function setField) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        initialValue: field,
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
            labelText: label),
        onChanged: (value) => setState((setField(value))),
        validator: (value) {
          if (value.isEmpty) {
            return 'Por favor ingrese un valor';
          }
          return null;
        },
      ),
    );
  }

  Widget _generoInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      color: Theme.of(context).primaryColorLight.withOpacity(0.2),
      child: DropdownButton<Genero>(
        value: _genero,
        elevation: 16,
        isExpanded: true,
        hint: Text("Genero"),
        underline: Container(),
        onChanged: (Genero newValue) {
          setState(() {
            _genero = newValue;
          });
        },
        items: [Genero.masculino, Genero.femenino, Genero.otro].map<DropdownMenuItem<Genero>>((Genero value) {
          return DropdownMenuItem<Genero>(
            value: value,
            child: Text(value.descripcion),
          );
        }).toList(),
      ),
    );
  }

  Widget _alturaYPesoInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
                  labelText: "Peso",
                  suffix: Text("Kg.")),
              initialValue: "",
              onChanged: (value) => setState(() => _peso = double.tryParse(value)),
              validator: (value) {
                if (double.tryParse(value) == 0) {
                  return "Ingresar un Peso válido";
                }
                return null;
              },
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
                  labelText: "Altura",
                  suffix: Text("m.")),
              initialValue: "",
              onChanged: (value) => setState(() => _altura = double.tryParse(value)),
              validator: (value) {
                if (double.tryParse(value) == 0) {
                  return "Ingresar una altura válida";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _fechaInput(BuildContext context) {
    return Container(
      child: TextFormField(
        readOnly: true,
        keyboardType: TextInputType.text,
        controller: _fechaNacimientoController,
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
            labelText: "Fecha Nacimiento"),
        onTap: () async {
          try {
            var date = await showDatePicker(
                context: context,
                initialDate: _fechaNacimiento ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            setState(() => _fechaNacimiento = date);
            _fechaNacimientoController.text = DateFormat("dd/MM/yyyy").format(_fechaNacimiento);
          } catch (e) {}
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Por favor ingrese un valor';
          }
          return null;
        },
      ),
    );
  }

  Widget _guardarButton(BuildContext context) {
    return RaisedButton(
        child: Text(
          "Guardar",
          style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.white, fontWeightDelta: 100),
        ),
        color: secondaryColorLight,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
        onPressed: () async {
          setState(() {
            _loading = true;
          });

          if (_formKey.currentState.validate()) {
            try {
              Usuario nuevoUsuario = Usuario(
                  uuid: _currentUser.uid,
                  nombre: _nombre,
                  apellido: _apellido,
                  email: _currentUser.email,
                  username: _username,
                  imgUrl: _currentUser.photoURL,
                  fechaNacimiento: _fechaNacimiento,
                  genero: _genero,
                  nivel: Nivel.principiante,
                  altura: _altura,
                  peso: _peso);

              var response = await UsuarioService.postUsuario(nuevoUsuario, await _currentUser.getIdToken());
              if (response != null) {
                // Usuario autenticado y guardado en BD, ingresar a app
                _usuarioBloc.add(UsuarioLogIn(uuid: _currentUser.uid));
              } else {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(backgroundColor: Colors.red[200], content: Text("No se pudo guardar el Usuario")));
              }
            } catch (e) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(backgroundColor: Colors.red[200], content: Text(e.message["message"]?.toString())));
            }
          }

          setState(() {
            _loading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Log In"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cerrar Sesión',
                style: Theme.of(context).textTheme.button.apply(color: Colors.white70),
              ),
              onPressed: () {
                _usuarioBloc.add(UsuarioLogOut());
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(0.0),
          color: secondaryColorDark,
          child: _loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _loginHeader(context),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0), blurRadius: 0.0, color: Theme.of(context).primaryColorLight),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 0.0),
                        padding: EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.all(0.0),
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.lightBlue[100],
                                  image: DecorationImage(
                                    image: NetworkImage(_currentUser.photoURL ??
                                        "https://i0.wp.com/www.repol.copl.ulaval.ca/wp-content/uploads/2019/01/default-user-icon.jpg?fit=300%2C300"),
                                    fit: BoxFit.fitHeight,
                                    colorFilter: ColorFilter.mode(Colors.lightBlue[100], BlendMode.darken),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${_currentUser.email}", style: Theme.of(context).textTheme.subtitle1),
                                    ],
                                  )),
                              SizedBox(
                                height: 24.0,
                              ),
                              _textInput(context, _username, "Username", (value) => () => _username = value),
                              SizedBox(
                                height: 16.0,
                              ),
                              _textInput(context, _nombre, "Nombre", (value) => () => _nombre = value),
                              SizedBox(
                                height: 16.0,
                              ),
                              _textInput(context, _apellido, "Apellido", (value) => () => _apellido = value),
                              SizedBox(
                                height: 16.0,
                              ),
                              _generoInput(context),
                              SizedBox(
                                height: 16.0,
                              ),
                              _fechaInput(context),
                              SizedBox(
                                height: 16.0,
                              ),
                              _alturaYPesoInput(context),
                              Container(margin: EdgeInsets.only(top: 24.0), child: _guardarButton(context)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
