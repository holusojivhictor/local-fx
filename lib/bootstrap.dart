import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:local_fx/src/config/config.dart';
import 'package:local_fx/src/config/injection.dart';
import 'package:local_fx/src/extensions/string_extensions.dart';
import 'package:local_fx/src/features/common/presentation/colors.dart';
import 'package:local_fx/src/utils/asset_utils.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  FirebaseOptions? options,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await AssetUtils.preloadSvgs();

  await Firebase.initializeApp(
    options: options,
  );

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(days: 1),
    ),
  );

  await remoteConfig.fetchAndActivate();
  Config.instance.initConfig(remoteConfig.getAll());

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  await Injection.init();
  registerErrorHandlers();

  runApp(await builder());
}

void registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  foundation.PlatformDispatcher.instance.onError = (
    Object error,
    StackTrace stack,
  ) {
    debugPrint(error.toString());
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: foundation.kDebugMode
          ? AppBar(
              backgroundColor: AppColors.primary,
              title: Text('An error occurred'.hardcoded),
              titleTextStyle: const TextStyle(color: Colors.white),
            )
          : null,
      body: Center(
        child: foundation.kDebugMode ? Text(details.toString()) : null,
      ),
    );
  };
}
