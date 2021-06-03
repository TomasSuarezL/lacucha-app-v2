import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/pages/home/editar_usuario.dart';

class PerfilCard extends StatelessWidget {
  const PerfilCard({
    Key key,
    this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Card(
            elevation: 8.0,
            margin: EdgeInsets.only(top: 150.0, left: 0.0, right: 0.0, bottom: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditarUsuario()),
                      ),
                      padding: EdgeInsets.all(24.0),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  usuario.nombre,
                  style: Theme.of(context).textTheme.headline6.apply(color: secondaryColor, fontWeightDelta: 300),
                ),
                Text(usuario.username, style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Altura", style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                              Spacer(),
                              Text(
                                "${usuario.altura} m.",
                                style: GoogleFonts.nunito(
                                  textStyle: Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Peso", style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                              Spacer(),
                              Text(
                                "${usuario.peso} Kgs.",
                                style: GoogleFonts.nunito(
                                  textStyle: Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Nivel", style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                          Spacer(),
                          Text(
                            "${usuario.nivel.descripcion}",
                            style: GoogleFonts.nunito(
                                textStyle: Theme.of(context).textTheme.headline5,
                                fontWeight: FontWeight.w100,
                                color: secondaryColorLight),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 140.0,
            height: 140.0,
            margin: EdgeInsets.only(top: 90),
            decoration: ShapeDecoration(shape: CircleBorder(), color: Theme.of(context).cardColor),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.lightBlue[100],
                  image: DecorationImage(
                    image: NetworkImage(usuario.imgUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.lightBlue[300], BlendMode.darken),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
