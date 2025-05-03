import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
      } else if (buttonText == "=") {
        try {
          output = (double.parse(output)).toString();
        } catch (e) {
          output = "خطا";
        }
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.all(20),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24, fontFamily: 'Vazir'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text('ماشین حساب', style: TextStyle(fontFamily: 'Vazir')),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Text(
                output,
                style: TextStyle(fontSize: 48, fontFamily: 'Vazir'),
              ),
            ),
          ),
          Divider(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("7", Colors.deepPurple),
                  buildButton("8", Colors.deepPurple),
                  buildButton("9", Colors.deepPurple),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("4", Colors.deepPurple),
                  buildButton("5", Colors.deepPurple),
                  buildButton("6", Colors.deepPurple),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("1", Colors.deepPurple),
                  buildButton("2", Colors.deepPurple),
                  buildButton("3", Colors.deepPurple),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton(".", Colors.deepPurple),
                  buildButton("0", Colors.deepPurple),
                  buildButton("00", Colors.deepPurple),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("C", Colors.redAccent),
                  buildButton("=", Colors.green),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
