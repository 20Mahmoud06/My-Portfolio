import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hero_animated_blob.dart';
import 'hero_layouts.dart';
import 'hero_scroll_indicator.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;

  const HeroSection({super.key, required this.onViewProjects});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _glowController;
  Offset _mouseOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _onMouseMove(PointerHoverEvent event) {
    final size = MediaQuery.sizeOf(context);
    setState(() {
      _mouseOffset = Offset(
        ((event.localPosition.dx / size.width) - 0.5) * 2,
        ((event.localPosition.dy / size.height) - 0.5) * 2,
      );
    });
  }

  void _onMouseExit(PointerExitEvent event) {
    setState(() => _mouseOffset = Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final hPad = ResponsiveLayout.horizontalPadding(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final heroTitleSize = isDesktop ? 52.0 : (isTablet ? 44.0 : 38.0);
    final heroRoleSize = isDesktop ? 22.0 : (isTablet ? 20.0 : 18.0);
    final heroImageSize = isDesktop ? 320.0 : (isTablet ? 260.0 : screenWidth * 0.6).clamp(160.0, 260.0);

    return SizedBox(
      width: double.infinity,
      height: math.max(screenHeight, isDesktop ? 700 : 640),
      child: MouseRegion(
        onHover: isDesktop ? _onMouseMove : null,
        onExit: isDesktop ? _onMouseExit : null,
        child: Stack(
          children: [
            HeroAnimatedBlob(
              controller: _gradientController,
              color: AppColors.primary.withValues(alpha: isDark ? 0.18 : 0.12),
              size: 450,
              offsetX: 0.1,
              offsetY: 0.25,
              mouseOffset: _mouseOffset,
            ),
            HeroAnimatedBlob(
              controller: _gradientController,
              color: AppColors.accent.withValues(alpha: isDark ? 0.12 : 0.08),
              size: 380,
              offsetX: 0.75,
              offsetY: 0.18,
              phaseShift: math.pi,
              mouseOffset: _mouseOffset,
            ),
            HeroAnimatedBlob(
              controller: _gradientController,
              color: AppColors.accentAlt.withValues(alpha: isDark ? 0.1 : 0.07),
              size: 320,
              offsetX: 0.6,
              offsetY: 0.72,
              phaseShift: math.pi / 2,
              mouseOffset: _mouseOffset,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: AppDimensions.navbarHeight,
                left: hPad,
                right: hPad,
                bottom: AppDimensions.xxl,
              ),
              child: isDesktop
                  ? HeroDesktopLayout(
                      glowController: _glowController,
                      onViewProjects: widget.onViewProjects,
                      onLaunch: _launch,
                      titleSize: heroTitleSize,
                      roleSize: heroRoleSize,
                      mouseOffset: _mouseOffset,
                    )
                  : HeroMobileLayout(
                      glowController: _glowController,
                      onViewProjects: widget.onViewProjects,
                      onLaunch: _launch,
                      imageSize: heroImageSize,
                      titleSize: heroTitleSize,
                      roleSize: heroRoleSize,
                      mouseOffset: _mouseOffset,
                    ),
            ),
            if (isDesktop)
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Center(child: const HeroScrollIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }
}
