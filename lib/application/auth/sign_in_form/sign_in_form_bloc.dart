import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dbo_skin/domain/auth/auth_failure.dart';
import 'package:dbo_skin/domain/auth/email_address.dart';
import 'package:dbo_skin/domain/auth/i_auth_facade.dart';
import 'package:dbo_skin/domain/auth/password.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initialize());

  @override
  SignInFormState get initialState => SignInFormState.initialize();

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.email),
          authFailureOrSuccessOption: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.password),
          authFailureOrSuccessOption: none(),
        );
      },
      onRegister: (e) async* {
        yield* _eventCall(_authFacade.registerWithEmailAndPassword);
      },
      onSignIn: (e) async* {
        yield* _eventCall(_authFacade.signInWithEmailAndPassword);
      },
      onSignInWithGoogle: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        );

        final failureOrSuccess = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        );
      },
    );
  }

  Stream<SignInFormState> _eventCall(
      Future<Either<AuthFailure, Unit>> Function(
              {required EmailAddress email, required Password password})
          facadeCall) async* {
    Either<AuthFailure, Unit>? failureOrSuccess;

    if (state.emailAddress.isValid() && state.password.isValid()) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await facadeCall(
        email: state.emailAddress,
        password: state.password,
      );

      yield state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(failureOrSuccess),
      );
    }

    yield state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
