import 'package:flutter/material.dart';
import 'package:cw_calculator/Calculator.dart';

void main() {
  runApp(MainCalculator());
}

class MainCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primaryColor: Colors.amber),
      home: Calculator(),
    );
  }
}
