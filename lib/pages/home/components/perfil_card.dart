import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/usuario.dart';

class PerfilCard extends StatelessWidget {
  const PerfilCard({
    Key key,
    this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Card(
            elevation: 8.0,
            margin: EdgeInsets.only(top: 70.0, left: 0.0, right: 0.0, bottom: 16.0),
            child: Column(
              children: [
                SizedBox(height: 76.0),
                Text(
                  usuario.nombre,
                  style: Theme.of(context).textTheme.headline5.apply(color: secondaryColor),
                ),
                Text(usuario.username, style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("Altura", style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                              SizedBox(height: 2.0),
                              Text(
                                "${usuario.altura} m.",
                                style: GoogleFonts.nunito(
                                  textStyle: Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Peso", style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                              SizedBox(height: 2.0),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Nivel", style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5)),
                          SizedBox(height: 2.0),
                          Text(
                            "${usuario.nivel.descripcion}",
                            style: Theme.of(context).textTheme.headline6.apply(color: secondaryColorLight),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 140.0,
            height: 140.0,
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
