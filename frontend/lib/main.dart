import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/firebase_service.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseService.start();
    // await AuthService.signOut();

    runApp(
      MultiProvider(
        providers: [
          StreamProvider.value(
            value: AuthService.onAuthStateChanged,
            initialData: AuthService.currentUser,
            lazy: false,
          ),
        ],
        child: _RecycleApp(),
      ),
    );
  }, (error, stackTrace) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stackTrace);
  });
}

class _RecycleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<User?>(context);

    debugPrint("authUser: $authUser");

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GestureDetector(
      // For keyboard dismissal
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.grey[700],
              ),
        ),
        scaffoldMessengerKey: GlobalKeys.scaffoldMessengerKey,
        navigatorKey: GlobalKeys.navigatorKey,
        initialRoute: RouteNames.main,
        // initialRoute: authUser == null ? RouteNames.login : RouteNames.main,
        routes: Routes.routes,
      ),
    );
  }
}
