import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedLike extends StatelessWidget {
  final Widget widget;
  const AnimatedLike({super.key,required this.widget});

  @override
  Widget build(BuildContext context) {
    return widget.animate(onComplete: (controller) => controller.stop())
                        .fadeIn(duration: 400.ms)
                        .scale(
                          duration: 400.ms,
                          curve: Curves.easeOutBack,
                          begin: Offset(0.5, 0.5),
                          end: Offset(1.2, 1.2),
                        )
                        .then()
                        .moveY(
                          begin: 0,
                          end: -30,
                          duration: 700.ms,
                          curve: Curves.easeOut,
                        )
                        .rotate(begin: -0.1, end: 0.1, duration: 700.ms)
                        .fadeOut(duration: 500.ms);
  }
}