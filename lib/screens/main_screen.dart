import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/screens/detail_screen.dart';
import 'package:flutter_coffee/utils/my_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> tabList = ['All Coffee', 'Machiato', 'Latte', 'Americano'];
  int selectedNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                selectedNavBarIndex = value;
              });
            },
            iconSize: 28,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedNavBarIndex,
            selectedItemColor: MyColors.brown,
            unselectedItemColor: MyColors.lightGrey,
            selectedFontSize: 0,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.house_fill,
                  ),
                  label: '',
                  tooltip: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedNavBarIndex == 1
                      ? CupertinoIcons.suit_heart_fill
                      : CupertinoIcons.suit_heart,
                ),
                label: '',
                tooltip: 'Like',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedNavBarIndex == 2
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined,
                ),
                label: '',
                tooltip: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedNavBarIndex == 3
                      ? CupertinoIcons.bell_fill
                      : CupertinoIcons.bell,
                ),
                label: '',
                tooltip: 'Notifications',
              ),
            ]),
        body: selectedNavBarIndex == 0
            ? _mainPage()
            : selectedNavBarIndex == 1
                ? const Center(
                    child: Text('Likes'),
                  )
                : (selectedNavBarIndex == 2)
                    ? const Center(
                        child: Text('Shop'),
                      )
                    : const Center(
                        child: Text('Notifications'),
                      ));
  }

  Column _mainPage() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: MyColors.gradiuntListColor),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 24, top: 64),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                              color: MyColors.lightGrey, fontSize: 12),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              'Bilzen, Tanjungbalai',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'Search Cofee',
                              hintStyle: TextStyle(color: MyColors.lightGrey),
                              enabled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 24),
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors.brown),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/config.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/main_banner.png',
                      alignment: Alignment.center,
                      width: 400,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 13, left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 26,
                            decoration: BoxDecoration(
                              color: MyColors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Promo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 200,
                            child: Text(
                              'Buy one, get one FREE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 110, left: 18, bottom: 8),
          height: 30,
          child: ListView.separated(
            itemCount: tabList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String item = tabList[index];
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: index == 0 ? MyColors.brown : MyColors.mediumWhite),
                width: 100,
                height: 30,
                child: Center(
                  child: Text(
                    item,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: index == 0 ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 16);
            },
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 11,
              crossAxisSpacing: 11,
              childAspectRatio: 0.8,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailScreen(),
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/coffee_${index + 1}.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coffee ${index + 1}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              child: const Text(
                                'Deep Foeam',
                                style: TextStyle(
                                    color: MyColors.lightGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${(index + 1) * 4}.99',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MyColors.brown),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 10,
                            )
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
      ],
    );
  }
}
