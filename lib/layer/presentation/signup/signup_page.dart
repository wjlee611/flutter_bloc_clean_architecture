import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/gaps.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signup/bloc/signup_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signup/bloc/signup_state.dart';
import 'package:flutter_bloc_clean_architecture/widget/app_button.dart';
import 'package:flutter_bloc_clean_architecture/widget/app_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextField(
                        key: Key('username-field'),
                        controller:
                            context.read<SignupBloc>().usernameController,
                        title: 'Username',
                        textInputAction: TextInputAction.next,
                      ),
                      Gaps.v10,
                      AppTextField(
                        key: Key('email-field'),
                        controller: context.read<SignupBloc>().emailController,
                        title: 'Email',
                        textInputAction: TextInputAction.next,
                      ),
                      Gaps.v10,
                      AppTextField(
                        key: Key('password-field'),
                        controller:
                            context.read<SignupBloc>().passwordController,
                        title: 'Password',
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  key: Key('signup-button'),
                  text: 'Sign up',
                  isLoading: state.status == ELoadingStatus.loading,
                  onTap: () {
                    context.read<SignupBloc>().add(SignupOnTapSignupEvent());
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
