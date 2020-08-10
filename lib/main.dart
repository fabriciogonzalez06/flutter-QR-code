import 'package:flutter/material.dart';
import 'package:qrreadapp/src/pages/home_page.dart';
import 'package:qrreadapp/src/pages/mapa_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home':(BuildContext context)=> new HomePage(),
        'mapa':(BuildContext context)=> new MapaPage()
      },
      theme: ThemeData(
        primaryColor: Colors.cyanAccent
      ),
    );
  }
}