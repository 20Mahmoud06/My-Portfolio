import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatefulWidget {
  final IconData? icon;
  final String? assetPath;
  final double assetSize;
  final String label;
  final String url;
  final Color color;

  const ContactRow({
    super.key,
    this.icon,
    this.assetPath,
    this.assetSize = 22,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<ContactRow> {
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
