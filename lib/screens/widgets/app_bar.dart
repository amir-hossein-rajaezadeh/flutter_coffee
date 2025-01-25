import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/models/coffee_model_rm.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../cubit/cubit/app_cubit.dart';
import '../../cubit/cubit/app_state.dart';

class BuildAppBarWidget extends StatelessWidget {
  const BuildAppBarWidget({
    super.key,
    required this.appBarTitle,
    required this.hasActionIcon,
  });
  final bool hasActionIcon;
  final String appBarTitle;
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
                  final CoffeeModelRM coffeeItem = state.coffeeItem;
                  print(coffeeItem);
                  return Container(
                    margin: const EdgeInsets.only(top: 8),
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        // context.read<AppCubit>().likeItem(index);
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 13, top: 12),
                            child: Icon(
                              coffeeItem.isLiked == 1
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: Colors.black,
                            ),
                          ),
                          if (state.showLikeAnim && coffeeItem.isLiked == 1)
                            Lottie.asset('assets/animations/like_anim.json',
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
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
      ),
    );
  }
}
