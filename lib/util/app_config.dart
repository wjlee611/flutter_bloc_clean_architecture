import 'package:flutter_bloc_clean_architecture/core/constant/networks.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';

class AppConfig {
  // =============================
  // MARK: Configs
  // =============================

  final String baseUrl;

  // =============================
  // MARK: Initializer
  // =============================

  AppConfig._dev() : baseUrl = Networks.devBaseUrl;

  AppConfig._qa() : baseUrl = Networks.qaBaseUrl;

  AppConfig._prod() : baseUrl = Networks.baseUrl;

  factory AppConfig(Flavor? flavor) {
    switch (flavor) {
      case Flavor.dev:
        _instance = AppConfig._dev();
        break;
      case Flavor.qa:
      case Flavor.e2e:
        _instance = AppConfig._qa();
        break;
      case Flavor.prod:
        _instance = AppConfig._prod();
        break;
      default:
        _instance = AppConfig._dev();
        break;
    }
    return instance;
  }

  static AppConfig? _instance;
  static AppConfig get instance => _instance ?? AppConfig(F.appFlavor);
}
