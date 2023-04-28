import 'package:math_expressions/math_expressions.dart';

void main() {
  final parser = Parser();

  // Provide an infix expression
  // final infixExpression = '2+(20-11)+15*3/2';
  final infixExpression = '20-11+15*3/2';

  // Parse the expression
  final expression = parser.parse(infixExpression);

  // Evaluate the expression
  final result = expression.evaluate(EvaluationType.REAL, ContextModel());

  print('Infix: $infixExpression');
  print('Result: $result');
}
