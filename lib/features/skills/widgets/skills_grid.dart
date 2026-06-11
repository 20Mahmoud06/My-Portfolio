import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/data/models/skill_model.dart';
import 'skills_category_card.dart';

class SkillsGrid extends StatelessWidget {
  final List<SkillCategory> categories;
  const SkillsGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: isMobile ? 16 : 24,
        mainAxisSpacing: isMobile ? 16 : 24,
        mainAxisExtent: isMobile ? 260 : (isTablet ? 300 : 280),
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return SkillsCategoryCard(
          category: categories[index],
          delay: Duration(milliseconds: index * 100),
        );
      },
    );
  }
}
