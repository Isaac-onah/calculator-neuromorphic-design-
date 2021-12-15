import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

String equation = "0";
String result = "0";
String expression = "";
double equaionFontSize = 38.0;
double resultFontSize = 48.0;

buttonPressed(String buttonText){
  setState((){
    if(buttonText == "C"){
    equation = "0";
    result = "0";
    equaionFontSize = 38.0;
    resultFontSize = 48.0;
    }else if(buttonText == "<"){
      equaionFontSize = 48.0;
      resultFontSize = 38.0;
     equation = equation.substring(0, equation.length -1);
    }else if(buttonText == "="){
      equaionFontSize = 38.0;
      resultFontSize = 48.0;

      expression = equation;
      expression = expression.replaceAll('x', '*');
      expression = expression.replaceAll('÷', '/');

      try{
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';

      }catch(e){
        result = "Error";
      }
    }
    else{
      equaionFontSize = 48.0;
      resultFontSize = 38.0;
      if (equation == "0"){
        equation = buttonText;
      }else{
          equation = equation + buttonText;
    }}
  });
}


  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Colors.white, width:1, style: BorderStyle.solid)
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText), child: Text(buttonText, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal,color: Colors.white),)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
         Expanded(
           flex: 2,
           child: SingleChildScrollView(
             child: Container(
               alignment: Alignment.centerRight,
               padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
               child:    Text(equation, style: TextStyle(fontSize: equaionFontSize),),
             ),
           ),
         ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child:  Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Divider(  
            height: 2,
          ),
          Expanded(
            flex:3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child:Table(
                      children:[
                        TableRow(
                      children: [
                        buildButton("C",1,Colors.redAccent),
                        buildButton("<",1,Colors.blue),
                        buildButton("÷",1,Colors.blue),
                      ]
                  ),
                        TableRow(
                            children: [
                              buildButton("7",1,Colors.black54),
                              buildButton("8",1,Colors.black54),
                              buildButton("9",1,Colors.black54),
                            ]
                        ),
                        TableRow(
                            children: [
                              buildButton("4",1,Colors.black54),
                              buildButton("5",1,Colors.black54),
                              buildButton("6",1,Colors.black54),
                            ]
                        ),
                        TableRow(
                            children: [
                              buildButton("1",1,Colors.black54),
                              buildButton("2",1,Colors.black54),
                              buildButton("3",1,Colors.black54),
                            ]
                        ),
                        TableRow(
                            children: [
                              buildButton(".",1,Colors.redAccent),
                              buildButton("0",1,Colors.blue),
                              buildButton("00",1,Colors.blue),
                            ]
                        ),
                      ]
                  )
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child:Table(
                        children:[
                          TableRow(
                              children: [
                                buildButton("x",1,Colors.blue),
                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("-",1,Colors.blue),
                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("+",1,Colors.blue),
                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("=",2,Colors.blue),
                              ]
                          ),

                        ])
                )
              ],
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}