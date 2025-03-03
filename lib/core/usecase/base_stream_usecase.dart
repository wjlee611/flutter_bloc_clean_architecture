import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

/// [Bloc]간 상태 동기화를 Domain Layer에서 처리하기 위한 [BaseStreamUsecase] mixin class.
///
/// 모든 Usecase에 반드시 상속해야 할 필요는 없지만, 상태를 공유할 필요가 있는 Bloc에서 사용할 Usecase에 상속하여 사용합니다.
///
/// ### 사용방법
///
/// ---
///
/// 1. 상속받은 Usecase의 `call` 메서드는 데이터를 반환하지 않고, [yieldData] 메서드를 호출합니다.
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
///    필요에 따라 리턴값을 반환해도 되지만, Usecase의 call을 호출한 bloc에서 2번 스탭 진행 시 \
///    데이터가 중복으로 수신될 수 있습니다.
///
/// ---
///
/// 2. yieldData로 넘긴 데이터는 [stream]을 통해 Bloc에서 받을 수 있습니다.
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
///    Bloc에서 `_exUseCase.call()` 을 호출하면 해당 BlocEvent는 종료되는 대신, \
///    InitStreamEvent를 통해 연결된 `_exUseCase.stream`을 통해 데이터를 받을 수 있습니다.
///
///    상태 동기화가 필요한 다른 Bloc에서도 동일한 방법으로 사용 시 stream을 통해 데이터를 동기화 할 수 있습니다.
///    {@endtemplate}
///
/// ---
///
/// 3. [BaseStreamUsecase]를 상속받은 Usecase는 반드시 사용하는 Bloc의 위젯트리 상단에서 \
///    [UsecaseProvider]를 통해 제공되어야 합니다.
///
///    이는 Flutter 상명주기에 따라 stream을 컨트롤하기 위함입니다.
///
///    {@template usecase_provider_usage}
///    [UsecaseProvider] 내부에서 dispose를 호출하기 때문에 별도로 dispose를 호출하지 마세요.
///    {@endtemplate}
///
///    자세한 내용은 [UsecaseProvider] 참조 바랍니다.
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
