import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/shared/widgets/glow_button.dart';
import '../../../data/models/project_model.dart';
import 'project_helpers.dart';
import 'project_tech_chip.dart';

class ProjectFeaturedCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectFeaturedCard({super.key, required this.project});

  @override
  State<ProjectFeaturedCard> createState() => _ProjectFeaturedCardState();
}

class _ProjectFeaturedCardState extends State<ProjectFeaturedCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0.0, _hovered ? -4.0 : 0.0, 0.0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
          color: isDark ? AppColors.darkSurface : Colors.white,
          border: Border.all(
            color: _hovered
                ? p.accentColor.withValues(alpha: 0.5)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? p.accentColor.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: _hovered ? 40 : 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isMobile
            ? _ProjectFeaturedMobile(project: p)
            : _ProjectFeaturedDesktop(project: p, hovered: _hovered),
      ),
    );
  }
}

class _ProjectFeaturedDesktop extends StatelessWidget {
  final ProjectModel project;
  final bool hovered;
  const _ProjectFeaturedDesktop({required this.project, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radiusXl),
              bottomLeft: Radius.circular(AppDimensions.radiusXl),
            ),
            child: AnimatedScale(
              scale: 1.0,
              duration: const Duration(milliseconds: 300),
              child: ColoredBox(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkSurface2
                    : AppColors.lightSurface2,
                child: Image.asset(
                  project.imagePath,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  height: 380,
                  width: double.infinity,
                  errorBuilder: projectImageError,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: _ProjectDetails(project: project),
          ),
        ),
      ],
    );
  }
}

class _ProjectFeaturedMobile extends StatelessWidget {
  final ProjectModel project;
  const _ProjectFeaturedMobile({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXl),
            topRight: Radius.circular(AppDimensions.radiusXl),
          ),
          child: ColoredBox(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkSurface2
                : AppColors.lightSurface2,
            child: Image.asset(
              project.imagePath,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: double.infinity,
              height: 220,
              errorBuilder: projectImageError,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: _ProjectDetails(project: project),
        ),
      ],
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  final ProjectModel project;
  const _ProjectDetails({required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final p = project;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                p.accentColor.withValues(alpha: 0.2),
                p.accentColor.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: p.accentColor.withValues(alpha: 0.4)),
          ),
          child: Text(
            '⭐ Featured Project',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: p.accentColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          p.title,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          p.fullDescription,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: p.technologies
              .map((t) => ProjectTechChip(label: t, color: p.accentColor))
              .toList(),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            GlowButton(
              label: 'GitHub',
              assetIcon: 'assets/images/github_logo.jpg',
              onPressed: () => launchProjectUrl(p.githubUrl),
              color: p.accentColor,
            ),
            GlowButton(
              label: 'Download APK',
              icon: Icons.download_rounded,
              outlined: true,
              onPressed: () => launchProjectUrl(p.apkUrl),
              color: p.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}
