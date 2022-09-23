import 'package:dartz/dartz.dart';
import 'package:dbo_skin/domain/core/failures.dart';

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  }

  return left(ValueFailure.shortPassword(failedValue: input));
}
