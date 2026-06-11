import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/widgets/animated_section.dart';
import 'about_text.dart';
import 'about_stats_grid.dart';

class AboutDesktopLayout extends StatelessWidget {
  const AboutDesktopLayout({super.key});

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
            child: AboutText(),
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: AnimatedSection(
            visibilityKey: 'about-right',
            slideOffset: const Offset(40, 0),
            delay: const Duration(milliseconds: 200),
            child: const AboutStatsGrid(),
          ),
        ),
      ],
    );
  }
}

class AboutMobileLayout extends StatelessWidget {
  const AboutMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AnimatedSection(
          visibilityKey: 'about-text-mobile',
          child: AboutText(),
        ),
        SizedBox(height: 40),
        AnimatedSection(
          visibilityKey: 'about-stats-mobile',
          delay: Duration(milliseconds: 200),
          child: AboutStatsGrid(),
        ),
      ],
    );
  }
}
