import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/main.dart';
import 'package:lacucha_app_v2/models/usuario.dart';

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
                  image: NetworkImage(usuario.imgUrl),
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
            Text(usuario.username),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Altura:  ${usuario.altura} m.",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Peso:  ${usuario.peso} Kgs.",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nivel",
                            style: Theme.of(context).textTheme.subtitle2),
                        Text(
                          "${usuario.nivel}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .apply(color: secondaryColorLight),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
