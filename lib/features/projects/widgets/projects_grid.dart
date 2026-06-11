import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import '../../../data/models/project_model.dart';
import '../../../shared/widgets/animated_section.dart';
import 'project_card.dart';

class ProjectsGrid extends StatelessWidget {
  final List<ProjectModel> projects;
  const ProjectsGrid({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final cols = isMobile ? 1 : 2;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final mobileExtent = isMobile
        ? (screenWidth < 360 ? 520.0 : screenWidth < 400 ? 480.0 : 460.0)
        : 460.0;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: isMobile ? 0 : 24,
        mainAxisSpacing: 24,
        mainAxisExtent: mobileExtent,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return AnimatedSection(
          visibilityKey: 'project-card-$index',
          delay: Duration(milliseconds: index * 150),
          child: ProjectCard(project: projects[index]),
        );
      },
    );
  }
}
