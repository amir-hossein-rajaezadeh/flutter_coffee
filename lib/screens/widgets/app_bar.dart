import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildAppBarWidget extends StatelessWidget {
  BuildAppBarWidget(
      {super.key, required this.appBarTitle, required this.hasActionIcon});
  bool hasActionIcon = false;
  String appBarTitle = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 12, left: 12),
      child: AppBar(
        actions: [
          if (hasActionIcon)
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(CupertinoIcons.heart),
            )
        ],
        title: Text(
          appBarTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
      ),
    );
  }
}
