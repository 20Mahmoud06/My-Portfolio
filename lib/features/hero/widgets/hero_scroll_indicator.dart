import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class HeroScrollIndicator extends StatelessWidget {
  const HeroScrollIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Scroll down',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.primary.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 8),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.primary.withValues(alpha: 0.6),
        )
            .animate(onPlay: (c) => c.repeat())
            .moveY(begin: 0, end: 6, duration: 800.ms)
            .then()
            .moveY(begin: 6, end: 0, duration: 800.ms),
      ],
    );
  }
}
