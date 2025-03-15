import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/gaps.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signin/bloc/signin_state.dart';
import 'package:flutter_bloc_clean_architecture/widget/app_button.dart';
import 'package:flutter_bloc_clean_architecture/widget/app_text_field.dart';
import 'package:go_router/go_router.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rootCtx = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: BlocBuilder<SigninBloc, SigninState>(
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
                        key: Key('email-field'),
                        controller: context.read<SigninBloc>().emailController,
                        title: 'Email',
                        textInputAction: TextInputAction.next,
                      ),
                      Gaps.v10,
                      AppTextField(
                        key: Key('password-field'),
                        controller:
                            context.read<SigninBloc>().passwordController,
                        title: 'Password',
                        textInputAction: TextInputAction.done,
                      ),
                      Gaps.v20,
                      if (MediaQuery.viewInsetsOf(rootCtx).bottom <= 100)
                        GestureDetector(
                          key: Key('create-account'),
                          onTapUp: (_) {
                            context.push(AppRouter.signup);
                          },
                          child: Text(
                            '...or create an account',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  key: Key('signin-button'),
                  text: 'Sign in',
                  isLoading: state.status == ELoadingStatus.loading,
                  onTap: () {
                    context.read<SigninBloc>().add(SigninOnTapSigninEvent());
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
