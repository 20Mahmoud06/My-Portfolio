import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class HeroAnimatedBlob extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final double size;
  final double offsetX;
  final double offsetY;
  final double phaseShift;
  final Offset mouseOffset;

  const HeroAnimatedBlob({
    super.key,
    required this.controller,
    required this.color,
    required this.size,
    required this.offsetX,
    required this.offsetY,
    this.phaseShift = 0,
    this.mouseOffset = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = (controller.value + phaseShift / (2 * math.pi)) % 1.0;
        final dx = math.sin(t * 2 * math.pi) * 30 + mouseOffset.dx * 20;
        final dy = math.cos(t * 2 * math.pi) * 20 + mouseOffset.dy * 15;
        final screenSize = MediaQuery.sizeOf(context);
        return Positioned(
          left: screenSize.width * offsetX + dx - size / 2,
          top: screenSize.height * offsetY + dy - size / 2,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }
}
