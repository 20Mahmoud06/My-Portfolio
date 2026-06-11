import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/shared/widgets/section_header.dart';
import 'about_highlight_chip.dart';

class AboutText extends StatelessWidget {
  const AboutText({super.key});

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
              .map((h) => AboutHighlightChip(label: h))
              .toList(),
        ),
      ],
    );
  }
}
