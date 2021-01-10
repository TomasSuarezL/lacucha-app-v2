import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc/mesociclo_bloc.dart';
import 'package:lacucha_app_v2/bloc/timer/bloc/timer_bloc.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc/usuario_bloc.dart';
import 'package:lacucha_app_v2/pages/history/history.dart';
import 'package:lacucha_app_v2/pages/home/home.dart';
import 'package:lacucha_app_v2/pages/settings.dart';
import 'package:lacucha_app_v2/pages/train/train.dart';
import 'package:lacucha_app_v2/services/ticker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerBloc>(create: (context) => TimerBloc(ticker: Ticker())),
        BlocProvider<UsuarioBloc>(create: (context) => UsuarioBloc()),
        BlocProvider<MesocicloBloc>(create: (context) => MesocicloBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'La Cucha',
        theme: ThemeData(
          textTheme: GoogleFonts.oxygenTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.grey[700], displayColor: Colors.grey[800]),
          ),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.grey[800],
          primaryColorDark: Colors.grey[900],
          primaryColorLight: Colors.grey[400],
          accentColor: Colors.lightBlueAccent[700],
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage(title: 'La Cucha'),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  Widget _getBottomNavTab(int index, Function changeTab) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage(title: 'Perfil', changeIndex: _changeBottomNavTab),
      TrainPage(title: 'Entrenar'),
      HistoryPage(title: 'Historial'),
      SettingsPage(title: 'Configuración'),
    ];

    return _widgetOptions.elementAt(index);
  }

  void _changeBottomNavTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getBottomNavTab(_selectedIndex, _changeBottomNavTab),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Entrenar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[850],
        unselectedItemColor: Colors.grey[500],
        onTap: _changeBottomNavTab,
      ),
    );
  }
}
