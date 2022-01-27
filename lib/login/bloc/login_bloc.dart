import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:threshold_native/login/models/models.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginSetRole>(_setLoginRole);
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginMobileChanged>(_onMobileChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _setLoginRole(
    LoginSetRole event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      role: event.role,
    ));
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate(<FormzInput>[
        username,
        state.password,
        state.mobile,
      ]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate(<FormzInput>[
        password,
        state.username,
        state.mobile,
      ]),
    ));
  }

  void _onMobileChanged(
    LoginMobileChanged event,
    Emitter<LoginState> emit,
  ) {
    final mobile = Mobile.dirty(event.mobile);
    emit(state.copyWith(
      mobile: mobile,
      status: Formz.validate(<FormzInput>[
        mobile,
        state.username,
        state.password,
      ]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.login(
          userName: state.username.value,
          password: state.password.value,
          mobile: state.mobile.value,
          role: state.role,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on AuthFailure catch (e) {
        emit(
          state.copyWith(
            errorMessage: e.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            errorMessage: 'Unknown Error Occured',
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }
}
