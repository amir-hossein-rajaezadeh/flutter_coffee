import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/cubit/cubit/app_cubit.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
import 'package:go_router/go_router.dart';
import '../../cubit/cubit/app_state.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer Header (like Telegram profile)
              UserAccountsDrawerHeader(
                accountName: FutureBuilder<String>(
                  future: context
                      .read<AppCubit>()
                      .getUserInfoFromLocalDatabase("fullname"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading...");
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return Text(
                        snapshot.data ?? "No Name",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      );
                    }
                  },
                ),
                accountEmail: null,
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/profile.png'), // Add a profile picture
                ),
                decoration: BoxDecoration(
                  color: MyColors.brown,
                  image: DecorationImage(
                      image: NetworkImage(state.coffeeItem.image ?? ''),
                      fit: BoxFit.cover),
                ),
              ),
              // List Items (Menu Options)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.admin_panel_settings_outlined),
                      title: const Text("Admin Pandel"),
                      onTap: () {
                        context.pop();
                        context.push('/admin_panel');
                      },
                    ),
                    const Divider(), // A horizontal line divider
                    ListTile(
                      leading: const Icon(CupertinoIcons.shopping_cart),
                      title: const Text("OrderList"),
                      onTap: () {
                        context.push("/orderList");
                      },
                    ),
                    ListTile(
                      leading: const Icon(CupertinoIcons.settings),
                      title: const Text("Settings"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.person_3,
                        size: 35,
                      ),
                      title: const Text("About"),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              // Logout or Bottom Item
              ListTile(
                contentPadding: const EdgeInsets.only(bottom: 40, left: 20),
                leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.redAccent, fontSize: 20),
                ),
                onTap: () {
                  context.read<AppCubit>().logout(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
