import 'package:flutter/services.dart';
import 'package:sehr/presentation/view_models/auth_view_model.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:sehr/presentation/view_models/user_view_model.dart';

import '../presentation/routes/routes.dart';
import '../presentation/src/index.dart';
import '../presentation/view_models/customer_view_models/home_view_model.dart';
import 'index.dart';

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp._internal();
  static const MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    // WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthViewModel()),
        ChangeNotifierProvider(create: (ctx) => ProfileViewModel()),
        ChangeNotifierProvider(create: (ctx) => UserViewModel()),
        ChangeNotifierProvider(create: (ctx) => DrawerMenuViewModel()),
        ChangeNotifierProvider(create: (ctx) => HomeViewModel()),
      ],
      child: GetMaterialApp(
        builder: (context, child) {
          SizeConfig().init(context);
          return Theme(data: ThemeData(), child: child!);
        },
        debugShowCheckedModeBanner: false,
        // theme: getAppTheme(context),
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        // initialRoute: Routes.bottomNavigationRoute,
      ),
    );
  }
}
