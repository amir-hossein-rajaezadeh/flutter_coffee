import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 95,
      height: 95,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Lottie.asset("assets/animations/loading_coffee.json",
                  alignment: Alignment.center, fit: BoxFit.fitWidth, width: 80),
            ),
            Positioned(
              bottom: 10,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Loading',
                      speed: const Duration(milliseconds: 280),
                      textStyle: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
