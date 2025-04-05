import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/app_di.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Singleton Initialization
  AuthBlocSingleton.initialize(
    userRepository: AppDI.instance.userRepository,
  );
  // Because it uses [AuthBlocSingleton] internally,
  // its initialization must be later than [AuthBlocSingleton].
  AppRouter.initialize();

  runApp(const App());
}
