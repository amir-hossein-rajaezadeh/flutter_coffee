import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/cubit/cubit/app_cubit.dart';
import 'package:flutter_coffee/cubit/cubit/app_state.dart';
import 'package:flutter_coffee/models/card_list_rm.dart';
import 'package:flutter_coffee/screens/widgets/app_bar.dart';
import 'package:flutter_coffee/screens/widgets/devider.dart';
import 'package:go_router/go_router.dart';
import '../utils/my_colors.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({
    super.key,
  });

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
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
  void initState() {
    context.read<AppCubit>().getCardList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: DefaultTabController(
        length: tabList.length,
        initialIndex: 0,
        child: Column(
          children: [
            const BuildAppBarWidget(
              showBackButton: true,
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
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 20),
                                          alignment: Alignment.topLeft,
                                          child: const Text(
                                            'Delivery Address',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 16, left: 20),
                                          child: const Text(
                                            'Jl. Kpg Sutoyo',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 4, left: 20),
                                          child: Text(
                                            state.coffeeItem.coffeeAddress!,
                                            style: const TextStyle(
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
                                          margin: EdgeInsets.only(
                                              left: index == 0 ? 20 : 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: MyColors.deviderColor),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10, left: 10),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    item.firstOrNull,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    item.lastOrNull,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            MyColors.mediumGrey,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                  ),
                                  SizedBox(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          state.cardList.detail.data.length,
                                      padding: const EdgeInsets.only(top: 0),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        final CardModel cardItem =
                                            state.cardList.detail.data[index];
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              right: 20, left: 20, top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 54,
                                                    height: 54,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        cardItem.coffee.image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          cardItem.coffee
                                                              .coffeeName,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        ),
                                                        Text(
                                                          "${cardItem.coffee.price.round()}\$",
                                                          style: const TextStyle(
                                                              color: MyColors
                                                                  .lightGrey,
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 4),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () => context
                                                                .read<
                                                                    AppCubit>()
                                                                .addItemToCart(
                                                                    cardItem
                                                                        .coffee
                                                                        .id
                                                                        .toInt(),
                                                                    (cardItem
                                                                            .count--)
                                                                        .toInt(),
                                                                    context),
                                                            child: Container(
                                                              width: 24,
                                                              height: 24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: MyColors
                                                                        .lightGrey),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  CupertinoIcons
                                                                      .minus,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Text(
                                                              cardItem.count
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () => context
                                                                .read<
                                                                    AppCubit>()
                                                                .addItemToCart(
                                                                    cardItem
                                                                        .coffee
                                                                        .id,
                                                                    cardItem
                                                                        .count++,
                                                                    context),
                                                            child: Container(
                                                              width: 24,
                                                              height: 24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: MyColors
                                                                        .lightGrey),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  CupertinoIcons
                                                                      .add,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => context
                                                          .read<AppCubit>()
                                                          .removeItemFromCart(
                                                              cardItem.id
                                                                  .toInt(),
                                                              context),
                                                      child: const Row(
                                                        children: [
                                                          Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 11),
                                                          ),
                                                          Icon(
                                                            CupertinoIcons
                                                                .delete,
                                                            color: Colors.red,
                                                            size: 14,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: const DeviderWidget(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 360,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 56,
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                          right: 20, left: 20, top: 16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: MyColors.mediumWhite),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                                'assets/icons/discount.png'),
                                            const Text(
                                              '1 Discount is Applies',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Column(
                                      children: [],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 20, right: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Payemnt Summery',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 16, bottom: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: const Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Price',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Delivery Fee',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            '\$${state.cardList.detail.price}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                          ),
                                                          const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                '\$2.0',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                '\$1.0',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    decorationColor:
                                                                        Colors
                                                                            .grey,
                                                                    decorationThickness:
                                                                        2.0,
                                                                    fontSize:
                                                                        14),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 165,
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(18),
                                                topRight: Radius.circular(18),
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.topCenter,
                                              margin: const EdgeInsets.only(
                                                  top: 20, right: 28, left: 28),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: const Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Cash/Wallet',
                                                              style: TextStyle(
                                                                  color: MyColors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              '\$4.53',
                                                              style: TextStyle(
                                                                  color: MyColors
                                                                      .brown,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: const Icon(Icons
                                                            .keyboard_arrow_down_sharp),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => state
                                                            .coffeeItem
                                                            .coffeeShopLocation!
                                                            .isEmpty
                                                        ? ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                            SnackBar(
                                                              content: const Text(
                                                                  'The Coffee-Shop Does NOT have Valid Location Submited!'),
                                                              action:
                                                                  SnackBarAction(
                                                                onPressed: () {
                                                                 },
                                                                label: 'Close',
                                                              ),
                                                            ),
                                                          )
                                                        : context.push("/map"),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 0),
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(14),
                                                          color: state
                                                                  .coffeeItem
                                                                  .coffeeShopLocation!
                                                                  .isEmpty
                                                              ? Colors.grey[400]
                                                              : MyColors.brown),
                                                      child: const Center(
                                                        child: Text(
                                                          'Buy Now',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Center(
                        child: Text('Pick Up'),
                      )
                    ],
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
