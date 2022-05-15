import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/UI/pages/auth/login.dart';
import 'package:liveasy/UI/pages/auth/verify_otp.dart';
import 'package:liveasy/UI/pages/home.dart';
import 'package:liveasy/UI/pages/select_language.dart';
import 'package:liveasy/provider/authenticate.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhoneNumberAuth>(
        create: (context) => PhoneNumberAuth(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FirebaseAuth.instance.currentUser == null
              ? const SelectLanguage()
              : const HomePage(),
          //home: const VerifyOtp()
        ));
  }
}
