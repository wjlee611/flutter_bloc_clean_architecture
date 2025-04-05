import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/app_di.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase_provider.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiUsecaseProvider(
      providers: [
        UsecaseProvider(
          create: (context) => ToggleFavorite(
            articleRepository: AppDI.instance.articleRepository,
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.instance.router,
        debugShowCheckedModeBanner: false,
        title: F.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) => _flavorBanner(
          child: child ?? SizedBox(),
          show: kDebugMode,
        ),
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) {
    if (show) {
      return Banner(
        location: BannerLocation.topStart,
        message: F.name,
        color: Colors.green.withAlpha(150),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Sizes.size12,
          letterSpacing: Sizes.size1,
        ),
        textDirection: TextDirection.ltr,
        child: child,
      );
    }
    return Container(
      child: child,
    );
  }
}
