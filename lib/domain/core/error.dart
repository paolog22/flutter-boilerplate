import 'package:dbo_skin/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    return Error.safeToString('Error string');
  }
}
