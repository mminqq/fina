import 'package:final_project2/routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project2/screens/splash_screen/splash_screen.dart';
import 'package:final_project2/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:final_project2/firebase_options.dart';
import 'package:final_project2/repository/schedule_repository.dart';
import 'package:final_project2/provider/schedule_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:final_project2/database/drift_database.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;

void main() async{
  kakao.KakaoSdk.init(nativeAppKey: '6a1e1c7842adca654316730a19d460c4');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
  final database = LocalDatabase(); // ➊ 데이터베이스 생성

  final repository = ScheduleRepository();
  final scheduleProvider = ScheduleProvider(repository: repository);

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it requires 3 parameters
    //context, orientation, device
    //it always requires, see plugin documentation
    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Brain',
        theme: CustomTheme().baseTheme,
        //initial route is splash screen
        //mean first screen
        initialRoute: SplashScreen.routeName,
        //define the routes file here in order to access the routes any where all over the app
        routes: routes,
      );
    });
  }
}
