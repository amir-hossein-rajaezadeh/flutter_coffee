import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/utils/my_colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final LatLng coffeeLocation = LatLng(40.6859, -73.9802);
  final LatLng homeLocation = LatLng(40.687983761053765, -73.9787030889008);
  final MapController _mapController = MapController();
  List<LatLng> route = [];
  LatLng? animatedBikePosition;
  int currentPointIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _getRoute();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Speed of the bike
    );

    _animationController.addListener(() {
      setState(() {
        if (route.isNotEmpty && currentPointIndex < route.length - 1) {
          final start = route[currentPointIndex];
          final end = route[currentPointIndex + 1];
          animatedBikePosition = LatLng(
            start.latitude + (end.latitude - start.latitude) * _animation.value,
            start.longitude +
                (end.longitude - start.longitude) * _animation.value,
          );
        }
      });
    });

    _animationController.addStatusListener((status) {
      
      if (status == AnimationStatus.completed &&
          currentPointIndex < route.length - 1) {
        currentPointIndex++;
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  Future<void> _getRoute() async {
    const apiKey = '5b3ce3597851110001cf6248094cb0e33e9c4aef93f66abb7ea53e5f';
    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${coffeeLocation.longitude},${coffeeLocation.latitude}&end=${homeLocation.longitude},${homeLocation.latitude}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates =
          data['features'][0]['geometry']['coordinates'];
      setState(() {
        route = coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
        animatedBikePosition = route.first;
      });

      _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear),
      );

      _animationController.forward();
    } else {
      print('Failed to fetch route: ${response.body}');
      throw Exception('Failed to load route');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: coffeeLocation,
                zoom: 16.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 120.0,
                      height: 170.0,
                      point: coffeeLocation,
                      builder: (ctx) => Container(
                        margin: const EdgeInsets.only(bottom: 47),
                        child: lottie.Lottie.asset(
                            "assets/animations/store_anim.json",
                            fit: BoxFit.cover),
                      ),
                    ),
                    Marker(
                      width: 50,
                      height: 100.0,
                      point: homeLocation,
                      builder: (ctx) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        margin: const EdgeInsets.only(bottom: 48),
                        child: lottie.Lottie.asset(
                            "assets/animations/location_anim.json"),
                      ),
                    ),
                    if (animatedBikePosition != null)
                      Marker(
                        width: 45,
                        height: 45,
                        point: animatedBikePosition!,
                        builder: (ctx) => Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 8,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Image.asset("assets/icons/bike_right.png"),
                          ),
                        ),
                      )
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: route,
                      strokeWidth: 4.0,
                      color: MyColors.brown,
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildAppBarWidget(context),
          _buildBottomSheetWidget()
        ],
      ),
    );
  }

  Container _buildAppBarWidget(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 90, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () =>context.pop() ,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.mediumWhite),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _mapController.move(
                coffeeLocation,
                16,
              );
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.mediumWhite),
              child: const Center(
                child: Icon(
                  Icons.gps_fixed,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheetWidget() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 18),
              alignment: Alignment.center,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.deviderColor),
              height: 5,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              '10 minutes left',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deliver To  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.deviderColor,
                      fontSize: 12),
                ),
                Text(
                  'Jl. Kpg Sutoyo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
            height: 5,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 1,
                  width: 71,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MyColors.greenColor),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 40, left: 20, top: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.deviderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 20, left: 14),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MyColors.deviderColor),
                    ),
                    child: Image.asset(
                      'assets/icons/bike.png',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deliver Your order',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6, bottom: 8),
                          width: 220,
                          child: const Text(
                            'We will deliver your goods to you in the shortes possible time.',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 20, right: 35, left: 20, bottom: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset('assets/images/profile.png'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brooklyn Simmons',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            'Personal Courier',
                            style: TextStyle(
                                color: MyColors.lightGrey, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MyColors.lightGrey)),
                  child: const Center(
                    child: Icon(CupertinoIcons.phone),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
