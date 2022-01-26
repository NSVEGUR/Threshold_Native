import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threshold_native/components/back_button.dart';
import 'package:threshold_native/constants.dart';
import 'package:threshold_native/signup/bloc/signup_bloc.dart';
import 'package:threshold_native/types/auth_type.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupForm extends StatelessWidget {
  final AuthType _authType;
  const SignupForm({Key? key, required AuthType authType})
      : _authType = authType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {},
        child: Form(
          child: VStack(
            [
              const MobileInput(),
              const ConfirmMobileInput(),
              HStack(
                [
                  backButton(context),
                  SignupButton(
                    authType: _authType,
                  ),
                ],
              ).pOnly(top: 20),
            ],
          ),
        ));
  }
}

class MobileInput extends StatelessWidget {
  const MobileInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (val) {
            context.read<SignupBloc>().add(
                  SignupMobileChanged(val),
                );
          },
          decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
            hintText: 'Enter your mobile number',
            errorText: state.mobile.invalid ? '💥 Invalid Mobile Number' : null,
            helperText: state.mobile.valid ? '✅ Valid Mobile Number' : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.mobile.valid
                    ? Colors.green.shade400
                    : AppColors.primayColor,
                width: 3.0,
              ),
            ),
          ),
        ).py12();
      },
    );
  }
}

class ConfirmMobileInput extends StatelessWidget {
  const ConfirmMobileInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (val) {
            context.read<SignupBloc>().add(
                  SignupMobileConfirmChanged(val),
                );
          },
          decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
            hintText: 'Confirm your mobile number',
            errorText: state.mobileConfirm.invalid
                ? '💥 Mobile numbers doesn\'t match'
                : null,
            helperText:
                state.mobileConfirm.valid ? '✅ Mobile numbers match' : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.mobileConfirm.valid
                    ? Colors.green.shade400
                    : AppColors.primayColor,
                width: 3.0,
              ),
            ),
          ),
        ).py12();
      },
    );
  }
}

class SignupButton extends StatelessWidget {
  final AuthType _authType;
  const SignupButton({Key? key, required AuthType authType})
      : _authType = authType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            // ignore: unused_local_variable
            final AuthType arguments = _authType.copyWith(
              username: state.username.value,
              password: state.password.value,
              authenticationRepository: _authType.authenticationRepository,
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
