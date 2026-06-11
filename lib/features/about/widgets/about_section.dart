import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/shared/widgets/animated_section.dart';
import 'package:my_portfolio/shared/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
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
          child: isDesktop ? const _DesktopAbout() : const _MobileAbout(),
        ),
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  const _DesktopAbout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 5,
          child: AnimatedSection(
            visibilityKey: 'about-left',
            slideOffset: Offset(-40, 0),
            child: _AboutText(),
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: AnimatedSection(
            visibilityKey: 'about-right',
            slideOffset: const Offset(40, 0),
            delay: const Duration(milliseconds: 200),
            child: const _StatsGrid(),
          ),
        ),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  const _MobileAbout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AnimatedSection(
          visibilityKey: 'about-text-mobile',
          child: _AboutText(),
        ),
        SizedBox(height: 40),
        AnimatedSection(
          visibilityKey: 'about-stats-mobile',
          delay: Duration(milliseconds: 200),
          child: _StatsGrid(),
        ),
      ],
    );
  }
}

class _AboutText extends StatelessWidget {
  const _AboutText();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: AppStrings.aboutSubtitle,
          title: AppStrings.aboutTitle,
          alignment: CrossAxisAlignment.start,
        ),
        const SizedBox(height: 24),
        Text(
          AppStrings.aboutBio,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.8),
        ),
        const SizedBox(height: 44),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: AppStrings.highlights
              .map((h) => _HighlightChip(label: h))
              .toList(),
        ),
      ],
    );
  }
}

class _HighlightChip extends StatefulWidget {
  final String label;
  const _HighlightChip({required this.label});

  @override
  State<_HighlightChip> createState() => _HighlightChipState();
}

class _HighlightChipState extends State<_HighlightChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? [
                    AppColors.primary.withValues(alpha: 0.24),
                    AppColors.accent.withValues(alpha: 0.2),
                  ]
                : [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.accent.withValues(alpha: 0.1),
                  ],
          ),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: _hovered ? 0.6 : 0.3),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: _hovered ? FontWeight.w700 : FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatefulWidget {
  const _StatsGrid();

  @override
  State<_StatsGrid> createState() => _StatsGridState();
}

class _StatsGridState extends State<_StatsGrid> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final stats = AppStrings.stats;

    return VisibilityDetector(
      key: const Key('about-stats'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: isDesktop ? 12 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PyramidRow(
              visible: _visible,
              stats: [stats[0]],
              startIndex: 0,
              isMobile: isMobile,
            ),
            const SizedBox(height: 16),
            _PyramidRow(
              visible: _visible,
              stats: stats.sublist(1),
              startIndex: 1,
              isMobile: isMobile,
            ),
          ],
        ),
      ),
    );
  }
}

class _PyramidRow extends StatelessWidget {
  final bool visible;
  final List<Map<String, String>> stats;
  final int startIndex;
  final bool isMobile;

  const _PyramidRow({
    required this.visible,
    required this.stats,
    required this.startIndex,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = isMobile ? 12.0 : 16.0;
    final children = <Widget>[];
    for (int i = 0; i < stats.length; i++) {
      children.add(
        Expanded(
          child: _StatCard(
            visible: visible,
            value: stats[i]['value']!,
            label: stats[i]['label']!,
            delay: Duration(milliseconds: (startIndex + i) * 200),
          ),
        ),
      );
      if (i < stats.length - 1) {
        children.add(SizedBox(width: spacing));
      }
    }
    return Row(
      children: children,
    );
  }
}

class _StatCard extends StatefulWidget {
  final bool visible;
  final String value;
  final String label;
  final Duration delay;

  const _StatCard({
    required this.visible,
    required this.value,
    required this.label,
    required this.delay,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _countingStarted = false;
  AnimationController? _countController;
  Animation<double>? _countAnimation;
  int _displayNumber = 0;

  @override
  void didUpdateWidget(_StatCard old) {
    super.didUpdateWidget(old);
    if (widget.visible && !old.visible && !_countingStarted) {
      _startCounting();
    }
  }

  void _startCounting() {
    if (_countingStarted) return;
    _countingStarted = true;
    final target = _parseNumber(widget.value);
    _countController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000 + widget.delay.inMilliseconds),
    );
    _countAnimation = CurvedAnimation(
      parent: _countController!,
      curve: Curves.easeOutCubic,
    );
    _countAnimation!.addListener(() {
      if (!mounted) return;
      setState(() {
        _displayNumber = (_countAnimation!.value * target).round();
      });
    });
    Future.delayed(widget.delay, () {
      if (mounted) _countController!.forward();
    });
  }

  int _parseNumber(String raw) {
    return int.tryParse(raw.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }

  String _displayValue() {
    if (_countController != null && (_countController!.isAnimating || _countController!.value > 0)) {
      final suffix = widget.value.replaceAll(RegExp(r'[0-9]'), '');
      return '$_displayNumber$suffix';
    }
    return widget.visible ? '0' : '';
  }

  @override
  void dispose() {
    _countController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0.0, _hovered ? -4.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          gradient: LinearGradient(
            colors: isDark
                ? [AppColors.darkSurface, AppColors.darkSurface2]
                : [Colors.white, AppColors.lightSurface2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.4)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                _displayValue(),
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
