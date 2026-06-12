import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/data/repositories/experience_repository.dart';
import 'package:my_portfolio/shared/widgets/animated_section.dart';
import 'package:my_portfolio/shared/widgets/section_header.dart';
import 'experience_timeline.dart';

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
              SizedBox(
                width: double.infinity,
                child: ExperienceTimeline(entries: entries),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
