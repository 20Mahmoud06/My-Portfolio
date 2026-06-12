import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/experience_model.dart';

class ExperienceTimelineItem extends StatefulWidget {
  final ExperienceModel entry;
  final int index;
  final bool isLast;
  final bool isMobile;

  const ExperienceTimelineItem({
    super.key,
    required this.entry,
    required this.index,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<ExperienceTimelineItem> createState() => _ExperienceTimelineItemState();
}

class _ExperienceTimelineItemState extends State<ExperienceTimelineItem> {
  bool _hovered = false;

  Color get _dotColor {
    switch (widget.entry.type) {
      case 'education':
        return AppColors.accent;
      case 'achievement':
        return AppColors.accentAlt;
      default:
        return AppColors.primary;
    }
  }

  IconData get _typeIcon {
    switch (widget.entry.type) {
      case 'education':
        return Icons.school_rounded;
      case 'achievement':
        return Icons.emoji_events_rounded;
      default:
        return Icons.work_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = _dotColor;
    final isMobile = widget.isMobile;

    // Responsive metrics: tighter on mobile to free up room for the text.
    final railWidth = isMobile ? 30.0 : 40.0;
    final dotSize = isMobile ? 28.0 : 36.0;
    final railGap = isMobile ? 14.0 : 20.0;
    final cardPadding = isMobile ? 18.0 : 24.0;
    final cardSpacing = isMobile ? 20.0 : 24.0;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: railWidth,
            child: Column(
              children: [
                Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.15),
                    border: Border.all(color: color, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(_typeIcon, size: dotSize * 0.45, color: color),
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color.withValues(alpha: 0.5), Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: railGap),
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: widget.isLast ? 0 : cardSpacing),
                padding: EdgeInsets.all(cardPadding),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLg),
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  border: Border.all(
                    color: _hovered
                        ? color.withValues(alpha: 0.4)
                        : (isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _hovered
                          ? color.withValues(alpha: 0.12)
                          : Colors.black.withValues(alpha: isDark ? 0.15 : 0.04),
                      blurRadius: _hovered ? 16 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isDark, color, isMobile),
                    const SizedBox(height: 12),
                    if (widget.entry.linkLabel != null &&
                        widget.entry.linkUrl != null)
                      Text.rich(
                        TextSpan(
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(text: '${widget.entry.description} '),
                            TextSpan(
                              text: widget.entry.linkLabel!.replaceAll(
                                  '_', '_\u{200B}'),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: color,
                                decoration: TextDecoration.underline,
                                decorationColor: color,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launch(widget.entry.linkUrl!),
                            ),
                          ],
                        ),
                        softWrap: true,
                      )
                    else
                      Text(
                        widget.entry.description,
                        style:
                            theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color color, bool isMobile) {
    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.entry.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 15 : 16,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.entry.organization,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleFonts.inter(
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );

    final periodBadge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        widget.entry.period,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );

    // On mobile, stack the date badge above the title so the title and
    // organization get the full card width and never break mid-word.
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          periodBadge,
          const SizedBox(height: 10),
          titleBlock,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: titleBlock),
        const SizedBox(width: 12),
        periodBadge,
      ],
    );
  }
}


Future<void> _launch(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
