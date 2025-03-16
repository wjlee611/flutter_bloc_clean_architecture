import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

/// [BaseStreamUsecase] mixin class for handling state synchronization
/// between [Bloc]s at the Domain Layer.
///
/// You don't necessarily need to inherit from all Usecases, but inherit
/// from the Usecases that will be used by Blocs that need to share state.
///
/// ### How to use?
///
/// ---
///
/// 1. The `call` method of the inherited Usecase does not return data,
///   it calls the [yieldData] method.
///
///    _Example_
///    ```dart
///    class ExUseCase with BaseStreamUsecase<int> {
///      final ExRepository _exRepository;
///
///      void call(int num) async {
///        final res = await _exRepository.intAdder(num);
///        yieldData(res); // No return, Call yieldData
///      }
///    }
///    ```
///
///    You can return the return value as needed, but you may receive duplicate
///    data when the bloc that called Usecase's call proceeds to step 2.
///
/// ---
///
/// 2. The data passed to yieldData can be received by Bloc via [stream].
///
///    {@template bloc_usage}
///    _Example_
///    ```dart
///    void _initStreamEventHandler(
///      InitStreamEvent event,
///      Emitter<BlocState> emit,
///    ) async {
///      await emit.forEach(
///        _exUseCase.stream, // Usecase의 stream
///        onData: (data) => BlocState(data: data),
///      );
///    }
///    ```
///
///    When you call `_exUseCase.call()` on a Bloc, its BlocEvent exits,
///    but it can receive data through the `_exUseCase.stream` connected
///    via the InitStreamEvent.
///
///    Other Blocs that require state synchronization can synchronize data
///    over stream when used in the same way.
///    {@endtemplate}
///
/// ---
///
/// 3. Usecases that inherit from [BaseStreamUsecase] must be provided
///   via [UsecaseProvider] at the top of the widget tree of the Bloc you use.
///
///    This is to control the stream according to the Flutter lifecycle.
///
///    {@template usecase_provider_usage}
///    Don't call dispose separately because it is called inside [UsecaseProvider].
///    {@endtemplate}
///
///    For more information, see [UsecaseProvider].
mixin class BaseStreamUsecase<R> {
  final _streamController = StreamController<R>.broadcast();

  /// {@macro bloc_usage}
  Stream<R> get stream => _streamController.stream;

  /// {@macro usecase_provider_usage}
  @doNotSubmit
  void dispose() => _streamController.close();

  /// {@macro bloc_usage}
  void yieldData(R data) => _streamController.add(data);
}
