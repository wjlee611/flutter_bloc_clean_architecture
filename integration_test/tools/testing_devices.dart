enum TestingDevice {
  api26Pixel1(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_1',
    deviceKey: 'Pixel_1_API_26',
  ),
  api28Pixel2(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_2',
    deviceKey: 'Pixel_2_API_28',
  ),
  api29Pixel3(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_3',
    deviceKey: 'Pixel_3_API_29',
  ),
  api30Pixel4(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_4',
    deviceKey: 'Pixel_4_API_30',
  ),
  api31Pixel5(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_5',
    deviceKey: 'Pixel_5_API_31',
  ),
  api32Pixel6(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_6',
    deviceKey: 'Pixel_6_API_32',
  ),
  api33Pixel7(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_7',
    deviceKey: 'Pixel_7_API_33',
  ),
  api34Pixel8(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_8',
    deviceKey: 'Pixel_8_API_34',
  ),
  api35Pixel9(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_9',
    deviceKey: 'Pixel_9_API_35',
  ),
  // BUG?: The root isolate is taking an unusually long time to start.
  // api36Pixel9(
  //   deviceType: DeviceType.android,
  //   deviceName: 'Pixel_9_API_36',
  //   deviceKey: 'Pixel_9_API_36',
  // ),

  // ~96% of all ios
  ios150_13SE2(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_SE2',
    deviceKey: 'C074A53A-9CD5-4EA1-84D5-04CA8CD6D500',
  ),
  ios150_13(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_13',
    deviceKey: '152FE30B-8240-4FBA-857C-B629183EACC5',
  ),
  ios155_13SE3(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_SE3',
    deviceKey: '09E0D13C-05C3-49B2-B440-E0617786AF4F',
  ),
  ios160_14(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_14',
    deviceKey: '6E90F4B1-23C1-4116-BEC5-C66C73EAF4C7',
  ),
  ios164_14Plus(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_14_Plus',
    deviceKey: '15B0E2C1-6F54-4B88-80DE-BC372F8530FD',
  ),
  ios170_15(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_15',
    deviceKey: '9E102BD9-5C84-4A70-871C-52D4337C654C',
  ),
  ios175_15Pro(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_15_Pro',
    deviceKey: 'F37640E7-D87A-4599-8339-6A512DEB5CD9',
  );

  final DeviceType deviceType;
  final String deviceName;
  final String deviceKey;

  const TestingDevice({
    required this.deviceType,
    required this.deviceName,
    required this.deviceKey,
  });
}

enum DeviceType {
  android,
  ios,
}
