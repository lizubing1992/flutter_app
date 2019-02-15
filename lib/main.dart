import 'package:flutter/material.dart';
import 'package:flutter_app/constant/strings.dart';
import 'package:flutter_app/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringValues.APP_NAME,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blue,
        accentColor: const Color(0xFFF9AA33),
        errorColor: const Color(0xFFB00020),
        backgroundColor: Colors.grey[200]
      ),
      home: new HomePage(),
    );
  }

}

