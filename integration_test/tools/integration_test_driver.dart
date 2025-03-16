import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (name, imageBytes, [args]) async {
      final File image = await File(name).create(recursive: true);
      image.writeAsBytesSync(imageBytes);
      return true;
    },
  );
}
