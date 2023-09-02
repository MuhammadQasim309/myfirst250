import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/Colors.dart';

void main (){
  runApp(MaterialApp(
    home: CalculatorApp() ,
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});


  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
// Variables

  double firstNum = 0.0;
  double secondNum = 0.0;
  var input= "";
  var output = "";
  var operation = "";
  var hideinput = false;
  var outputsize= 34.0;



  OnButtonClick(value){
    if (value == "AC"){
      input ="";
      output ="";
    }
    else if(value == "<"){
      if (input.isNotEmpty) {
        input = input.substring(0, input.length-1);
      }
    }
    else if (value == "="){
      if( input.isNotEmpty){
        var userInput = input ;
        userInput = input.replaceAll("x", "*");
        Parser P = Parser();
        Expression expression = P.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if( output.endsWith(".0")){
          output = output.substring(0, output.length-2);
        }
        input = output;
        hideinput = true;
        outputsize = 52;

      }
    }else {
      input= input+value ;
      hideinput = false;
      outputsize = 52;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[500],
      body: Column(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideinput? "" :  input,
                      style: const TextStyle(
                        fontSize: 55,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      output ,
                      style: TextStyle(
                        fontSize: outputsize,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    )

                  ],
                ),

              )
          ),
          Row(
            children: [
              button(text: "AC", buttonbgcolor: operatorColor, tColor: orangeColor,),
              button(text: "<", buttonbgcolor:  operatorColor, tColor: orangeColor,),
              button(text: "+/-"),
              button(text: "/")
            ],
          ),

          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x")
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-")
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+")
            ],
          ),
          Row(
            children: [
              button(text: "%", ),
              button(text: "0"),
              button(text: ".", ),
              button(text: "=", buttonbgcolor:  operatorColor,tColor: orangeColor,)
            ],
          )
        ],
      ),
    );
  }

  Widget button({
    text, tColor = Colors.white, buttonbgcolor = buttonColor,
  })
  {
    return Expanded(child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              padding: EdgeInsets.all(18),
              backgroundColor: buttonbgcolor
          ),
          onPressed:() => OnButtonClick(text),
          child:Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),)),
    )
    );
  }
}
