import 'flavors.dart';

import 'main.dart' as runner;

// TODO: main_e2e is not main entry point from flutter run command.
// xcode's Build Setting > FLUTTER_TARGET value will be changed like original Runner schema
// for launch app automatly during integration tests.
Future<void> main() async {
  F.appFlavor = Flavor.e2e;
  await runner.main();
}
