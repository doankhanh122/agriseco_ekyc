# agriseco_ekyc_package

This is a package belong to Agriseco helping EKYC

## Using

The path library was designed to be imported with a prefix, though you don't
have to if you don't want to:

```dart
import 'package:agriseco_ekyc_package/agriseco_ekyc.dart';
```

Very first start screen was `EkycFirstPage` class.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AgrisecoEkyc(),
    );
  }
}
```
### iOS

Add two rows to the `ios/Runner/Info.plist`:

* one with the key `Privacy - Camera Usage Description` and a usage description.
* and one with the key `Privacy - Microphone Usage Description` and a usage description.

If editing `Info.plist` as text, add:

```xml
<key>NSCameraUsageDescription</key>
<string>Agriseco cần quyền truy cập Camera trên thiết bị của bạn.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Agriseco cần quyền truy cập Micro trên thiết bị của bạn.</string>
```

### Android

Change the minimum Android sdk version to 21 (or higher) in your `android/app/build.gradle` file.

```groovy
compileSdkVersion 31
minSdkVersion 21

```

Change the kotlin version to 1.7.21 (or higher) in your `android/build.gradle` file.

```groovy
ext.kotlin_version = '1.7.21'
```

Change the distributionUrl for gradle in your `android/gradle/gradle-wrapper.properties` file.

```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-6.7.1-all.zip
```