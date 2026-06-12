import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final IconData? icon;
  final String? assetIcon;
  final Color? color;
  final double? width;
  final double height;

  const GlowButton({
    super.key,
    required this.label,
    this.onPressed,
    this.outlined = false,
    this.icon,
    this.assetIcon,
    this.color,
    this.width,
    this.height = 50,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          clipBehavior: Clip.antiAlias,
          decoration: widget.outlined
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: effectiveColor, width: 1.5),
                  color: _hovered
                      ? effectiveColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: effectiveColor.withValues(alpha: 0.2),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      effectiveColor,
                      Color.lerp(effectiveColor, AppColors.accent, 0.5)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: effectiveColor.withValues(alpha: 0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: effectiveColor.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null || widget.assetIcon != null) ...[
                widget.assetIcon == null
                    ? Icon(
                        widget.icon,
                        size: 18,
                        color: widget.outlined ? effectiveColor : Colors.white,
                      )
                    : ClipOval(
                        child: Image.asset(
                          widget.assetIcon!,
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.outlined ? effectiveColor : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
