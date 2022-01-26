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
    on<SignupUserNameChanged>(_onUsernameChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupPasswordConfirmChanged>(_onPasswordConfirmChanged);
    on<SignupMobileChanged>(_onMobileChanged);
    on<SignupMobileConfirmChanged>(_onMobileConfirmChanged);
  }
  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    SignupUserNameChanged event,
    Emitter<SignupState> emit,
  ) async {
    final username = Username.dirty(event.username);

    if (username.value.length >= 5) {
      try {
        // await _authenticationRepository.checkUserExistance(
        //   userName: username.value,
        // );
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
          state.passwordConfirm,
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
}
