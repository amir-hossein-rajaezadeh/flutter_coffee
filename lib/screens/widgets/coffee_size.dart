import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/utils/my_colors.dart';

import '../admin_panel/cubit/admin_pannel_cubit.dart';

class CoffeeSizeWidget extends StatefulWidget {
  const CoffeeSizeWidget({
    super.key,
    required this.initValue,
  });
  final int initValue;

  @override
  State<CoffeeSizeWidget> createState() => _CoffeeSizeWidgetState();
}

enum CoffeeSize { S, M, L }

class _CoffeeSizeWidgetState extends State<CoffeeSizeWidget> {
  int selectedCoffeeSize = CoffeeSize.S.index;
  @override
  void initState() {
    setState(() {
      selectedCoffeeSize = widget.initValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCoffeeSize = index;
                });
                context.read<AdminPannelCubit>().setSelectedCoffeeSize(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 170),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: selectedCoffeeSize == index
                      ? MyColors.brown.withOpacity(0.2)
                      : Colors.white,
                  border: Border.all(
                      width: 1.6,
                      color: selectedCoffeeSize == index
                          ? MyColors.brown
                          : MyColors.lightGrey),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Center(
                    child: Text(
                      CoffeeSize.values[index].name,
                      style: TextStyle(
                          color: selectedCoffeeSize == index
                              ? MyColors.brown
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 22,
            );
          },
        ),
      ),
    );
  }
}
