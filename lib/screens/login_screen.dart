import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/cubit/cubit/app_cubit.dart';
import 'package:flutter_coffee/cubit/cubit/app_state.dart';
import 'package:flutter_coffee/screens/widgets/loading_widget.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
import 'package:go_router/go_router.dart';
import 'widgets/app_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 0),
            children: [
              const BuildAppBarWidget(
                  showBackButton: false,
                  appBarTitle: "Login",
                  hasActionIcon: false),
              Container(
                margin: const EdgeInsets.only(top: 20, right: 26, left: 26),
                child: TextFormField(
                  controller: _usernameTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "UserName",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.brown),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, right: 26, left: 26),
                child: TextFormField(
                  controller: _passwordTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<AppCubit>().loginUser(
                    _usernameTextEditingController.text,
                    _passwordTextEditingController.text,
                    context),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 30, right: 28, left: 28, bottom: 3),
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyColors.brown),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont have Account?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () => context.push("/register"),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
              )
            ],
          ),
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return state.isLoading && state.coffeeList.isEmpty
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.only(bottom: 200),
                      child: const LoadingWidget(),
                    )
                  : Container();
            },
          )
        ],
      ),
    );
  }
}
