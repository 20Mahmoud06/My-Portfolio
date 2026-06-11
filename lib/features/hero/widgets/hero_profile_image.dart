import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class HeroProfileImage extends StatelessWidget {
  final AnimationController glowController;
  final double size;
  final Offset mouseOffset;

  const HeroProfileImage({
    super.key,
    required this.glowController,
    this.size = 320,
    this.mouseOffset = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowController,
      builder: (context, child) {
        final glow = (math.sin(glowController.value * math.pi * 2) + 1) / 2;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(-mouseOffset.dy * 0.08)
            ..rotateY(mouseOffset.dx * 0.08),
          alignment: Alignment.center,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2 + glow * 0.2),
                  blurRadius: 40 + glow * 20,
                  spreadRadius: 4 + glow * 4,
                ),
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.1 + glow * 0.15),
                  blurRadius: 60 + glow * 20,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
        ),
        padding: const EdgeInsets.all(4),
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: AppColors.darkSurface,
              child: Icon(
                Icons.person_rounded,
                size: size * 0.5,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: 600.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 800.ms,
          delay: 600.ms,
          curve: Curves.easeOutBack,
        );
  }
}
