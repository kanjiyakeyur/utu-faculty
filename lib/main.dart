import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utu_faculty/screens/splash_screen.dart';

import './provider/faculty.dart';
import './provider/notification.dart';

import './screens/login_Screen.dart';
import './screens/home_screen.dart';
import './screens/add_notification_screen.dart';
import './screens/account_info_scrren.dart';

import './screens/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Faculty()),
        ChangeNotifierProvider.value(value: UtuNotification()),
      ],
      child: Consumer<Faculty>(
        builder: (ctx, faculty, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.indigo.shade50,
            accentColor: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder(
                      future: faculty.fatchFacultyDetails(),
                      builder: (ctx, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SplashScreen();
                        }
                        return HomeScreen();
                      });
                } else if (snapshot.hasError) {
                  FirebaseAuth.instance.signOut();
                  return LoginScreen();
                }
                return LoginScreen();
              }),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            AddNotificationScreen.routeName: (ctx) => AddNotificationScreen(),
            AccountInfoScreen.routeName: (ctx) => AccountInfoScreen(),
          },
        ),
      ),
    );
  }
}
