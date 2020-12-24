import 'package:bloc_calculator/bloc/calculator_bloc.dart';
import 'package:bloc_calculator/bloc/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  final CalculatorBloc _calculatorBloc = CalculatorBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Bloc Calculator'),),
      body: BlocProvider<CalculatorBloc>(
        create: (context) => _calculatorBloc,
        child: BlocListener<CalculatorBloc, CalculatorState>(
          listener: (context, state){
            if(state is CalculatorFaild){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('${state.error}')));
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(controller: _controllerA,
                    decoration: InputDecoration(
                      labelText: 'Number A'
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _controllerB,
                    decoration: InputDecoration(
                      labelText: 'Number B'
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    children: <Widget>[
                      Expanded(child: RaisedButton(
                        child: Text('-'),
                        onPressed: (){
                          calculate(Operation.minus);
                        },
                      ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: RaisedButton(
                          child: Text('X'),
                          onPressed: () {
                            calculate(Operation.multiple);
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: RaisedButton(
                          child: Text('/'),
                          onPressed: () {
                            calculate(Operation.divide);
                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 8.0,),
                  BlocBuilder<CalculatorBloc, CalculatorState>(builder: (context, state){
                    if(state is CalculatorInitial){
                      return Text('Result: -');
                    } else if(state is CalculatorSuccess){
                      return Text('Result: ${state.result}');
                    } else if(state is CalculatorFaild){
                      return Text('Error: ${state.error}');
                    } else{
                      return Container();
                    }
                  })
                ],
              ),
            ),
          ),
      )

      ),
    );
  }

  void calculate(Operation operation) {
    int numberA = int.parse(_controllerA.text.toString());
    int numberB = int.parse(_controllerB.text.toString());
    _calculatorBloc.add(CalculatorEvent(operation, numberA, numberB));
  }


}
