import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/project_model.dart';
import '../../../data/repositories/projects_repository.dart';
import '../../../shared/widgets/animated_section.dart';
import '../../../shared/widgets/glow_button.dart';
import '../../../shared/widgets/section_header.dart';

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

              // Featured project (AURA)
              AnimatedSection(
                visibilityKey: 'featured-project',
                delay: const Duration(milliseconds: 200),
                child: _FeaturedProjectCard(project: projects.first),
              ),
              const SizedBox(height: 40),

              _ProjectsGrid(
                projects: projects
                    .where((p) => p.id == 'kutuku' || p.id == 'flash_chat')
                    .toList(),
              ),
              const SizedBox(height: 40),

              AnimatedSection(
                visibilityKey: 'featured-muslim-project',
                delay: const Duration(milliseconds: 300),
                child: _FeaturedProjectCard(
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

// ── Featured Project Card ────────────────────────────────────────────────────
class _FeaturedProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _FeaturedProjectCard({required this.project});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
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
            ? _FeaturedMobile(project: p)
            : _FeaturedDesktop(project: p, hovered: _hovered),
      ),
    );
  }
}

class _FeaturedDesktop extends StatelessWidget {
  final ProjectModel project;
  final bool hovered;
  const _FeaturedDesktop({required this.project, required this.hovered});

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
                  errorBuilder: _imageError,
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

class _FeaturedMobile extends StatelessWidget {
  final ProjectModel project;
  const _FeaturedMobile({required this.project});

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
              errorBuilder: _imageError,
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
        // Featured badge
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
              .map((t) => _TechChip(label: t, color: p.accentColor))
              .toList(),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            GlowButton(
              label: 'GitHub',
              assetIcon: 'assets/images/github_logo.jpg',
              onPressed: () => _launch(p.githubUrl),
              color: p.accentColor,
            ),
            const SizedBox(width: 12),
            GlowButton(
              label: 'Download APK',
              icon: Icons.download_rounded,
              outlined: true,
              onPressed: () => _launch(p.apkUrl),
              color: p.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}

// ── Projects Grid ────────────────────────────────────────────────────────────
class _ProjectsGrid extends StatelessWidget {
  final List<ProjectModel> projects;
  const _ProjectsGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final cols = isMobile ? 1 : 2;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final mobileExtent = screenWidth < 400 ? 400.0 : 420.0;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        mainAxisExtent: isMobile ? mobileExtent : 460,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return AnimatedSection(
          visibilityKey: 'project-card-$index',
          delay: Duration(milliseconds: index * 150),
          child: _ProjectCard(project: projects[index]),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
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
            // Screenshot
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
                      errorBuilder: _imageError,
                    ),
                  ),
                ),
              ),
            ),
            // Content
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
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                      ),
                      // GitHub icon button
                      _IconLinkButton(
                        assetPath: 'assets/images/github_logo.jpg',
                        url: p.githubUrl,
                        color: p.accentColor,
                        tooltip: 'GitHub',
                      ),
                      const SizedBox(width: 8),
                      _IconLinkButton(
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
                        .map((t) => _TechChip(label: t, color: p.accentColor))
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

class _TechChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TechChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _IconLinkButton extends StatefulWidget {
  final IconData? icon;
  final String? assetPath;
  final String url;
  final Color color;
  final String tooltip;
  const _IconLinkButton({
    this.icon,
    this.assetPath,
    required this.url,
    required this.color,
    required this.tooltip,
  });

  @override
  State<_IconLinkButton> createState() => _IconLinkButtonState();
}

class _IconLinkButtonState extends State<_IconLinkButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launch(widget.url),
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 30,
            height: 30,
            padding: EdgeInsets.all(widget.assetPath == null ? 6 : 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered
                  ? widget.color.withValues(alpha: 0.15)
                  : Colors.transparent,
            ),
            child: widget.assetPath == null
                ? Icon(
                    widget.icon,
                    size: 18,
                    color: _hovered
                        ? widget.color
                        : AppColors.darkTextSecondary,
                  )
                : ClipOval(
                    child: Image.asset(widget.assetPath!, fit: BoxFit.cover),
                  ),
          ),
        ),
      ),
    );
  }
}

Widget _imageError(BuildContext context, Object error, StackTrace? stack) {
  return Container(
    color: AppColors.darkSurface2,
    child: const Center(
      child: Icon(Icons.image_rounded, size: 48, color: AppColors.darkBorder),
    ),
  );
}

Future<void> _launch(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
