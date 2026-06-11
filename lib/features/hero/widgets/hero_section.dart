import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/file_download.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/shared/widgets/glow_button.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
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
            // ── Animated background blobs ─────────────────────────────────
            _AnimatedBlob(
              controller: _gradientController,
              color: AppColors.primary.withValues(alpha: isDark ? 0.18 : 0.12),
              size: 450,
              offsetX: 0.1,
              offsetY: 0.25,
              mouseOffset: _mouseOffset,
            ),
            _AnimatedBlob(
              controller: _gradientController,
              color: AppColors.accent.withValues(alpha: isDark ? 0.12 : 0.08),
              size: 380,
              offsetX: 0.75,
              offsetY: 0.18,
              phaseShift: math.pi,
              mouseOffset: _mouseOffset,
            ),
            _AnimatedBlob(
              controller: _gradientController,
              color: AppColors.accentAlt.withValues(alpha: isDark ? 0.1 : 0.07),
              size: 320,
              offsetX: 0.6,
              offsetY: 0.72,
              phaseShift: math.pi / 2,
              mouseOffset: _mouseOffset,
            ),

            // ── Content ───────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.only(
                top: AppDimensions.navbarHeight,
                left: hPad,
                right: hPad,
                bottom: AppDimensions.xxl,
              ),
              child: isDesktop
                  ? _DesktopHeroLayout(
                      glowController: _glowController,
                      onViewProjects: widget.onViewProjects,
                      onLaunch: _launch,
                      titleSize: heroTitleSize,
                      roleSize: heroRoleSize,
                      mouseOffset: _mouseOffset,
                    )
                  : _MobileHeroLayout(
                      glowController: _glowController,
                      onViewProjects: widget.onViewProjects,
                      onLaunch: _launch,
                      imageSize: heroImageSize,
                      titleSize: heroTitleSize,
                      roleSize: heroRoleSize,
                      mouseOffset: _mouseOffset,
                    ),
            ),

            // ── Scroll indicator ─────────────────────────────────────────
            if (isDesktop)
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Center(child: _ScrollIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Desktop layout ──────────────────────────────────────────────────────────
class _DesktopHeroLayout extends StatelessWidget {
  final AnimationController glowController;
  final VoidCallback onViewProjects;
  final Future<void> Function(String) onLaunch;
  final double titleSize;
  final double roleSize;
  final Offset mouseOffset;

  const _DesktopHeroLayout({
    required this.glowController,
    required this.onViewProjects,
    required this.onLaunch,
    required this.titleSize,
    required this.roleSize,
    required this.mouseOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: _HeroText(
              onViewProjects: onViewProjects,
              onLaunch: onLaunch,
              titleSize: titleSize,
              roleSize: roleSize,
            ),
          ),
        ),
        const SizedBox(width: 60),
        _ProfileImage(glowController: glowController, mouseOffset: mouseOffset),
      ],
    );
  }
}

// ── Mobile layout ───────────────────────────────────────────────────────────
class _MobileHeroLayout extends StatelessWidget {
  final AnimationController glowController;
  final VoidCallback onViewProjects;
  final Future<void> Function(String) onLaunch;
  final double imageSize;
  final double titleSize;
  final double roleSize;
  final Offset mouseOffset;

  const _MobileHeroLayout({
    required this.glowController,
    required this.onViewProjects,
    required this.onLaunch,
    required this.imageSize,
    required this.titleSize,
    required this.roleSize,
    required this.mouseOffset,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          _ProfileImage(glowController: glowController, size: imageSize, mouseOffset: mouseOffset),
          const SizedBox(height: 32),
          _HeroText(
            onViewProjects: onViewProjects,
            onLaunch: onLaunch,
            centerAlign: true,
            titleSize: titleSize,
            roleSize: roleSize,
          ),
        ],
      ),
    );
  }
}

// ── Hero text ───────────────────────────────────────────────────────────────
class _HeroText extends StatefulWidget {
  final VoidCallback onViewProjects;
  final Future<void> Function(String) onLaunch;
  final bool centerAlign;
  final double titleSize;
  final double roleSize;

  const _HeroText({
    required this.onViewProjects,
    required this.onLaunch,
    this.centerAlign = false,
    required this.titleSize,
    required this.roleSize,
  });

  @override
  State<_HeroText> createState() => _HeroTextState();
}

class _HeroTextState extends State<_HeroText> {
  int _lineIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    _tickTyping();
  }

  void _tickTyping() {
    Future.delayed(
      Duration(
        milliseconds: _deleting
            ? 35
            : _charIndex == AppStrings.heroBioLines[_lineIndex].length
                ? 1300
                : 55,
      ),
      () {
        if (!mounted) return;
        setState(() {
          final current = AppStrings.heroBioLines[_lineIndex];
          if (_deleting) {
            _charIndex--;
            if (_charIndex <= 0) {
              _charIndex = 0;
              _deleting = false;
              _lineIndex = (_lineIndex + 1) % AppStrings.heroBioLines.length;
            }
          } else if (_charIndex < current.length) {
            _charIndex++;
          } else {
            _deleting = true;
          }
        });
        _tickTyping();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final align = widget.centerAlign ? TextAlign.center : TextAlign.start;
    final crossAlign =
        widget.centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final mainAlign =
        widget.centerAlign ? MainAxisAlignment.center : MainAxisAlignment.start;
    final activeLine = AppStrings.heroBioLines[_lineIndex];
    final typedText = activeLine.substring(0, _charIndex);

    return Column(
      crossAxisAlignment: crossAlign,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Name with gradient
        Column(
          crossAxisAlignment: crossAlign,
          children: [
            Text(
              "Hi, I'm",
              textAlign: align,
              style: GoogleFonts.inter(
                fontSize: widget.titleSize,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.darkText : AppColors.lightText,
                height: 1.1,
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                AppStrings.name,
                textAlign: align,
                style: GoogleFonts.inter(
                  fontSize: widget.titleSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 400.ms)
            .slideY(begin: 0.3, end: 0, duration: 700.ms, delay: 400.ms),
        const SizedBox(height: 12),

        // Role
        Text(
          AppStrings.role,
          textAlign: align,
          style: GoogleFonts.inter(
            fontSize: widget.roleSize,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 600.ms),
        const SizedBox(height: 20),

        // Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text.rich(
            TextSpan(
              text: typedText,
              children: [
                TextSpan(
                  text: '|',
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            ),
            textAlign: align,
            style: theme.textTheme.bodyLarge,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 800.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 800.ms),
        const SizedBox(height: 44),

        // Buttons
        Wrap(
          alignment:
              widget.centerAlign ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 12,
          children: [
            GlowButton(
              label: 'View Projects',
              icon: Icons.work_outline_rounded,
              onPressed: widget.onViewProjects,
            ),
            GlowButton(
              label: 'Download Resume',
              icon: Icons.download_rounded,
              outlined: true,
              onPressed: () => downloadAsset(
                AppStrings.resumePath,
                fileName: 'mahmoud_safa_resume.pdf',
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 1000.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 1000.ms),
        const SizedBox(height: 32),

        // Social icons
        Row(
          mainAxisAlignment: mainAlign,
          children: [
            _SocialIcon(
              assetPath: 'assets/images/github_logo.jpg',
              label: 'GitHub',
              url: AppStrings.github,
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              assetPath: 'assets/images/linkedin_logo.png',
              label: 'LinkedIn',
              url: AppStrings.linkedin,
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.email_rounded,
              label: 'Email',
              url: AppStrings.emailLink,
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 1200.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 1200.ms),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData? icon;
  final String? assetPath;
  final String label;
  final String url;

  const _SocialIcon({
    this.icon,
    this.assetPath,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final assetSize = widget.label == 'LinkedIn' ? 32.0 : 24.0;
    final assetPadding = widget.label == 'LinkedIn' ? 6.0 : 8.0;

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
        child: Tooltip(
          message: widget.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : AppColors.primary.withValues(alpha: 0.08),
              border: Border.all(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : AppColors.primary.withValues(alpha: 0.2),
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                      ),
                    ]
                  : [],
            ),
            child: widget.assetPath == null
                ? Icon(widget.icon, size: 20, color: AppColors.primary)
                : Padding(
                    padding: EdgeInsets.all(assetPadding),
                    child: ClipOval(
                      child: Image.asset(
                        widget.assetPath!,
                        width: assetSize,
                        height: assetSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Profile image ────────────────────────────────────────────────────────────
class _ProfileImage extends StatelessWidget {
  final AnimationController glowController;
  final double size;
  final Offset mouseOffset;

  const _ProfileImage({
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

// ── Animated background blob ─────────────────────────────────────────────────
class _AnimatedBlob extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final double size;
  final double offsetX;
  final double offsetY;
  final double phaseShift;
  final Offset mouseOffset;

  const _AnimatedBlob({
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

class _ScrollIndicator extends StatelessWidget {
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
