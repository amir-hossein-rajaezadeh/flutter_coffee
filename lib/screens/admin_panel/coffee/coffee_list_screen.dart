import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/screens/admin_panel/cubit/admin_pannel_cubit.dart';
import 'package:flutter_coffee/screens/admin_panel/cubit/admin_pannel_state.dart';
import 'package:flutter_coffee/screens/widgets/app_bar.dart';
import 'package:flutter_coffee/screens/widgets/devider.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
import 'package:go_router/go_router.dart';
import 'add_coffee_screen.dart';

class CoffeeListScreen extends StatelessWidget {
  const CoffeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminPannelCubit>()
      ..getCoffeeList()
      ..setupInterceptors(context);
    return Scaffold(
      body: Column(
        children: [
          const BuildAppBarWidget(
              appBarTitle: 'Coffee List',
              hasActionIcon: false,
              showBackButton: true),
          Expanded(
            child: BlocBuilder<AdminPannelCubit, AdminPannelState>(
              builder: (context, state) {
                return state.coffeeList.isEmpty
                    ? const Center(
                        child: Text(
                          'No Coffee Avaleble right Now💔',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.coffeeList.length,
                        padding: const EdgeInsets.only(top: 0),
                        itemBuilder: (context, index) {
                          final coffeeItem = state.coffeeList[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => context.push("/detail",
                                    extra: coffeeItem.id),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 24, left: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: MyColors.brown),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                coffeeItem.image ?? "",
                                                width: 110,
                                                height: 75,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10, bottom: 25),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    coffeeItem.coffeeName ?? "",
                                                    style: const TextStyle(
                                                        fontSize: 22),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  SizedBox(
                                                      width: 180,
                                                      child: Text(
                                                          coffeeItem.desc!)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(coffeeItem.rate!
                                                      .round()
                                                      .toString()),
                                                  const Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.amber,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    coffeeItem.coffeeType ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: const Icon(
                                                      Icons.coffee,
                                                      color: MyColors.brown,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${coffeeItem.price}",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  " \$",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: MyColors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 16),
                                child: const DeviderWidget(),
                              )
                            ],
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCoffeeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
