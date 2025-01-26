import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../admin_panel/cubit/admin_pannel_cubit.dart';

class SelecteMapPage extends StatefulWidget {
  const SelecteMapPage({
    super.key,
  });

  @override
  _SelecteMapPageState createState() => _SelecteMapPageState();
}

class _SelecteMapPageState extends State<SelecteMapPage> {
  LatLng? selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09), // Initial map center
          zoom: 13.0,
          onTap: (tapPosition, point) {
            setState(() {
              selectedPoint = point;
            });
            print("Selected Point: ${point.latitude}, ${point.longitude}");
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: selectedPoint != null
                ? [
                    Marker(
                      point: selectedPoint!,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ]
                : [],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () {
          Navigator.pop(context);
          if (selectedPoint != null) {
            context.read<AdminPannelCubit>().selectCoffeeLocationLatLong(
                LatLng(selectedPoint!.latitude, selectedPoint!.longitude));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Selected: ${selectedPoint!.latitude}, ${selectedPoint!.longitude}"),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No point selected")),
            );
          }
        },
      ),
    );
  }
}
