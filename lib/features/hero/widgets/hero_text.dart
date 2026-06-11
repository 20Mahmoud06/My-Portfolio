import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/file_download.dart';
import 'package:my_portfolio/shared/widgets/glow_button.dart';
import 'hero_social_icon.dart';

class HeroText extends StatefulWidget {
  final VoidCallback onViewProjects;
  final Future<void> Function(String) onLaunch;
  final bool centerAlign;
  final double titleSize;
  final double roleSize;

  const HeroText({
    super.key,
    required this.onViewProjects,
    required this.onLaunch,
    this.centerAlign = false,
    required this.titleSize,
    required this.roleSize,
  });

  @override
  State<HeroText> createState() => _HeroTextState();
}

class _HeroTextState extends State<HeroText> {
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
    final activeLine = AppStrings.heroBioLines[_lineIndex];
    final typedText = activeLine.substring(0, _charIndex);

    return Column(
      crossAxisAlignment: crossAlign,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment:
              widget.centerAlign ? WrapAlignment.center : WrapAlignment.start,
          children: [
            HeroSocialIcon(
              assetPath: 'assets/images/github_logo.jpg',
              label: 'GitHub',
              url: AppStrings.github,
            ),
            HeroSocialIcon(
              assetPath: 'assets/images/linkedin_logo.png',
              label: 'LinkedIn',
              url: AppStrings.linkedin,
            ),
            HeroSocialIcon(
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
