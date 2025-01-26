import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/models/user_list_rm.dart';
import 'package:flutter_coffee/screens/admin_panel/cubit/admin_pannel_cubit.dart';
import 'package:flutter_coffee/screens/admin_panel/cubit/admin_pannel_state.dart';
import 'package:flutter_coffee/screens/widgets/loading_widget.dart';
import '../../widgets/app_bar.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminPannelCubit>()
      ..getUserList()
      ..setupInterceptors(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              const BuildAppBarWidget(
                  appBarTitle: 'User List',
                  hasActionIcon: false,
                  showBackButton: true),
              BlocBuilder<AdminPannelCubit, AdminPannelState>(
                builder: (context, state) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: state.userList.statusCode != 200
                          ? Container(
                              alignment: Alignment.center,
                              child:
                                  Text(state.userList.errorMessage.toString()),
                            )
                          : ListView.builder(
                              itemCount: state.userList.detail.results.length,
                              padding: const EdgeInsets.only(top: 0),
                              itemBuilder: (context, index) {
                                final UserItem userItem =
                                    state.userList.detail.results[index];
                                return Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.4)),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.asset(
                                                  "assets/images/profile.png"),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      userItem.firstName,
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      userItem.lastName,
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text("Admin "),
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: Checkbox(
                                                  value:
                                                      userItem.isSuperuser == 1,
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  );
                },
              )
            ],
          ),
          BlocBuilder<AdminPannelCubit, AdminPannelState>(
            builder: (context, state) {
              return state.isLoading ? const LoadingWidget() : Container();
            },
          )
        ],
      ),
    );
  }
}
