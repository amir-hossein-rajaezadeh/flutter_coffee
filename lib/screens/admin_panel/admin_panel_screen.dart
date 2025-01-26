import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee/screens/widgets/app_bar.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
import 'package:go_router/go_router.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: const BuildAppBarWidget(
                  appBarTitle: 'Admin Panel',
                  hasActionIcon: false,
                  showBackButton: true),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => context.push('/user_list'),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                        color: MyColors.brown,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'User List',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/coffee_list'),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 26),
                      decoration: BoxDecoration(
                        color: MyColors.brown,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Coffee List',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/card_list'),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 26),
                      decoration: BoxDecoration(
                        color: MyColors.brown,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Order List',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
