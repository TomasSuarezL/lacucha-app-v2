import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _emptyCacheSetting(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
        ),
        child: Text("Borrar Cache"),
      ),
      onTap: () async {
        try {
          await DefaultCacheManager().emptyCache();
        } catch (e) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(backgroundColor: Colors.red[200], content: Text("Error al borrar la cache")));
        }

        _scaffoldKey.currentState
            .showSnackBar(SnackBar(backgroundColor: Colors.lightGreen[200], content: Text("Cache borrada")));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [_emptyCacheSetting(context)],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
