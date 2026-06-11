import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'contact_row.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          padding: EdgeInsets.all(isMobile ? 28 : 48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      AppColors.darkSurface.withValues(alpha: 0.8),
                      AppColors.darkSurface2.withValues(alpha: 0.8),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.9),
                      AppColors.lightSurface2.withValues(alpha: 0.9),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: isDark
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : AppColors.primary.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.1),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.waving_hand_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  )
                  .fadeIn(duration: 600.ms),
              const SizedBox(height: 24),
              Text(
                "Open to opportunities",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Let's Build Something Great",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              const SizedBox(height: 40),
              ContactRow(
                icon: Icons.email_outlined,
                label: AppStrings.email,
                url: AppStrings.emailLink,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              ContactRow(
                assetPath: 'assets/images/linkedin_logo.png',
                assetSize: 32,
                label: 'linkedin.com/in/20mahmoud-safa06',
                url: AppStrings.linkedin,
                color: const Color(0xFF0A66C2),
              ),
              const SizedBox(height: 16),
              ContactRow(
                assetPath: 'assets/images/github_logo.jpg',
                label: 'github.com/20Mahmoud06',
                url: AppStrings.github,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
