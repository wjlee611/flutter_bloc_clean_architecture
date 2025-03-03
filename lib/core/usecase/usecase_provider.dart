import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/base_stream_usecase.dart';
import 'package:provider/provider.dart';

/// [RepositoryProvider]와 사용법이 동일한 [UsecaseProvider].
///
/// 단, 위젯 트리에서 제거되면 반드시 [BaseStreamUsecase]의 `dispose`를 호출합니다.
class UsecaseProvider<T extends BaseStreamUsecase> extends Provider<T> {
  UsecaseProvider({
    required super.create,
    super.key,
    super.child,
    super.lazy,
  }) : super(
          // ignore: invalid_use_of_do_not_submit_member
          dispose: (_, value) => value.dispose(),
        );

  UsecaseProvider.value({
    required super.value,
    super.key,
    super.child,
  }) : super.value();

  static T of<T extends BaseStreamUsecase>(
    BuildContext context, {
    bool listen = false,
  }) {
    try {
      return Provider.of<T>(context, listen: listen);
    } on ProviderNotFoundException catch (e) {
      if (e.valueType != T) rethrow;
      throw FlutterError(
        '''
        UsecaseProvider.of() called with a context that does not contain a usecase of type $T.
        No ancestor could be found starting from the context that was passed to UsecaseProvider.of<$T>().

        This can happen if the context you used comes from a widget above the UsecaseProvider.

        The context used was: $context
        ''',
      );
    }
  }
}

/// [MultiRepositoryProvider]와 사용법이 동일한 [MultiUsecaseProvider].
class MultiUsecaseProvider extends MultiProvider {
  MultiUsecaseProvider({
    required super.providers,
    required super.child,
    super.key,
  });
}
