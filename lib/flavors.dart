enum Flavor {
  dev,
  qa,
  e2e,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'FCAB dev';
      case Flavor.qa:
        return 'FCAB QA';
      case Flavor.e2e:
        return 'FCAB TEST';
      case Flavor.prod:
        return 'FCAB';
      default:
        return 'title';
    }
  }

}
