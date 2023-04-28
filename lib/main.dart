// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String infix = "0";
  String integers = "0";

  Widget buildButtonSame(String buttonText) {
    return ElevatedButton(
      child: Icon(Icons.menu, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.orange[700], // <-- Button color
        foregroundColor: Colors.red, // <-- Splash color
      ),
      onPressed: () {
        final parser = Parser();
        final infixExpression = infix;
        final expression = parser.parse(infixExpression);
        final resultDouble =
            expression.evaluate(EvaluationType.REAL, ContextModel());
        setState(() {
          integers = resultDouble.toString();
        });
        print('Infix: $infixExpression');
        print('Result: $integers');
      },
    );
  }

  Widget buildButtonFunction(String valueFunction) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        child: Text(
          valueFunction,
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
          ),
        ),
        onPressed: () {
          if (valueFunction == "Del") {
            String str = infix;
            String newStr = str.substring(0, str.length - 1);
            setState(() {
              infix = newStr;
            });
          } else if (valueFunction == "+") {
            setState(() {
              infix += '+';
            });
          } else if (valueFunction == "-") {
            setState(() {
              infix += '-';
            });
          } else if (valueFunction == "x") {
            setState(() {
              infix += '*';
            });
          } else if (valueFunction == "/") {
            setState(() {
              infix += '/';
            });
          } else if (valueFunction == "(") {
            setState(() {
              infix += '(';
            });
          } else if (valueFunction == ")") {
            setState(() {
              infix += ')';
            });
          } else if (valueFunction == "C") {
            setState(() {
              infix = '0';
              integers = '0';
            });
          }
        },
      ),
    );
  }

  Widget buildButtonNumber(String valueNumber) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        child: Text(
          valueNumber,
          style: const TextStyle(fontSize: 25, color: Colors.black),
        ),
        onPressed: () {
          print(valueNumber);
          if (infix == "0") {
            infix = "";
            setState(() {
              infix += valueNumber;
            });
          } else {
            setState(() {
              infix += valueNumber;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height / 3,
            alignment: Alignment.bottomRight,
            child: Text(
              infix,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Divider(
            color: Colors.black,
          )),
          Text(
            "= ${integers}",
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: Divider(
            color: Colors.black,
          )),
          SizedBox(
            height: height / 2,
            child: Column(
              children: [
                Row(
                  children: [
                    buildButtonFunction("("),
                    buildButtonFunction(")"),
                    buildButtonFunction("/"),
                    buildButtonFunction("Del"),
                  ],
                ),
                Row(
                  children: [
                    buildButtonNumber("7"),
                    buildButtonNumber("8"),
                    buildButtonNumber("9"),
                    buildButtonFunction("x"),
                  ],
                ),
                Row(
                  children: [
                    buildButtonNumber("4"),
                    buildButtonNumber("5"),
                    buildButtonNumber("6"),
                    buildButtonFunction("-"),
                  ],
                ),
                Row(
                  children: [
                    buildButtonNumber("1"),
                    buildButtonNumber("2"),
                    buildButtonNumber("3"),
                    buildButtonFunction("+"),
                  ],
                ),
                Row(
                  children: [
                    buildButtonFunction("C"),
                    buildButtonNumber("0"),
                    buildButtonNumber("00"),
                    buildButtonSame("="),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
