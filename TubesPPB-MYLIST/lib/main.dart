import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punya_orang/bloc/login/login_cubit.dart';
import 'package:punya_orang/bloc/register/register_cubit.dart';
import 'package:punya_orang/firebase_options.dart';
import 'package:punya_orang/ui/homepage.dart';
import 'package:punya_orang/ui/login.dart';
import 'package:punya_orang/ui/profile_screen.dart';
import 'package:punya_orang/ui/signup.dart';
import 'package:punya_orang/ui/splash.dart';
import 'package:punya_orang/ui/tasklist.dart';
import 'package:punya_orang/ui/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()) // Fix syntax here
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(), // Set the splash screen as the initial route
          '/welcome': (context) => WelcomePage(),
          '/signup': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(), // Define the login screen route
          '/homepage' : (context) => HomeScreen(),
          '/profile' : (context) => ProfileScreen(),
          '/tasklist' : (context) => TaskListApp(),
        },
      ),
    );
  }
}
