import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/pages/AuthenticationPage.dart';
import 'package:fyp/pages/LoginPage.dart';
import 'package:fyp/pages/MyHomePage.dart';
import 'package:fyp/pages/SignUpPage.dart';
import 'package:fyp/providers.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final database = Provider.of<FirebaseAuth>(context, listen: false);
    // finacontext.watch
    final value = ref.watch(userProvider).value != null;
    // print("In main user: " + ref.read(userProvider).toString());
    print("In main user: " + value.toString());
    return Consumer(
      builder: (context, watch, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: value ? MyHomePage() : AuthenticationPage(),
        );
      },
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   routes: {
    //     "/login": (context) => LoginPage(),
    //     "/signup": (context) => SignUpPage(),
    //     "/home": (context) => MyHomePage(),
    //   },
    //   initialRoute: value ? "/home" : "/login",
    // );
  }
}
