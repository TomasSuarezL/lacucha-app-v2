import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/Usuario.dart';

class PerfilCard extends StatelessWidget {
  const PerfilCard({
    Key key,
    this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlue[100],
                image: DecorationImage(
                  image: NetworkImage(usuario.avatarUrl),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.lightBlue[300], BlendMode.darken),
                ),
              ),
            ),
            Text(
              usuario.nombre,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(usuario.usuario)
          ],
        ),
      ),
    );
  }
}
