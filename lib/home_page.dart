import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String userInput = '';
  String result = '0';

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '00', '0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'ماشین حساب',
          style: TextStyle(fontFamily: 'Vazir'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 30, color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    result,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blueAccent, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return buildButton(buttons[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return SizedBox(
      width: 65,
      height: 65,
      child: ElevatedButton(
        onPressed: () => onButtonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          backgroundColor: getButtonColor(buttonText),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Vazir',
          ),
        ),
      ),
    );
  }

  Color getButtonColor(String buttonText) {
    if (buttonText == '=')
      return Colors.green;
    else if (buttonText == 'C')
      return Colors.redAccent;
    else if (buttonText == 'DEL')
      return Colors.orange;
    else if (buttonText == '/' || buttonText == '*' || buttonText == '-' || buttonText == '+')
      return Colors.blueAccent;
    else
      return Colors.deepPurpleAccent;
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        userInput = '';
        result = '0';
      } else if (buttonText == 'DEL') {
        userInput = userInput.isNotEmpty ? userInput.substring(0, userInput.length - 1) : '';
      } else if (buttonText == '=') {
        calculate();
      } else {
        userInput += buttonText;
      }
    });
  }

  void calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(userInput.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();
    } catch (e) {
      result = 'خطا';
    }
  }
}
