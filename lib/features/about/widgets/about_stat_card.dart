import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';

class AboutStatCard extends StatefulWidget {
  final bool visible;
  final String value;
  final String label;
  final Duration delay;

  const AboutStatCard({
    super.key,
    required this.visible,
    required this.value,
    required this.label,
    required this.delay,
  });

  @override
  State<AboutStatCard> createState() => _AboutStatCardState();
}

class _AboutStatCardState extends State<AboutStatCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _countingStarted = false;
  AnimationController? _countController;
  Animation<double>? _countAnimation;
  int _displayNumber = 0;

  @override
  void didUpdateWidget(AboutStatCard old) {
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
    if (_countController != null &&
        (_countController!.isAnimating || _countController!.value > 0)) {
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
