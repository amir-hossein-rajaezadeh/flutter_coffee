import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/cubit/cubit/app_cubit.dart';
import 'package:flutter_coffee/cubit/cubit/app_state.dart';
import 'package:flutter_coffee/screens/detail_screen.dart';
import 'package:flutter_coffee/screens/login_screen.dart';
import 'package:flutter_coffee/screens/main_screen.dart';
import 'package:flutter_coffee/screens/map_screen.dart';
import 'package:flutter_coffee/screens/order_screen.dart';
import 'package:flutter_coffee/screens/register_screen.dart';
import 'package:flutter_coffee/screens/splash_screen.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/main",
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: "/map",
        builder: (context, state) => const MapScreen(),
      ),
      GoRoute(
          path: "/detail",
          builder: (context, state) {
            int coffeeId = state.extra as int;
            return DetailScreen(
              coffeeId: coffeeId,
            );
          }),
      GoRoute(
          path: "/orderList",
          builder: (context, state) {
            int coffeeId = state.extra as int;
            return OrderListScreen(
              coffeeId: coffeeId,
            );
          }),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: MyColors.brown),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}
