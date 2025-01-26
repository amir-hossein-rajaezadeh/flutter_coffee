import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class Utils {
  static void clearRoutesAndNavigateLogin(BuildContext context, String path) {
    while (context.canPop() == true) {
      context.pop();
    }
    context.pushReplacement(path);
  }
}
