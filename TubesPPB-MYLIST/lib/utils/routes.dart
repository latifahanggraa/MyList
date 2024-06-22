import 'package:flutter/material.dart';
import 'package:punya_orang/ui/add_task.dart';
import 'package:punya_orang/ui/homepage.dart';
import 'package:punya_orang/ui/login.dart';
import 'package:punya_orang/ui/profile_screen.dart';
import 'package:punya_orang/ui/signup.dart';
import 'package:punya_orang/ui/tasklist.dart';
import 'package:punya_orang/ui/welcome.dart';

MaterialPageRoute _pageRoute(
  {required Widget body, required RouteSettings settings}) =>
  MaterialPageRoute(builder: (_) => body, settings: settings);

Route? generateRoute(RouteSettings settings) {
  Route? _route;
  //final _args = settings.arguments;

  switch (settings.name) {
    case rWelcome:
    _route = _pageRoute(body: WelcomePage(), settings: settings);
    break;

    case rRegister:
    _route = _pageRoute(body: RegisterScreen (), settings: settings);
    break;

    case rLogin:
    _route = _pageRoute(body: LoginScreen (), settings: settings);
    break;


    case rHome:
    _route = _pageRoute(body: HomeScreen(), settings: settings);
    break;

    case rProfile:
    _route = _pageRoute(body: ProfileScreen(), settings: settings);
    break;

     case rAdd:
    _route = _pageRoute(body: AddPage(), settings: settings);
    break;

    case rList:
    _route = _pageRoute(body: TaskListApp(), settings: settings);
    break;
  }
  return _route;
}

final NAV_KEY = GlobalKey<NavigatorState>();
const String rWelcome = '/welcome';
const String rRegister = '/signup';
const String rLogin = '/login';
const String rHome = '/homepage';
const String rProfile = '/profile';
const String rAdd = '/add_task';
const String rList = '/tasklist';