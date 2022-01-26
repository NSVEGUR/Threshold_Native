import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threshold_native/components/back_button.dart';
import 'package:threshold_native/constants.dart';
import 'package:threshold_native/signup/bloc/signup_bloc.dart';
import 'package:threshold_native/signup/views/signup_screen.dart';
import 'package:threshold_native/types/auth_type.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterForm extends StatelessWidget {
  final AuthType _authType;
  const RegisterForm({Key? key, required AuthType authType})
      : _authType = authType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {},
        child: Form(
          child: VStack(
            [
              const UserNameInput(),
              const PasswordInput(),
              const ConfirmPasswordInput(),
              HStack(
                [
                  backButton(context),
                  RegisterButton(authType: _authType),
                ],
              ).pOnly(top: 20, left: 50),
            ],
          ),
        ));
  }
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          onChanged: (val) {
            context.read<SignupBloc>().add(
                  SignupUserNameChanged(val),
                );
          },
          decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
            hintText: 'Enter your username',
            errorText: state.username.invalid || state.userError.isNotEmpty
                ? state.userError
                : null,
            helperText: state.username.valid && state.userError.isEmpty
                ? '✅ Username Available'
                : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.username.valid
                    ? Colors.green.shade400
                    : AppColors.primayColor,
                width: 3.0,
              ),
            ),
          ),
        ).py12().pOnly(left: 50);
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (val) {
            context.read<SignupBloc>().add(
                  SignupPasswordChanged(val),
                );
          },
          decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
            hintText: 'Enter your password',
            errorText: state.password.invalid
                ? '💥 Password must contain minimum 8 chars'
                : null,
            helperText: state.password.valid ? '✅ Valid Password' : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.password.valid
                    ? Colors.green.shade400
                    : AppColors.primayColor,
                width: 3.0,
              ),
            ),
          ),
        ).py12().pOnly(left: 50);
      },
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (val) {
            context.read<SignupBloc>().add(
                  SignupPasswordConfirmChanged(val),
                );
          },
          decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
            hintText: 'Confirm your password',
            errorText: state.passwordConfirm.invalid
                ? '💥 Passwords doesn\'t match'
                : null,
            helperText:
                state.passwordConfirm.valid ? '✅ Passwords match' : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.passwordConfirm.valid
                    ? Colors.green.shade400
                    : AppColors.primayColor,
                width: 3.0,
              ),
            ),
          ),
        ).py12().pOnly(left: 50);
      },
    );
  }
}

class RegisterButton extends StatelessWidget {
  final AuthType _authType;
  const RegisterButton({Key? key, required AuthType authType})
      : _authType = authType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            final AuthType arguments = _authType.copyWith(
              username: state.username.value,
              password: state.password.value,
              authenticationRepository: _authType.authenticationRepository,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupScreen(),
                settings: RouteSettings(
                  arguments: arguments,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.east_rounded,
            color: Colors.white,
          ),
        )
            .px20()
            .box
            .color(
              AppColors.primayColor,
            )
            .withRounded(value: 5)
            .make();
      },
    );
  }
}
