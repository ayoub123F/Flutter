import 'package:first_app_bdcc/main-drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          'My App',
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text(
          'Hello IIBDCC',
          style: TextStyle(fontSize: 22, color: Colors.deepOrange),
        ),
      ),
    );
  }
}
