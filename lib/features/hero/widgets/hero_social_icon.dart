import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSocialIcon extends StatefulWidget {
  final IconData? icon;
  final String? assetPath;
  final String label;
  final String url;

  const HeroSocialIcon({
    super.key,
    this.icon,
    this.assetPath,
    required this.label,
    required this.url,
  });

  @override
  State<HeroSocialIcon> createState() => _HeroSocialIconState();
}

class _HeroSocialIconState extends State<HeroSocialIcon> {
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
