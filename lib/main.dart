import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:app2/slider/slider2.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<Calculator> {
  var userInput = '';
  var answer = '';

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF202020),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const Sliderscreen()),
            );
          },
        ),
        shadowColor: Colors.transparent,
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 1) { // This is the index for '+/-' button
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            // Toggle the sign of the current input
                            userInput = userInput.startsWith('-')
                                ? userInput.substring(1)
                                : '-' + userInput;
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    } else if (index == 19) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.orange[700]
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');
    finaluserinput = userInput.replaceAll('%', '/ 100 *');



    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
    if (answer.endsWith(".0")) {
      answer = answer.substring(0, answer.length - 2);
    }
  }

}

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  MyButton(
      {this.color, this.textColor, required this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1.0, color: Colors.black)

      ),
      child: GestureDetector(
        onTap: buttontapped,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}