import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/shared/widgets/animated_section.dart';
import '../../../data/models/experience_model.dart';
import 'experience_timeline_item.dart';

class ExperienceTimeline extends StatelessWidget {
  final List<ExperienceModel> entries;
  const ExperienceTimeline({super.key, required this.entries});

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
          child: ExperienceTimelineItem(
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
