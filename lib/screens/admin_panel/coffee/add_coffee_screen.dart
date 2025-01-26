import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/screens/admin_panel/cubit/admin_pannel_cubit.dart';
import 'package:flutter_coffee/screens/widgets/coffee_size.dart';
import 'package:flutter_coffee/screens/widgets/select_coffee_location_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../utils/my_colors.dart';
import '../../widgets/app_bar.dart';
import '../cubit/admin_pannel_state.dart';

class AddCoffeeScreen extends StatefulWidget {
  const AddCoffeeScreen({super.key});

  @override
  _AddCoffeeScreenState createState() => _AddCoffeeScreenState();
}

enum CoffeeType { hot, cold }

class _AddCoffeeScreenState extends State<AddCoffeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _coffeeNameController = TextEditingController();
  final _coffeeDescriptionController = TextEditingController();
  final _coffeeAddressController = TextEditingController();
  final _coffeePriceController = TextEditingController();

  String coffeeShopLatLong = '';
  int coffeeRate = 0;
  int coffeeSize = 0;

  @override
  void dispose() {
    _coffeeNameController.dispose();
    _coffeeDescriptionController.dispose();
    _coffeeAddressController.dispose();

    super.dispose();
  }

  CoffeeType selectedCoffeeType = CoffeeType.hot;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => context.read<AdminPannelCubit>().resetData(),
      child: Scaffold(
        body: ListView(
          children: [
            const BuildAppBarWidget(
                appBarTitle: "Add Coffee",
                hasActionIcon: false,
                showBackButton: true),
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.only(left: 26, right: 26),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: TextFormField(
                        controller: _coffeeNameController,
                        decoration: const InputDecoration(
                          labelText: "Coffee Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: TextFormField(
                        controller: _coffeeAddressController,
                        decoration: const InputDecoration(
                          labelText: "Coffee Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: TextFormField(
                        maxLines: 3,
                        controller: _coffeeDescriptionController,
                        decoration: const InputDecoration(
                          labelText: "Coffee Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Coffee Type:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hot",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red
                                                    .withOpacity(0.8)),
                                          ),
                                          SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: Radio<CoffeeType>(
                                                value: CoffeeType.hot,
                                                groupValue: selectedCoffeeType,
                                                onChanged: (CoffeeType? value) {
                                                  setState(() {
                                                    selectedCoffeeType = value!;
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Cold",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Colors.blue.withOpacity(0.9),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: Radio<CoffeeType>(
                                                value: CoffeeType.cold,
                                                groupValue: selectedCoffeeType,
                                                onChanged: (CoffeeType? value) {
                                                  setState(() {
                                                    selectedCoffeeType = value!;
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 16),
                              height: 50,
                              alignment: Alignment.center,
                              child: TextFormField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                controller: _coffeePriceController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  prefix: Text(
                                    "\$",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 22,
                                    ),
                                  ),
                                  hintText: "Price",
                                  contentPadding:
                                      EdgeInsets.only(top: 12, left: 10),
                                  hintStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                  hintFadeDuration: Duration(milliseconds: 600),
                                ),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 22),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Coffee Rate:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            width: 4,
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemSize: 28,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                coffeeRate = rating.toInt();
                              });
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Coffee Image:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            width: 6,
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.read<AdminPannelCubit>().selectImage(),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: BlocBuilder<AdminPannelCubit,
                                    AdminPannelState>(
                                  builder: (context, state) {
                                    return Text(state.selectedImage.isEmpty
                                        ? "Select Image"
                                        : "Selected");
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Coffee Location:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            width: 6,
                          ),
                          GestureDetector(
                            onTap: () {
                              _showSelectMapDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: BlocBuilder<AdminPannelCubit,
                                    AdminPannelState>(
                                  builder: (context, state) {
                                    return Text(state.selectedLocation.isEmpty
                                        ? "Select Location"
                                        : "Selected");
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Coffee Size:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const CoffeeSizeWidget(
                      initValue: 0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: GestureDetector(
                        onTap: () {
                          String selectedCoffeeEnum =
                              selectedCoffeeType.name.toString();
                          String coffeeType =
                              selectedCoffeeEnum.substring(0, 1).toUpperCase() +
                                  selectedCoffeeEnum.substring(1);
                          context.read<AdminPannelCubit>().addCoffee(
                              _coffeeNameController.text,
                              coffeeType,
                              double.parse(
                                  _coffeePriceController.text.toString()),
                              _coffeeDescriptionController.text,
                              coffeeShopLatLong,
                              _coffeeAddressController.text,
                              coffeeRate,
                              coffeeSize.toString(),
                              context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors.brown,
                          ),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              child: const Text(
                                "Add Coffee",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectMapDialog() {
    if (context.mounted) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(5),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              width: MediaQuery.of(context).size.width - 50,
              height: 550, // Set the height to 400
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const SelecteMapPage(),
              ),
            ),
          );
        },
      );
    }
  }
}
