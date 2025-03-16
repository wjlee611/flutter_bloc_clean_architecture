import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/base_stream_usecase.dart';
import 'package:provider/provider.dart';

/// [UsecaseProvider], which has the same usage as [RepositoryProvider].
///
/// However, it must call `dispose` of [BaseStreamUsecase] when it is removed
/// from the widget tree.
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

/// [MultiUsecaseProvider], which has the same usage as [MultiRepositoryProvider].
class MultiUsecaseProvider extends MultiProvider {
  MultiUsecaseProvider({
    required super.providers,
    required super.child,
    super.key,
  });
}
