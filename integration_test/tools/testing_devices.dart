enum TestingDevice {
  // 98.8% of all android os
  // api23Pixel5(
  //   deviceType: DeviceType.android,
  //   deviceName: 'Pixel_5_API_23',
  //   deviceKey: 'API_23_Pixel_5',
  // ), // No Boot completed log
  // api24Pixel5(
  //   deviceType: DeviceType.android,
  //   deviceName: 'Pixel_5_API_24',
  //   deviceKey: 'API_24_Pixel_5',
  // ), // No Boot completed log
  api26Pixel5(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_5_API_26',
    deviceKey: 'API_26_Pixel_5',
  ),
  api28Pixel1(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_1',
    deviceKey: 'API_28_Pixel_1',
  ),
  api29Pixel2(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_2',
    deviceKey: 'API_29_Pixel_2',
  ),
  api30Pixel3(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_3',
    deviceKey: 'API_30_Pixel_3',
  ),
  api31Pixel4(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_4',
    deviceKey: 'API_31_Pixel_4',
  ),
  api33Pixel5(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_5',
    deviceKey: 'API_33_Pixel_5',
  ),
  api34Pixel6(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_6',
    deviceKey: 'API_34_Pixel_6',
  ),
  api35Pixel8a(
    deviceType: DeviceType.android,
    deviceName: 'Pixel_8a',
    deviceKey: 'API_35_Pixel_8a',
  ),

  // ~96% of all ios
  ios15_13SE3(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_SE3',
    deviceKey: '43EF3ADB-D981-4ABE-932F-44BE459E4F0A',
  ),
  ios15_13Mini(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_13_Mini',
    deviceKey: 'AE6A76A1-868B-4A20-AC80-07ED4739E026',
  ),
  ios15_13(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_13',
    deviceKey: '429FEEB7-81D0-4CCB-A781-43C336EB23AC',
  ),
  ios16_14(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_14',
    deviceKey: '5DB923A6-2379-49CA-A582-2BE2B2A98EEF',
  ),
  ios16_14Plus(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_14_Plus',
    deviceKey: '1D647AAB-82C4-47BE-BC35-4FE46A12116A',
  ),
  ios17_15(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_15',
    deviceKey: 'B750403F-F332-45D4-A44C-848B7CD3B8E9',
  ),
  ios17_15Pro(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_15_Pro',
    deviceKey: '1D287230-B3A6-4B70-A55B-BD13BB8C2FD2',
  ),
  ios18_16(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_16',
    deviceKey: 'F4A78356-4369-4B7D-804B-F13546053733',
  ),
  ios18_16ProMax(
    deviceType: DeviceType.ios,
    deviceName: 'iPhone_16_Pro_Max',
    deviceKey: '2441E581-F3DA-412D-BD80-BB3D4F787897',
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
