import 'package:dartz/dartz.dart';
import 'package:dbo_skin/domain/core/error.dart';
import 'package:dbo_skin/domain/core/failures.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  T getOrFail() {
    return value.fold(
      (f) => throw UnexpectedValueError(f),
      (r) => r,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  bool isValid() => value.isRight();

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
