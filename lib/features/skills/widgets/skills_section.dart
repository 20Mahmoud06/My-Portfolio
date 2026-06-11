import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/data/repositories/skills_repository.dart';
import 'package:my_portfolio/shared/widgets/animated_section.dart';
import 'package:my_portfolio/shared/widgets/section_header.dart';
import 'skills_grid.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveLayout.horizontalPadding(context);
    final categories = SkillsRepository.getCategories();

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
              const AnimatedSection(
                visibilityKey: 'skills-header',
                child: SectionHeader(
                  label: AppStrings.skillsSectionLabel,
                  title: AppStrings.skillsSectionTitle,
                ),
              ),
              const SizedBox(height: 60),
              AnimatedSection(
                visibilityKey: 'skills-grid',
                delay: const Duration(milliseconds: 200),
                child: SkillsGrid(categories: categories),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
