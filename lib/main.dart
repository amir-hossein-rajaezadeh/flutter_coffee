import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/cubit/cubit/app_cubit.dart';
import 'package:flutter_coffee/screens/admin_panel/admin_panel_screen.dart';
import 'package:flutter_coffee/screens/admin_panel/card/card_list_screen.dart';
import 'package:flutter_coffee/screens/admin_panel/coffee/add_coffee_screen.dart';
import 'package:flutter_coffee/screens/admin_panel/cubit/admin_pannel_cubit.dart';
import 'package:flutter_coffee/screens/admin_panel/user/user_list_screen.dart';
import 'package:flutter_coffee/screens/detail_screen.dart';
import 'package:flutter_coffee/screens/login_screen.dart';
import 'package:flutter_coffee/screens/main_screen.dart';
import 'package:flutter_coffee/screens/map_screen.dart';
import 'package:flutter_coffee/screens/order_screen.dart';
import 'package:flutter_coffee/screens/register_screen.dart';
import 'package:flutter_coffee/screens/splash_screen.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
import 'package:go_router/go_router.dart';

import 'screens/admin_panel/coffee/coffee_list_screen.dart';

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
        path: "/admin_panel",
        builder: (context, state) => const AdminPanelScreen(),
      ),
      GoRoute(
        path: "/coffee_list",
        builder: (context, state) => const CoffeeListScreen(),
      ),
      GoRoute(
        path: "/add_coffee",
        builder: (context, state) => const AddCoffeeScreen(),
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
            return const OrderListScreen();
          }),
      GoRoute(
        path: "/user_list",
        builder: (context, state) => const UserListScreen(),
      ),
      GoRoute(
        path: "/card_list",
        builder: (context, state) => const CardListScreen(),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(),
          ),
          BlocProvider<AdminPannelCubit>(
            create: (context) => AdminPannelCubit(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: MyColors.brown),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
