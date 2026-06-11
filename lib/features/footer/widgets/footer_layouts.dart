import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/file_download.dart';
import 'footer_link.dart';

class FooterDesktopLayout extends StatelessWidget {
  const FooterDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Row(
              children: [
                FooterLink(
                  label: 'GitHub',
                  url: AppStrings.github,
                  assetPath: 'assets/images/github_logo.jpg',
                ),
                const SizedBox(width: 12),
                FooterLink(
                  label: 'LinkedIn',
                  url: AppStrings.linkedin,
                  assetPath: 'assets/images/linkedin_logo.png',
                ),
                const SizedBox(width: 12),
                FooterLink(
                  label: 'Email',
                  url: AppStrings.emailLink,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(width: 12),
                FooterLink(
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

class FooterMobileLayout extends StatelessWidget {
  const FooterMobileLayout({super.key});

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
            FooterLink(
              label: 'GitHub',
              url: AppStrings.github,
              assetPath: 'assets/images/github_logo.jpg',
            ),
            FooterLink(
              label: 'LinkedIn',
              url: AppStrings.linkedin,
              assetPath: 'assets/images/linkedin_logo.png',
            ),
            FooterLink(
              label: 'Email',
              url: AppStrings.emailLink,
              icon: Icons.email_outlined,
            ),
            FooterLink(
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

void _downloadResume() {
  downloadAsset(
    AppStrings.resumePath,
    fileName: 'mahmoud_safa_resume.pdf',
  );
}
