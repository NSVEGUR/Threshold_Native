// ignore_for_file: unused_field, unused_element

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:threshold_native/signup/models/models.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignupState()) {
    on<SignupSetRole>(_setSignupRole);
    on<SignupUserNameChanged>(_onUsernameChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupPasswordConfirmChanged>(_onPasswordConfirmChanged);
    on<SignupMobileChanged>(_onMobileChanged);
    on<SignupMobileConfirmChanged>(_onMobileConfirmChanged);
    on<SignupSubmitted>(_onSubmitted);
  }
  final AuthenticationRepository _authenticationRepository;

  void _setSignupRole(
    SignupSetRole event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(
      role: event.role,
    ));
  }

  void _onUsernameChanged(
    SignupUserNameChanged event,
    Emitter<SignupState> emit,
  ) async {
    final username = Username.dirty(event.username);

    if (username.value.length >= 5) {
      try {
        await _authenticationRepository.checkUserExistance(
          userName: username.value,
        );
        emit(state.copyWith(
          username: username,
          userError: '',
          status: Formz.validate(
            <FormzInput>[
              username,
              state.password,
              state.passwordConfirm,
            ],
          ),
        ));
      } on AuthFailure catch (e) {
        emit(state.copyWith(
          username: username,
          userError: e.message,
          status: Formz.validate(
            <FormzInput>[
              username,
              state.password,
              state.passwordConfirm,
            ],
          ),
        ));
      }
    } else {
      emit(state.copyWith(
        username: username,
        userError: '💥 Username must contain minimum 5 chars',
        status: Formz.validate(
          <FormzInput>[
            username,
            state.password,
            state.passwordConfirm,
          ],
        ),
      ));
    }
  }

  void _onPasswordChanged(
      SignupPasswordChanged event, Emitter<SignupState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate(
        <FormzInput>[
          password,
          state.username,
          state.passwordConfirm,
        ],
      ),
    ));
  }

  void _onPasswordConfirmChanged(
      SignupPasswordConfirmChanged event, Emitter<SignupState> emit) {
    final passwordConfirm = ConfirmedPassword.dirty(
      original: state.password,
      value: event.passwordConfirm,
    );
    emit(state.copyWith(
      passwordConfirm: passwordConfirm,
      status: Formz.validate(
        <FormzInput>[
          passwordConfirm,
          state.password,
          state.username,
        ],
      ),
    ));
  }

  void _onMobileChanged(SignupMobileChanged event, Emitter<SignupState> emit) {
    final mobile = Mobile.dirty(event.mobile);
    emit(state.copyWith(
      mobile: mobile,
      status: Formz.validate(
        <FormzInput>[
          state.username,
          state.password,
          state.passwordConfirm,
          mobile,
          state.mobileConfirm,
        ],
      ),
    ));
  }

  void _onMobileConfirmChanged(
      SignupMobileConfirmChanged event, Emitter<SignupState> emit) {
    final mobileConfirm = ConfirmedMobile.dirty(
      original: state.mobile,
      value: event.mobileConfirm,
    );
    emit(state.copyWith(
      mobileConfirm: mobileConfirm,
      status: Formz.validate(
        <FormzInput>[
          state.username,
          state.password,
          state.passwordConfirm,
          state.mobile,
          mobileConfirm,
        ],
      ),
    ));
  }

  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.signup(
          userName: state.username.value,
          password: state.password.value,
          mobile: state.mobile.value,
          role: state.role,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on AuthFailure catch (e) {
        emit(
          state.copyWith(
            signupError: e.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            signupError: 'Unknown Error Occured',
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }
}
