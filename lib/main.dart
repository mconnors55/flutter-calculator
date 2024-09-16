import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '';
      } else if (text == '=') {
        try {
          final expression = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _result = ' = $result';
        } catch (e) {
          _result = ' Error';
        }
      } else {
        _expression += text;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _onPressed(text),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          padding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 134, 62, 3),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Calculator!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman'),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        fontFamily: 'Times New Roman'),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('C'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
