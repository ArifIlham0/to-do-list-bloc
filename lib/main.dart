import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todolist_bloc/core/configs/theme/app_color.dart';
import 'package:todolist_bloc/presentation/export_cubit.dart';
import 'package:todolist_bloc/presentation/auth/pages/splash.dart';
import 'package:todolist_bloc/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..appStarted()),
        BlocProvider(create: (context) => BottomNavCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'To Do List Bloc',
            home: const SplashPage(),
            theme: ThemeData(
              scaffoldBackgroundColor: kBlack,
              iconTheme: const IconThemeData(color: kDarkGrey),
              primarySwatch: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
