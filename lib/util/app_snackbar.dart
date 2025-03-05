import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';

void appSnackbar({
  required String message,
  Duration duration = const Duration(seconds: 2),
  SnackBarAction? action,
}) {
  if (!AppRouter.isInitialized) return;

  ScaffoldMessenger.of(AppRouter.instance.rootNavigatorKey.currentContext!)
      .showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration,
      action: action,
    ),
  );
}
