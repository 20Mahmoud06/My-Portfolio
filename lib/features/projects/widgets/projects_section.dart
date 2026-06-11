import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import '../../../data/repositories/projects_repository.dart';
import '../../../shared/widgets/animated_section.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../core/constants/app_strings.dart';
import 'project_featured_card.dart';
import 'projects_grid.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveLayout.horizontalPadding(context);
    final projects = ProjectsRepository.getAll();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: Column(
            children: [
              AnimatedSection(
                visibilityKey: 'projects-header',
                child: const SectionHeader(
                  label: AppStrings.projectsSectionLabel,
                  title: AppStrings.projectsSectionTitle,
                ),
              ),
              const SizedBox(height: 60),
              AnimatedSection(
                visibilityKey: 'featured-project',
                delay: const Duration(milliseconds: 200),
                child: ProjectFeaturedCard(project: projects.first),
              ),
              const SizedBox(height: 40),
              ProjectsGrid(
                projects: projects
                    .where((p) => p.id == 'kutuku' || p.id == 'flash_chat')
                    .toList(),
              ),
              const SizedBox(height: 40),
              AnimatedSection(
                visibilityKey: 'featured-muslim-project',
                delay: const Duration(milliseconds: 300),
                child: ProjectFeaturedCard(
                  project: projects.firstWhere((p) => p.id == 'muslim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
