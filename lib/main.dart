import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Configuración de Tema',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ThemeSelectionPage(),
    );
  }
}

class ThemeSelectionPage extends StatefulWidget {
  @override
  _ThemeSelectionPageState createState() => _ThemeSelectionPageState();
}

class _ThemeSelectionPageState extends State<ThemeSelectionPage> {
  bool _isDarkTheme = false;
  String _userName = 'José Luis Curiel López';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
      _userName = prefs.getString('userName') ?? 'José Luis Curiel López';
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
    await prefs.setString('userName', _userName);
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkTheme = value;
    });
    _savePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.grey[900],
              cardColor: Colors.grey[850],
              appBarTheme: AppBarTheme(
                color: Colors.grey[900],
                elevation: 0,
              ),
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.grey[100],
              cardColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: Colors.blue[700],
                elevation: 0,
              ),
            ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Configuración de Tema',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Personaliza tu experiencia',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: _isDarkTheme ? Colors.white : Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Elige el tema que más te guste',
                    style: TextStyle(
                      fontSize: 16,
                      color: _isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _isDarkTheme ? Colors.grey[800] : Colors.grey[200],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      title: Text(
                        'Tema Oscuro',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: Icon(
                        Icons.nightlight_round,
                        color: _isDarkTheme ? Colors.blue : Colors.grey,
                      ),
                      trailing: Switch(
                        value: _isDarkTheme,
                        onChanged: _toggleTheme,
                        activeTrackColor: Colors.blue,
                        activeColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _isDarkTheme ? Colors.grey[800] : Colors.grey[200],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      title: Text(
                        'Tema Claro',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: Icon(
                        Icons.wb_sunny,
                        color: !_isDarkTheme ? Colors.blue : Colors.grey,
                      ),
                      trailing: Switch(
                        value: !_isDarkTheme,
                        onChanged: (value) => _toggleTheme(!value),
                        activeTrackColor: Colors.blue,
                        activeColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: _isDarkTheme ? Colors.grey[900] : Colors.blue[700],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                'Usuario: $_userName',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
