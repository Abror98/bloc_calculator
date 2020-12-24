import 'dart:async';

import 'package:bloc_calculator/bloc/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(null);

  @override
  CalculatorState get initialState {
    return CalculatorInitial();
  }



  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    int result = 0;
    switch(event.operation){
      case Operation.plus:
        result = event.numberA + event.numberB;
        yield CalculatorSuccess(result);
        break;
      case Operation.minus:
        result = event.numberA - event.numberB;
        yield CalculatorSuccess(result);
        break;
      case Operation.multiple:
        result = event.numberA * event.numberB;
        yield CalculatorSuccess(result);
        break;
      case Operation.divide:
        result = event.numberA ~/ event.numberB;
        yield CalculatorSuccess(result);
        break;
        default:
        yield CalculatorFaild('Unknown operation');

      }

  }
}
