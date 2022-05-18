import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';



const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkMode = false;

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
      backgroundColor: darkMode ? colorDark : colorLight,
      appBar: AppBar(
        backgroundColor: darkMode ? colorDark : colorLight,
        title: Text("Calc"),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  darkMode ? darkMode = false : darkMode = true;
                });
              },
              child: _switchMode()),
        ],
      ),
      body: SafeArea(
        child: Column(
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
              flex:5,
              child: Column(
                children: [
                  Container(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonOval(title: 'sin'),
                          _buttonOval(title: 'cos'),
                          _buttonOval(title: 'tan'),
                          _buttonOval(title: '%')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(
                              title: 'C',
                              textColor:
                              darkMode ? Colors.green : Colors.redAccent),
                          _buttonRounded(title: '('),
                          _buttonRounded(title: ')'),
                          _buttonRounded(
                              title: '/',
                              textColor: darkMode ? Colors.green : Colors.redAccent)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '7'),
                          _buttonRounded(title: '8'),
                          _buttonRounded(title: '9'),
                          _buttonRounded(
                              title: 'x',
                              textColor: darkMode ? Colors.green : Colors.redAccent)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '4'),
                          _buttonRounded(title: '5'),
                          _buttonRounded(title: '6'),
                          _buttonRounded(
                              title: '-',
                              textColor: darkMode ? Colors.green : Colors.redAccent)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '1'),
                          _buttonRounded(title: '2'),
                          _buttonRounded(title: '3'),
                          _buttonRounded(
                              title: '+',
                              textColor: darkMode ? Colors.green : Colors.redAccent)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonRounded(title: '0'),
                          _buttonRounded(title: ','),
                          _buttonRounde(
                              icon: Icons.backspace_outlined,
                              iconColor:
                              darkMode ? Colors.green : Colors.redAccent),
                          _buttonRounded(
                              title: '=',
                              textColor: darkMode ? Colors.green : Colors.redAccent)
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget _buttonRounded(
      { String? title,
        double padding = 17,
        IconData? icon,
        Color? iconColor,
        Color? textColor}) {
    return FlatButton(
      onPressed: () => buttonPressed(title!),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: NeuContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(padding),
          child: Container(
            width: padding * 2,
            height: padding * 2,
            child: Center(
                child: title != null
                    ? Text(
                  '$title',
                  style: TextStyle(
                      color: textColor != null
                          ? textColor
                          : darkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 30),
                )
                    : Icon(
                  icon,
                  color: iconColor,
                  size: 30,
                )),
          ),
        ),
      ),
    );
  }

  Widget _buttonRounde(
      { double padding = 17,
        IconData? icon,
        Color? iconColor,
        Color? textColor}) {
    return FlatButton(
      onPressed: () => buttonPressed("<"),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: NeuContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(padding),
          child: Container(
            width: padding * 2,
            height: padding * 2,
            child: Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 30,
                )),
          ),
        ),
      ),
    );
  }

  Widget _buttonOval({required String title, double padding = 17}) {
    return  FlatButton(
    onPressed: () => buttonPressed(title),
      child: NeuContainer(
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(50),
        padding:
        EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: Container(
          width: padding * 2,
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
  Widget _switchMode() {
    return NeuContainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.wb_sunny,
            color: darkMode ? Colors.grey : Colors.redAccent,
          ),
          Icon(
            Icons.nightlight_round,
            color: darkMode ? Colors.green : Colors.grey,
          ),
        ]),
      ),
    );
  }
}

class NeuContainer extends StatefulWidget {
  final bool darkMode;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  NeuContainer(
      {this.darkMode = false, required this.child, required this.borderRadius, required this.padding});

  @override
  _NeuContainerState createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
            color: darkMode ? colorDark : colorLight,
            borderRadius: widget.borderRadius,
            boxShadow: _isPressed
                ? null
                : [
              BoxShadow(
                color:
                darkMode ? Colors.black54 : Colors.blueGrey.shade200,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                  color:
                  darkMode ? Colors.blueGrey.shade700 : Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0)
            ]),
        child: widget.child,
      ),
    );
  }
}