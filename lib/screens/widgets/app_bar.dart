import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/models/cofee_model.dart';
import 'package:lottie/lottie.dart';
import '../../cubit/cubit/app_cubit.dart';
import '../../cubit/cubit/app_state.dart';

class BuildAppBarWidget extends StatelessWidget {
  const BuildAppBarWidget(
      {super.key,
      required this.appBarTitle,
      required this.hasActionIcon,
      required this.coffeeId});
  final bool hasActionIcon;
  final String appBarTitle;
  final int coffeeId;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 12, left: 12),
      child: AppBar(
        actions: [
          if (hasActionIcon)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  final CoffeeModel coffeeItem = state.coffeeList
                      .firstWhere((element) => element.coffeeId == coffeeId);
                  print(coffeeItem);
                  return Container(
                    margin: const EdgeInsets.only(top: 8),
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        print('likedAnim Called');
                        context.read<AppCubit>().likeItem(coffeeItem.coffeeId);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 0, top: 0),
                            child: Icon(
                              coffeeItem.isLiked
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              size: 24,
                              color: Colors.red,
                            ),
                          ),
                          if (state.showLikeAnim && coffeeItem.isLiked)
                            Lottie.asset('assets/animations/like.json',
                                onLoaded: (p0) async {
                              await Future.delayed(
                                const Duration(seconds: 1),
                              );
                              context.read<AppCubit>().setShowLikeAnim(false);
                            },
                            
                                repeat: false,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover)
                          else
                            const SizedBox(
                              width: 50,
                              height: 50,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
        ],
        title: Text(
          appBarTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            print('called');
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
      ),
    );
  }
}
