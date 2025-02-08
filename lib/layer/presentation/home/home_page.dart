import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/gaps.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Sizes.size16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (AuthBlocSingleton.instance.state as AuthAuthenticatedState)
                    .user
                    .toString(),
              ),
              Gaps.v20,
              ElevatedButton(
                onPressed: () =>
                    AuthBlocSingleton.instance.add(AuthSignoutEvent()),
                child: Text('Sign out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
