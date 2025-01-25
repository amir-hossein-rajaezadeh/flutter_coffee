import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/cubit/cubit/app_cubit.dart';
import 'package:flutter_coffee/cubit/cubit/app_state.dart';
import 'package:flutter_coffee/models/coffee_model_rm.dart';
import 'package:flutter_coffee/screens/widgets/app_bar.dart';
import 'package:flutter_coffee/screens/widgets/loading_widget.dart';
import 'package:flutter_coffee/utils/my_colors.dart';

class DetailScreen extends StatefulWidget {
  final num coffeeId;

  const DetailScreen({super.key, required this.coffeeId});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedCoffeeSize = 0;

  @override
  void initState() {
    context.read<AppCubit>().getCoffeeDetail(
          widget.coffeeId.toInt(),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const BuildAppBarWidget(
                appBarTitle: 'Detail',
                hasActionIcon: true,
              ),
              Expanded(
                child: BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    final CoffeeModelRM coffeeItem = state.coffeeItem;
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 12, right: 12, left: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              coffeeItem.image ?? '',
                              width: 400,
                              height: 200,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coffeeItem.coffeeName ?? "",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    coffeeItem.coffeeType ?? "",
                                    style: const TextStyle(
                                        color: MyColors.lightGrey),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: MyColors.mediumWhite,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/bike.png',
                                              height: 26,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: MyColors.mediumWhite,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/coffee.png',
                                              height: 26,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: MyColors.mediumWhite,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/milk.png',
                                              height: 26,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.star_fill,
                                      color: MyColors.yellow,
                                    ),
                                    Text(
                                      coffeeItem.rate.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      ' (${coffeeItem.commentCount})',
                                      style: const TextStyle(
                                          color: MyColors.lightGrey,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20, right: 18, left: 18),
                                height: 1,
                                color: MyColors.lightGrey,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      child: Text(
                                        coffeeItem.desc ?? "",
                                        style: const TextStyle(
                                            color: MyColors.lightGrey,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 10),
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        'Size',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              selectedCoffeeSize = 0;
                                            }),
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 170),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: selectedCoffeeSize == 0
                                                    ? MyColors.brown
                                                        .withOpacity(0.2)
                                                    : Colors.white,
                                                border: Border.all(
                                                    width: 1.6,
                                                    color: selectedCoffeeSize ==
                                                            0
                                                        ? MyColors.brown
                                                        : MyColors.lightGrey),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50,
                                                        vertical: 10),
                                                child: Center(
                                                  child: Text(
                                                    'S',
                                                    style: TextStyle(
                                                        color:
                                                            selectedCoffeeSize ==
                                                                    0
                                                                ? MyColors.brown
                                                                : Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              selectedCoffeeSize = 1;
                                            }),
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 170),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: selectedCoffeeSize == 1
                                                    ? MyColors.brown
                                                        .withOpacity(0.2)
                                                    : Colors.white,
                                                border: Border.all(
                                                    width: 1.6,
                                                    color: selectedCoffeeSize ==
                                                            1
                                                        ? MyColors.brown
                                                        : MyColors.lightGrey),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50,
                                                        vertical: 10),
                                                child: Center(
                                                  child: Text(
                                                    'M',
                                                    style: TextStyle(
                                                        color:
                                                            selectedCoffeeSize ==
                                                                    1
                                                                ? MyColors.brown
                                                                : Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              selectedCoffeeSize = 2;
                                            }),
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 170),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: selectedCoffeeSize == 2
                                                    ? MyColors.brown
                                                        .withOpacity(0.2)
                                                    : Colors.white,
                                                border: Border.all(
                                                    width: 1.6,
                                                    color: selectedCoffeeSize ==
                                                            2
                                                        ? MyColors.brown
                                                        : MyColors.lightGrey),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50,
                                                        vertical: 10),
                                                child: Center(
                                                  child: Text(
                                                    'L',
                                                    style: TextStyle(
                                                        color:
                                                            selectedCoffeeSize ==
                                                                    2
                                                                ? MyColors.brown
                                                                : Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 120,
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Price',
                                          style: TextStyle(
                                              color: MyColors.lightGrey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\$${coffeeItem.price}',
                                          style: const TextStyle(
                                              color: MyColors.brown,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => context
                                          .read<AppCubit>()
                                          .addItemToCart(
                                              coffeeItem.id!, context),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 40),
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: MyColors.brown),
                                        child: const Center(
                                          child: Text(
                                            'Buy Now',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return state.isLoading ? const LoadingWidget() : Container();
            },
          )
        ],
      ),
    );
  }
}
