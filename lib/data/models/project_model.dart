import 'package:flutter/material.dart';

class ProjectModel {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final String imagePath;
  final List<String> technologies;
  final String githubUrl;
  final String apkUrl;
  final String? demoUrl;
  final bool isFeatured;
  final Color accentColor;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.imagePath,
    required this.technologies,
    required this.githubUrl,
    required this.apkUrl,
    this.demoUrl,
    this.isFeatured = false,
    required this.accentColor,
  });
}
