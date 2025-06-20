import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uic_task/service_locator.dart' as di;
import 'package:firebase_app_check/firebase_app_check.dart';

import 'firebase_options.dart';
import 'messaging.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
  await di.setupServiceLocator();
  await setupFCM();

  final directory = HydratedStorageDirectory(
    (await getApplicationDocumentsDirectory()).path,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: directory,
  );

  runApp(const MyApp());
}
