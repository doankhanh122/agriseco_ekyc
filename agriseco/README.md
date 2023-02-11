# agriseco_ekyc_package

This is a package belong to Agriseco helping EKYC

## Using

The path library was designed to be imported with a prefix, though you don't
have to if you don't want to:

```dart
import 'package:agriseco_ekyc_package/agriseco_ekyc_package.dart';
```

Very first start screen was `EkycFirstPage` class.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EkycFirstPage(),
    );
  }
}
```