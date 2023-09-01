import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/screens/home.dart';
import 'package:restro_range/auth/controllers/auth_controller.dart';
import 'package:restro_range/auth/screens/login.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/error.dart';
import 'package:restro_range/const/loader.dart';
import 'package:restro_range/const/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    precacheImage(const AssetImage('asset/images/cover_2.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: backgroundColor,
              fontSize: 25,
            ),
            backgroundColor: primColor,
            // centerTitle: true,
            elevation: 0.5,
            scrolledUnderElevation: 1,
            iconTheme: IconThemeData(color: backgroundColor, size: 30)),
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataProvider).when(
        data: (restaurant) {
          if (restaurant == null) {
            return ScreenLogin();
          }
          return const ScreenHome();
        },
        error: (error, stackTrace) {
          return ErrorScreen(error: error.toString());
        },
        loading: () {
          return const ScreenLoader();
        },
      ),
      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Text(snapshot.error.toString());
      //     }else{
      //       if(snapshot.connectionState==ConnectionState.active){
      //         User? user=FirebaseAuth.instanceFor(app: app)
      //       }
      //     }
      //   },
      // ),
    );
  }
}
