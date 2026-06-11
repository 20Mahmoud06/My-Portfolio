import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/experience_model.dart';
import '../../../data/repositories/experience_repository.dart';
import '../../../shared/widgets/animated_section.dart';
import '../../../shared/widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveLayout.horizontalPadding(context);
    final entries = ExperienceRepository.getAll();

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
          child: Column(
            children: [
              AnimatedSection(
                visibilityKey: 'exp-header',
                child: const SectionHeader(
                  label: AppStrings.experienceSectionLabel,
                  title: AppStrings.experienceSectionTitle,
                ),
              ),
              const SizedBox(height: 60),
              _Timeline(entries: entries),
            ],
          ),
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<ExperienceModel> entries;
  const _Timeline({required this.entries});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      children: entries.asMap().entries.map((e) {
        final isLast = e.key == entries.length - 1;
        return AnimatedSection(
          visibilityKey: 'exp-item-${e.key}',
          delay: Duration(milliseconds: e.key * 120),
          slideOffset: const Offset(-30, 0),
          child: _TimelineItem(
            entry: e.value,
            index: e.key,
            isLast: isLast,
            isMobile: isMobile,
          ),
        );
      }).toList(),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final ExperienceModel entry;
  final int index;
  final bool isLast;
  final bool isMobile;

  const _TimelineItem({
    required this.entry,
    required this.index,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
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

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
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
                  child: Icon(_typeIcon, size: 16, color: color),
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
          const SizedBox(width: 20),
          // Content card
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 24),
                padding: const EdgeInsets.all(24),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.entry.title,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.entry.organization,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                            border:
                                Border.all(color: color.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            widget.entry.period,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (widget.entry.linkLabel != null &&
                        widget.entry.linkUrl != null)
                      RichText(
                        text: TextSpan(
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(text: '${widget.entry.description} '),
                            TextSpan(
                              text: widget.entry.linkLabel!,
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
                      )
                    else
                      Text(
                        widget.entry.description,
                        style:
                            theme.textTheme.bodyMedium?.copyWith(height: 1.6),
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
}

Future<void> _launch(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
