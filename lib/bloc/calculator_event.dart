part of 'calculator_bloc.dart';


@immutable
 class CalculatorEvent {
  final Operation operation;
  final int numberA;
  final int numberB;

  CalculatorEvent(this.operation, this.numberA, this.numberB);
}
