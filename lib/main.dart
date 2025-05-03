import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ماشین حساب',
      home: SplashScreen(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _selectedOperator = '+';
  String _result = '';

  void _calculate() {
    try {
      double num1 = double.parse(_controller1.text);
      double num2 = double.parse(_controller2.text);
      double result = 0;

      switch (_selectedOperator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          result = num1 / num2;
          break;
        default:
          _result = 'لطفاً عملگر را انتخاب کنید';
          setState(() {});
          return;
      }

      _result = 'نتیجه: $result';
    } catch (e) {
      _result = 'خطا در ورود داده‌ها!';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ماشین حساب فانتزی'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                labelText: 'عدد اول',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                labelText: 'عدد دوم',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedOperator,
              items: ['+', '-', '*', '/']
                  .map((operator) => DropdownMenuItem(
                        child: Text(operator),
                        value: operator,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOperator = value!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('محاسبه کن!'),
            ),
            SizedBox(height: 16),
            Text(
              _result,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
