import 'package:final_project2/screens/login_screen/login_screen.dart';
import 'package:final_project2/screens/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:final_project2/screens/studyroom_screen/studyroom_screen.dart';
import 'screens/assignment_screen/assignment_screen.dart';
import 'screens/datesheet_screen/datesheet_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'schedule_screen/schedule_screen.dart';
import 'kakao_login_screen/kakao_login_screen.dart';



Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AssignmentScreen.routeName: (context) => AssignmentScreen(),
  DateSheetScreen.routeName: (context) => DateSheetScreen(),
  ScheduleScreen.routeName: (context) => ScheduleScreen(),
  StudyroomScreen.routeName: (context) => StudyroomScreen(),
  KakaologinScreen.routeName: (context) => KakaologinScreen(),
};
