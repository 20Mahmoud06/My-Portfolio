import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'about_pyramid_row.dart';

class AboutStatsGrid extends StatefulWidget {
  const AboutStatsGrid({super.key});

  @override
  State<AboutStatsGrid> createState() => _AboutStatsGridState();
}

class _AboutStatsGridState extends State<AboutStatsGrid> {
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
            AboutPyramidRow(
              visible: _visible,
              stats: [stats[0]],
              startIndex: 0,
              isMobile: isMobile,
            ),
            const SizedBox(height: 16),
            AboutPyramidRow(
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
