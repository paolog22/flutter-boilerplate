import 'package:dartz/dartz.dart';
import 'package:dbo_skin/domain/core/failures.dart';
import 'package:dbo_skin/domain/core/validators/password_validator.dart';
import 'package:dbo_skin/domain/core/value_object.dart';

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const Password._(this.value);

  factory Password(String email) {
    return Password._(validatePassword(email));
  }
}
