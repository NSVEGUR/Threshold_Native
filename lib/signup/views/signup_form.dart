import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:threshold_native/components/back_button.dart';
import 'package:threshold_native/constants.dart';
import 'package:threshold_native/dashboard/dashboard.dart';
import 'package:threshold_native/signup/bloc/signup_bloc.dart';
import 'package:threshold_native/types/auth_type.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupForm extends StatelessWidget {
  final AuthType _authType;
  const SignupForm({Key? key, required AuthType authType})
      : _authType = authType,
        super(key: key);

  void retrieveDataToState(BuildContext context) {
    context.read<SignupBloc>().add(
          SignupSetRole(
            _authType.role,
          ),
        );
    context.read<SignupBloc>().add(
          SignupUserNameChanged(
            _authType.username,
          ),
        );
    context.read<SignupBloc>().add(
          SignupPasswordChanged(
            _authType.password,
          ),
        );
    context.read<SignupBloc>().add(
          SignupPasswordConfirmChanged(
            _authType.password,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    retrieveDataToState(context);
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            final String errorMessage = state.signupError;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(errorMessage),
                      Icon(
                        Icons.error,
                        color: Colors.red.shade700,
                      ),
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
                      Text('Creating Account...'),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    ],
                  ),
                ),
              );
          }
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Successfully Created Account'),
                      Icon(
                        Icons.task_alt,
                        color: Colors.green.shade400,
                      ),
                    ],
                  ),
                ),
              );
            _authType.updateToken();
            Navigator.pushNamed(
              context,
              DashBoard.routeName,
            );
          }
        },
        child: Form(
          child: VStack(
            [
              const MobileInput(),
              const ConfirmMobileInput(),
              HStack(
                [
                  backButton(context),
                  const SignupButton(),
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
  const SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state.status.isValid) {
              context.read<SignupBloc>().add(
                    const SignupSubmitted(),
                  );
            } else {
              context.read<SignupBloc>().add(
                    SignupMobileChanged(
                      state.mobile.value,
                    ),
                  );
              context.read<SignupBloc>().add(
                    SignupMobileConfirmChanged(
                      state.mobileConfirm.value,
                    ),
                  );
            }
          },
          child: const Icon(
            Icons.east_rounded,
            color: Colors.white,
          )
              .py12()
              .px20()
              .box
              .color(
                AppColors.primayColor,
              )
              .withRounded(value: 5)
              .make(),
        );
      },
    );
  }
}
