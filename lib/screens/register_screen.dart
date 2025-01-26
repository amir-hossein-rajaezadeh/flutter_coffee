import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/screens/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

import '../cubit/cubit/app_cubit.dart';
import '../cubit/cubit/app_state.dart';
import '../utils/my_colors.dart';
import 'widgets/loading_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _firstNameTextEditingController =
      TextEditingController();
  final TextEditingController _lastNameTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const BuildAppBarWidget(
                  showBackButton: true,
                  appBarTitle: "Register",
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
              Container(
                margin: const EdgeInsets.only(top: 20, right: 26, left: 26),
                child: TextFormField(
                  controller: _firstNameTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "FirstName",
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
                  controller: _lastNameTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "LastName",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.brown),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<AppCubit>().registerUser(
                    _usernameTextEditingController.text,
                    _passwordTextEditingController.text,
                    _firstNameTextEditingController.text,
                    _lastNameTextEditingController.text,
                    context),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 30, right: 28, left: 28, bottom: 0),
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyColors.brown),
                  child: const Center(
                    child: Text(
                      "Register",
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
                      "Already have Account?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () => context.push("/login"),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return state.isLoading
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
