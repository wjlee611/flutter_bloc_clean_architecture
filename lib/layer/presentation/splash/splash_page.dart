import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/gaps.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Splash Page'),
            Gaps.v4,
            const CircularProgressIndicator(),
            Gaps.v4,
            BlocBuilder<SplashBloc, SplashState>(
              builder: (context, state) => Text(state.statusText),
            ),
          ],
        ),
      ),
    );
  }
}
