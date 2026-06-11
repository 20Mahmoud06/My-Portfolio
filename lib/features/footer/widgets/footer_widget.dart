import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/file_download.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveLayout.horizontalPadding(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.xxl,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        border: Border(
          top: BorderSide(
            color: AppColors.darkBorder,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 40,
            offset: const Offset(0, -12),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: isDesktop ? _DesktopFooter() : _MobileFooter(),
        ),
      ),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Brand + tagline
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    AppStrings.name,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.role,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
            // Social links
            Row(
              children: [
                _FooterLink(
                  label: 'GitHub',
                  url: AppStrings.github,
                  assetPath: 'assets/images/github_logo.jpg',
                ),
                const SizedBox(width: 12),
                _FooterLink(
                  label: 'LinkedIn',
                  url: AppStrings.linkedin,
                  assetPath: 'assets/images/linkedin_logo.png',
                ),
                const SizedBox(width: 12),
                _FooterLink(
                  label: 'Email',
                  url: AppStrings.emailLink,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(width: 12),
                _FooterLink(
                  label: 'Resume',
                  icon: Icons.download_rounded,
                  onTap: _downloadResume,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Divider(color: AppColors.darkBorder.withValues(alpha: 0.5)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.copyright,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.darkTextSecondary,
              ),
            ),
            Text(
              AppStrings.footerTagline,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.darkTextSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MobileFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            AppStrings.name,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.role,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.darkTextSecondary,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            _FooterLink(
              label: 'GitHub',
              url: AppStrings.github,
              assetPath: 'assets/images/github_logo.jpg',
            ),
            _FooterLink(
              label: 'LinkedIn',
              url: AppStrings.linkedin,
              assetPath: 'assets/images/linkedin_logo.png',
            ),
            _FooterLink(
              label: 'Email',
              url: AppStrings.emailLink,
              icon: Icons.email_outlined,
            ),
            _FooterLink(
              label: 'Resume',
              icon: Icons.download_rounded,
              onTap: _downloadResume,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Divider(color: AppColors.darkBorder.withValues(alpha: 0.5)),
        const SizedBox(height: 16),
        Text(
          AppStrings.copyright,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.darkTextSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.footerTagline,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.darkTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final String? url;
  final IconData? icon;
  final String? assetPath;
  final VoidCallback? onTap;
  const _FooterLink({
    required this.label,
    this.url,
    this.icon,
    this.assetPath,
    this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (widget.onTap != null) {
            widget.onTap!();
            return;
          }
          final uri = Uri.parse(widget.url!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, webOnlyWindowName: '_blank');
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.12)
                : AppColors.darkSurface.withValues(alpha: 0.5),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.45)
                  : AppColors.darkBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.assetPath != null) ...[
                ClipOval(
                  child: Image.asset(
                    widget.assetPath!,
                    width: widget.label == 'LinkedIn' ? 24 : 16,
                    height: widget.label == 'LinkedIn' ? 24 : 16,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
              ] else if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 16,
                  color: _hovered
                      ? AppColors.primary
                      : AppColors.darkTextSecondary,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? AppColors.primary
                      : AppColors.darkTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _downloadResume() {
  downloadAsset(
    AppStrings.resumePath,
    fileName: 'mahmoud_safa_resume.pdf',
  );
}

