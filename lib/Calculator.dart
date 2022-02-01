import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  // This method restes calculator state
  clearState() {
    setState(() {
      equation = "0";
      result = "0";
    });
  }

  // This method deletes previous input
  deletePrev() {
    setState(() {
      equation = equation.substring(0, equation.length - 1);
      if (equation == "") {
        equation = "0";
      }
    });
  }

  getResult() {
    setState(() {
      expression = equation;
      expression = expression.replaceAll('x', '*');
      expression = expression.replaceAll('/', '/');

      try {
        Parser p = new Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      } catch (e) {
        result = "Error";
      }
    });
  }

  buttonPressed(String buttonText) {
    setState(() {
      // Avoid situation on initial button press -> 01,02,03 etc.
      if (equation == "0") {
        equation = '';
      }
      equation = equation + buttonText;
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      double width, handlePressButton, bool isAction) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      width: MediaQuery.of(context).size.width * 0.25 * width,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: const BorderSide(
              color: Colors.white38,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        onPressed: isAction
            ? () => handlePressButton()
            : () => handlePressButton(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: const TextStyle(fontSize: 38)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: const TextStyle(fontSize: 48)),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(children: [
                      buildButton("C", 1, Colors.black12, 2, clearState, true),
                      buildButton("<-", 1, Colors.black12, 1, deletePrev, true),
                      buildButton(
                          "*", 1, Colors.orange, 1, buttonPressed, false),
                    ]),
                    Row(children: [
                      buildButton(
                          "7", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "8", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "9", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "/", 1, Colors.orange, 1, buttonPressed, false),
                    ]),
                    Row(children: [
                      buildButton(
                          "4", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "5", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "6", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "+", 1, Colors.orange, 1, buttonPressed, false),
                    ]),
                    Row(children: [
                      buildButton(
                          "1", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "2", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "3", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "-", 1, Colors.orange, 1, buttonPressed, false),
                    ]),
                    Row(children: [
                      buildButton(
                          ".", 1, Colors.black38, 1, buttonPressed, false),
                      buildButton(
                          "0", 1, Colors.black38, 2, buttonPressed, false),
                      buildButton("=", 1, Colors.orange, 1, getResult, true),
                    ])
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
