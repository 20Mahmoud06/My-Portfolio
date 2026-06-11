import 'package:flutter/material.dart';
import 'about_stat_card.dart';

class AboutPyramidRow extends StatelessWidget {
  final bool visible;
  final List<Map<String, String>> stats;
  final int startIndex;
  final bool isMobile;

  const AboutPyramidRow({
    super.key,
    required this.visible,
    required this.stats,
    required this.startIndex,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = isMobile ? 12.0 : 16.0;
    final children = <Widget>[];
    for (int i = 0; i < stats.length; i++) {
      children.add(
        Expanded(
          child: AboutStatCard(
            visible: visible,
            value: stats[i]['value']!,
            label: stats[i]['label']!,
            delay: Duration(milliseconds: (startIndex + i) * 200),
          ),
        ),
      );
      if (i < stats.length - 1) {
        children.add(SizedBox(width: spacing));
      }
    }
    return Row(
      children: children,
    );
  }
}
