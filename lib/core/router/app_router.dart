import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/core/router/page_transition.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/home_page.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signin/signin_page.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // =============================
  // MARK: Routes
  // =============================
  static const String root = '/';
  static const String signin = '/signin';
  static const String home = '/home';

  // =============================
  // MARK: Instantiate
  // =============================
  static AppRouter? _instance;
  static AppRouter get instance => _instance!;

  // KEY
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  late GoRouter _router;
  GoRouter get router => _router;

  static initialize() {
    _instance ??= AppRouter._();
  }

  AppRouter._() {
    _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: root,
      refreshListenable: AuthBlocSingleton.instance,
      redirect: (context, state) {
        final authState = AuthBlocSingleton.instance.state;
        final blockPageInAuthenticated = [root, signin];

        if (authState is AuthInitState) {
          return root;
        }

        if (authState is AuthUnAuthenticatedState) {
          return signin;
        }

        if (authState is AuthAuthenticatedState) {
          return blockPageInAuthenticated.contains(state.uri.toString())
              ? home
              : state.uri.toString();
        }

        return state.uri.toString();
      },
      routes: [
        GoRoute(
          path: root,
          pageBuilder: (context, state) => PageTransition.cupertino(
            state: state,
            child: BlocProvider(
              create: (context) => SplashBloc(
                userRepository: context.read<UserRepository>(),
              ),
              child: const SplashPage(),
            ),
          ),
        ),
        GoRoute(
          path: signin,
          pageBuilder: (context, state) => PageTransition.cupertino(
            state: state,
            child: SigninPage(),
          ),
        ),
        GoRoute(
          path: home,
          pageBuilder: (context, state) => PageTransition.cupertino(
            state: state,
            child: HomePage(),
          ),
        ),
      ],
    );
  }
}
