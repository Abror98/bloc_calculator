part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorSuccess extends CalculatorState{
  final int result;

  CalculatorSuccess(this.result);
}

class CalculatorFaild extends CalculatorState{
  final String error;

  CalculatorFaild(this.error);
}


