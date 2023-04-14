import 'package:flutter/material.dart';

import 'app/flavours/app_flavour.dart';
import 'app/view/app.dart';
import 'core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServiceLocator();
  bootstrap(() => App());
}
