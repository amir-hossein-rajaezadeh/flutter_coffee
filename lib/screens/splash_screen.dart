import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/cubit/cubit/app_cubit.dart';
import 'package:flutter_coffee/cubit/cubit/app_state.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
 
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/splash_img.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 327,
            child: Text(
              'Fall in Love with Coffee in Blissful Delight!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            alignment: Alignment.center,
            child: const Text(
              'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
              style: TextStyle(
                  color: MyColors.lightGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<AppCubit>().chechUserLoginStatus(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 24, left: 23, top: 24),
                  height: 56,
                  decoration: BoxDecoration(
                    color: MyColors.brown,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
