import 'package:dartz/dartz.dart';
import 'package:dbo_skin/domain/core/failures.dart';
import 'package:dbo_skin/domain/core/validators/email_validator.dart';
import 'package:dbo_skin/domain/core/value_object.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const EmailAddress._(this.value);

  factory EmailAddress(String email) {
    return EmailAddress._(validateEmailAddress(email));
  }
}
