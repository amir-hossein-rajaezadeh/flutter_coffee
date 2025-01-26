import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/models/card_list_rm.dart';
import 'package:flutter_coffee/screens/admin_panel/cubit/admin_pannel_cubit.dart';
import 'package:flutter_coffee/screens/widgets/app_bar.dart';

import '../cubit/admin_pannel_state.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminPannelCubit>()
      ..getCardList()
      ..setupInterceptors(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const BuildAppBarWidget(
                appBarTitle: "Card List",
                hasActionIcon: false,
                showBackButton: true),
            BlocBuilder<AdminPannelCubit, AdminPannelState>(
              builder: (context, state) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        // Container(
                        //   margin: const EdgeInsets.only(left: 20),
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     "User:${username.firstName}",
                        //     style: const TextStyle(
                        //         fontSize: 26, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Expanded(
                          child: state.cardList.detail.data.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No Order is Avaleble right Now💔',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: state.cardList.detail.data.length,
                                  padding: const EdgeInsets.only(top: 0),
                                  itemBuilder: (context, index) {
                                    final CardModel cardItem =
                                        state.cardList.detail.data[index];

                                    return Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.4)),
                                          borderRadius:
                                              BorderRadius.circular(14)),
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
                                                  child: Image.network(
                                                    cardItem.coffee.image,
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          cardItem.coffee
                                                              .coffeeName,
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          cardItem
                                                              .coffee.buyCount
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 12),
                                              child: Text(cardItem.coffee.price
                                                  .toString()),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
