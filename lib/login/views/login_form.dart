import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:threshold_native/components/back_button.dart';
import 'package:threshold_native/login/bloc/login_bloc.dart';
import 'package:threshold_native/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginForm extends StatelessWidget {
  // final AuthenticationRepository _authenticationRepository;
  // final Roles _role;

  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text('Login Failure'),
                      Icon(Icons.error),
                    ],
                  ),
                ),
              );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text('Logging In...'),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    ],
                  ),
                ),
              );
          }
        },
        child: Form(
          child: VStack(
            [
              const UserNameInput(),
              const MobileInput(),
              const PasswordInput(),
              HStack(
                [
                  backButton(context),
                  IconButton(
                    onPressed: () {},
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
                      .make()
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
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          onChanged: (val) {
            context.read<LoginBloc>().add(
                  LoginUsernameChanged(val),
                );
          },
          decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
            hintText: 'Enter your username',
            errorText: state.username.invalid
                ? '💥 Username must contain minimum 5 chars'
                : null,
            helperText: state.username.valid ? '✅ Valid Username' : null,
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

class MobileInput extends StatelessWidget {
  const MobileInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          onChanged: (val) {
            context.read<LoginBloc>().add(
                  LoginMobileChanged(val),
                );
          },
          keyboardType: TextInputType.phone,
          decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
            hintText: 'Enter your mobile number',
            errorText: state.mobile.invalid ? '💥 Invalid mobile number' : null,
            helperText: state.mobile.valid ? '✅ Valid Mobile number' : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.mobile.valid
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
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (val) {
            context.read<LoginBloc>().add(
                  LoginPasswordChanged(val),
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
