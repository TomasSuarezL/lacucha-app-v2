import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc.dart';
import 'package:lacucha_app_v2/models/genero.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/services/usuario_service.dart';

import '../../constants.dart';

class EditarUsuario extends StatefulWidget {
  EditarUsuario({Key key}) : super(key: key);

  @override
  _EditarUsuarioState createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  UsuarioBloc _usuarioBloc;
  Usuario _currentUsuario;

  TextEditingController _fechaNacimientoController;

  bool _loading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
    _currentUsuario = (_usuarioBloc.state as UsuarioAuthenticated).usuario;
    _fechaNacimientoController =
        TextEditingController(text: DateFormat("dd/MM/yyyy").format(_currentUsuario.fechaNacimiento));
  }

  Widget _edtiarUsuarioLogin(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: secondaryColor,
      height: size.height * 0.3,
    );
  }

  List<Widget> _userFields(BuildContext context) {
    return [
      Container(
        margin: EdgeInsets.all(0.0),
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lightBlue[100],
          image: DecorationImage(
            image: NetworkImage(_currentUsuario.imgUrl ??
                "https://i0.wp.com/www.repol.copl.ulaval.ca/wp-content/uploads/2019/01/default-user-icon.jpg?fit=300%2C300"),
            fit: BoxFit.fitHeight,
            colorFilter: ColorFilter.mode(Colors.lightBlue[100], BlendMode.darken),
          ),
        ),
      ),
      SizedBox(
        height: 24.0,
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Email:", style: Theme.of(context).textTheme.subtitle1),
            Spacer(),
            Text("${_currentUsuario.email}", style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
      SizedBox(
        height: 16.0,
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Username:", style: Theme.of(context).textTheme.subtitle1),
            Spacer(),
            Text("${_currentUsuario.username}", style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    ];
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
        value: _currentUsuario.genero ?? Genero.masculino,
        elevation: 16,
        isExpanded: true,
        hint: Text("Genero"),
        underline: Container(),
        onChanged: (Genero newValue) {
          setState(() {
            _currentUsuario.genero = newValue ?? Genero.masculino;
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
                initialDate: _currentUsuario.fechaNacimiento ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            setState(() => _currentUsuario.fechaNacimiento = date);
            _fechaNacimientoController.text = DateFormat("dd/MM/yyyy").format(_currentUsuario.fechaNacimiento);
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
              initialValue: _currentUsuario.peso.toString(),
              onChanged: (value) => setState(() => _currentUsuario.peso = double.tryParse(value)),
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
              initialValue: _currentUsuario.altura.toString(),
              onChanged: (value) => setState(() => _currentUsuario.altura = double.tryParse(value)),
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
              var response = await UsuarioService.putUsuario(
                  _currentUsuario, await FirebaseAuth.instance.currentUser.getIdToken());
              if (response != null) {
                BlocProvider.of<UsuarioBloc>(context).add(UsuarioUpdated(usuario: response));
                Navigator.of(context).pop();
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Editar Usuario"),
      ),
      body: Container(
        padding: EdgeInsets.all(0.0),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  _edtiarUsuarioLogin(context),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 0), blurRadius: 16.0, color: Theme.of(context).primaryColorLight),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0, bottom: 16.0),
                    padding: EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          ..._userFields(context),
                          SizedBox(
                            height: 16.0,
                          ),
                          _textInput(context, _currentUsuario.nombre, "Nombre",
                              (value) => () => _currentUsuario.nombre = value),
                          SizedBox(
                            height: 16.0,
                          ),
                          _textInput(context, _currentUsuario.apellido, "Apellido",
                              (value) => () => _currentUsuario.apellido = value),
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
                          SizedBox(
                            height: 32.0,
                          ),
                          _guardarButton(context)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
