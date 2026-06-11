import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/animated_section.dart';
import '../../../shared/widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveLayout.horizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: Column(
            children: [
              AnimatedSection(
                visibilityKey: 'contact-header',
                child: SectionHeader(
                  label: AppStrings.contactSectionLabel,
                  title: AppStrings.contactSectionTitle,
                  subtitle: AppStrings.contactSubtitle,
                ),
              ),
              const SizedBox(height: 60),
              AnimatedSection(
                visibilityKey: 'contact-card',
                delay: const Duration(milliseconds: 200),
                child: const _ContactCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

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
              // Icon
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
              // Contact links
              _ContactRow(
                icon: Icons.email_outlined,
                label: AppStrings.email,
                url: AppStrings.emailLink,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              _ContactRow(
                assetPath: 'assets/images/linkedin_logo.png',
                assetSize: 32,
                label: 'linkedin.com/in/20mahmoud-safa06',
                url: AppStrings.linkedin,
                color: const Color(0xFF0A66C2),
              ),
              const SizedBox(height: 16),
              _ContactRow(
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

class _ContactRow extends StatefulWidget {
  final IconData? icon;
  final String? assetPath;
  final double assetSize;
  final String label;
  final String url;
  final Color color;

  const _ContactRow({
    this.icon,
    this.assetPath,
    this.assetSize = 22,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, webOnlyWindowName: '_blank');
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            color: _hovered
                ? widget.color.withValues(alpha: 0.08)
                : Colors.transparent,
            border: Border.all(
              color: _hovered
                  ? widget.color.withValues(alpha: 0.3)
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                child: Center(
                  child: widget.assetPath == null
                      ? Icon(widget.icon, size: 20, color: widget.color)
                      : ClipOval(
                          child: Image.asset(
                            widget.assetPath!,
                            width: widget.assetSize,
                            height: widget.assetSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight:
                        _hovered ? FontWeight.w600 : FontWeight.w400,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    decoration: _hovered
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: widget.color,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: _hovered ? widget.color : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
