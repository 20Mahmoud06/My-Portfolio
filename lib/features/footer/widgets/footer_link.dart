import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterLink extends StatefulWidget {
  final String label;
  final String? url;
  final IconData? icon;
  final String? assetPath;
  final VoidCallback? onTap;
  const FooterLink({
    super.key,
    required this.label,
    this.url,
    this.icon,
    this.assetPath,
    this.onTap,
  });

  @override
  State<FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (widget.onTap != null) {
            widget.onTap!();
            return;
          }
          final uri = Uri.parse(widget.url!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, webOnlyWindowName: '_blank');
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.12)
                : AppColors.darkSurface.withValues(alpha: 0.5),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.45)
                  : AppColors.darkBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.assetPath != null) ...[
                ClipOval(
                  child: Image.asset(
                    widget.assetPath!,
                    width: widget.label == 'LinkedIn' ? 24 : 16,
                    height: widget.label == 'LinkedIn' ? 24 : 16,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
              ] else if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 16,
                  color: _hovered
                      ? AppColors.primary
                      : AppColors.darkTextSecondary,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? AppColors.primary
                      : AppColors.darkTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
