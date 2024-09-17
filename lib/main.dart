import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return SizedBox(
      width: 80, // Width of the button
      height: 80, // Height of the button
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: txtcolor, // Text color of the button
          backgroundColor: btncolor, // Background color of the button
          shape: CircleBorder(), // Circular shape
          padding: EdgeInsets.zero, // Remove extra padding
        ),
        child: Center(
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: 35, // Adjust text size as needed
            ),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Calculator", style: TextStyle(color: Colors.white),), centerTitle: true, backgroundColor: Colors.black,),
      body: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //calculator display
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: const EdgeInsets.all(10.0),
                  child: Text(text ?? " " ,
                  textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white, fontSize: 100),
                  ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // here button function will be called where we will pass some arguments
                  calcButton("AC", Colors.grey, Colors.black),
                  calcButton("+/-", Colors.grey, Colors.black),
                  calcButton("%", Colors.grey, Colors.black),
                  calcButton("/", Colors.amber, Colors.white),
                ],
              ),
             SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button function will be called where we will pass some arguments
                calcButton("7", Colors.grey[800]!, Colors.white),
                calcButton("8", Colors.grey[800]!,Colors.white),
                calcButton("9", Colors.grey[800]!, Colors.white),
                calcButton("x", Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button function will be called where we will pass some arguments
                calcButton("4", Colors.grey[800]!, Colors.white),
                calcButton("5", Colors.grey[800]!, Colors.white),
                calcButton("6", Colors.grey[800]!, Colors.white),
                calcButton("-", Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button function will be called where we will pass some arguments
                calcButton("1", Colors.grey[800]!, Colors.white),
                calcButton("2", Colors.grey[800]!, Colors.white),
                calcButton("3", Colors.grey[800]!, Colors.white),
                calcButton("+", Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // This is button Zero
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[850], // Background color of the button
                    shape: StadiumBorder(), // Stadium-shaped border
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20), // Custom padding
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
                calcButton(".", Colors.grey[800]!, Colors.white),
                calcButton("=", Colors.amber, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

  //logic for calculator
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }


}
