import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee/screens/widgets/app_bar.dart';

import '../utils/my_colors.dart';

class OrderListScreen extends StatelessWidget {
  OrderListScreen({super.key});

  final List<Tab> tabList = [
    const Tab(
      text: "Deliver",
    ),
    const Tab(
      text: "Pick Up",
    ),
  ];

  final List<Iterable> coffeeList = [
    [Icons.edit, 'Edit Adderess'],
    [Icons.note_add_outlined, 'Add Note']
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabList.length,
        initialIndex: 0,
        child: Column(
          children: [
            BuildAppBarWidget(
              appBarTitle: 'Order',
              hasActionIcon: false,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: MyColors.mediumWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                tabs: tabList,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const BoxDecoration(
                  color: MyColors.brown,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                enableFeedback: true,
                indicatorPadding: const EdgeInsets.all(6),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                unselectedLabelStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, left: 20),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Delivery Address',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 16, left: 20),
                                child: const Text(
                                  'Jl. Kpg Sutoyo',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4, left: 20),
                                child: const Text(
                                  'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.lightGrey),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 30,
                          child: ListView.builder(
                            itemCount: coffeeList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = coffeeList[index];
                              return Container(
                                margin:
                                    EdgeInsets.only(left: index == 0 ? 20 : 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Icon(
                                          item.firstOrNull,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          item.lastOrNull,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: MyColors.mediumGrey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          height: 1,
                          width: double.infinity,
                          color: MyColors.deviderColor,
                        )
                      ],
                    ),
                  ),
                  const Center(
                    child: Text('Pick Up'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
