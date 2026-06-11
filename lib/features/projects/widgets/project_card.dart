import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import '../../../data/models/project_model.dart';
import 'project_helpers.dart';
import 'project_icon_link_button.dart';
import 'project_tech_chip.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0.0, _hovered ? -8.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
          color: isDark ? AppColors.darkSurface : Colors.white,
          border: Border.all(
            color: _hovered
                ? p.accentColor.withValues(alpha: 0.5)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? p.accentColor.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
              blurRadius: _hovered ? 30 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.radiusXl),
                  topRight: Radius.circular(AppDimensions.radiusXl),
                ),
                child: ColoredBox(
                  color: isDark
                      ? AppColors.darkSurface2
                      : AppColors.lightSurface2,
                  child: AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Image.asset(
                      p.imagePath,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      width: double.infinity,
                      errorBuilder: projectImageError,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.title,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                      ),
                      ProjectIconLinkButton(
                        assetPath: 'assets/images/github_logo.jpg',
                        url: p.githubUrl,
                        color: p.accentColor,
                        tooltip: 'GitHub',
                      ),
                      const SizedBox(width: 8),
                      ProjectIconLinkButton(
                        icon: Icons.download_rounded,
                        url: p.apkUrl,
                        color: p.accentColor,
                        tooltip: 'Download APK',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.shortDescription,
                    style: theme.textTheme.bodySmall?.copyWith(height: 1.6),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: p.technologies
                        .take(3)
                        .map((t) => ProjectTechChip(label: t, color: p.accentColor))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
