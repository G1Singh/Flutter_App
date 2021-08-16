import 'package:flutter/material.dart';
import 'Lists.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Movies',
      home: MovieList(),
    );
  }
}
