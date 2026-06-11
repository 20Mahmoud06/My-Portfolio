import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final IconData icon;
  final String category;
  final Color color;

  const SkillModel({
    required this.name,
    required this.icon,
    required this.category,
    required this.color,
  });
}

class SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<SkillModel> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
  });
}
