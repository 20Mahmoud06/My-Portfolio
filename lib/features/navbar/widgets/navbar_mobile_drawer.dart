import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/file_download.dart';
import 'package:my_portfolio/shared/widgets/glow_button.dart';

class NavbarMobileDrawer extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const NavbarMobileDrawer({
    super.key,
    required this.sectionKeys,
    required this.scrollController,
  });

  void _scrollToSection(BuildContext context, int index) {
    Navigator.pop(context);
    final keys = sectionKeys.values.toList();
    if (index >= keys.length) return;
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!context.mounted) return;
      final ctx = keys[index].currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ShaderMask(
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
            ),
            const Divider(),
            ...AppStrings.navItems.asMap().entries.map((e) {
              return ListTile(
                title: Text(
                  e.value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                onTap: () => _scrollToSection(context, e.key),
              );
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: GlowButton(
                label: 'Resume',
                icon: Icons.download_rounded,
                width: double.infinity,
                onPressed: () {
                  Navigator.pop(context);
                  _downloadResume();
                },
              ),
            ),
          ],
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
