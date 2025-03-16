import 'dart:io';
import '../tools/testing_devices.dart';

void main() async {
  _printWithTime('Clean up screenshots');
  await Process.run('rm', ['-rf', 'screenshots']);

  _printWithTime('Start integration test');
  final DateTime startTime = DateTime.now();

  // ios simulator firstrun
  await Process.run(
    'open',
    ['/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'],
  );
  await Future.delayed(Duration(seconds: 1)); // Magic number...
  for (var device in TestingDevice.values) {
    if (device.deviceType == DeviceType.ios) {
      await Process.run(
        'xcrun',
        ['simctl', 'shutdown', device.deviceKey],
      );
    }
  }

  bool isAllTestPassed = true;
  for (var device in TestingDevice.values) {
    if (!isAllTestPassed) break;

    await Future.delayed(Duration(seconds: 1)); // Magic number...
    _printWithTime('Running test on ${device.deviceName}');
    switch (device.deviceType) {
      case DeviceType.android:
        // Launch Android emulator
        final homeDir = Platform.environment['HOME'];
        final process = await Process.start(
          '$homeDir/Library/Android/sdk/emulator/emulator',
          ['-avd', device.deviceKey, '-no-snapshot'],
        );
        await process.stdout.map((raw) => String.fromCharCodes(raw)).firstWhere(
              (log) => log.contains('Boot completed'),
              orElse: () => throw Exception('Boot completed log not found'),
            );
        // Integration test
        final testProcess = await _runIntegrationTest(device.deviceName);
        if (testProcess.exitCode != 0) {
          _printWithTime('[TEST FAILED]\n${testProcess.stdout}');
          isAllTestPassed = false;
        }
        // Terminate Android emulator
        process.kill();
        break;
      case DeviceType.ios:
        // Launch iOS emulator
        await Process.run(
          'xcrun',
          ['simctl', 'boot', device.deviceKey],
        );
        // Integration test
        final testProcess = await _runIntegrationTest(device.deviceName);
        if (testProcess.exitCode != 0) {
          _printWithTime('[TEST FAILED]\n${testProcess.stdout}');
          isAllTestPassed = false;
        }
        // Terminate iOS emulator
        await Process.run(
          'xcrun',
          ['simctl', 'shutdown', device.deviceKey],
        );
        break;
    }
  }

  final DateTime endTime = DateTime.now();
  _printWithTime(
      'Integration test ${isAllTestPassed ? "completed" : "failed"} in ${endTime.difference(startTime).inSeconds} seconds');
}

Future<ProcessResult> _runIntegrationTest(String deviceName) async =>
    await Process.run(
      'flutter',
      [
        'drive',
        '--driver=integration_test/tools/integration_test_driver.dart',
        '--target=integration_test/main_test.dart',
        '--flavor=e2e',
        '--dart-define',
        'DEVICE_NAME=$deviceName',
      ],
    );

void _printWithTime(String message) {
  final now = DateTime.now();
  // ignore: avoid_print
  print(
      '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}] $message');
}
