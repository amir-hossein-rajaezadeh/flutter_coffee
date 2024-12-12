import 'package:flutter/cupertino.dart';
import 'package:flutter_coffee/utils/my_colors.dart';

class DeviderWidget extends StatelessWidget {
  const DeviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: MyColors.deviderColor,
    );
  }
}
