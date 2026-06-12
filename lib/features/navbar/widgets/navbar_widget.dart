import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/file_download.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/shared/widgets/glow_button.dart';
import 'navbar_item.dart';
import 'navbar_theme_toggle.dart';

class NavbarWidget extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const NavbarWidget({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  bool _scrolled = false;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled = widget.scrollController.offset > 20;
    if (_scrolled != isScrolled) setState(() => _scrolled = isScrolled);

    final keys = widget.sectionKeys.values.toList();
    for (int i = keys.length - 1; i >= 0; i--) {
      final ctx = keys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= AppDimensions.navbarHeight + 40) {
        if (_activeIndex != i) setState(() => _activeIndex = i);
        break;
      }
    }
  }

  void _scrollToSection(int index) {
    final keys = widget.sectionKeys.values.toList();
    if (index >= keys.length) return;
    final ctx = keys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final hPad = ResponsiveLayout.horizontalPadding(context);
    final topPad = MediaQuery.of(context).padding.top;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(top: topPad),
      height: topPad + (isDesktop
          ? AppDimensions.navbarHeight
          : AppDimensions.navbarHeightMobile),
      decoration: BoxDecoration(
        color: _scrolled
            ? (isDark
                ? AppColors.darkBackground.withValues(alpha: 0.85)
                : Colors.white.withValues(alpha: 0.85))
            : Colors.transparent,
        border: _scrolled
            ? Border(
                bottom: BorderSide(
                  color: isDark
                      ? AppColors.darkBorder.withValues(alpha: 0.5)
                      : AppColors.lightBorder,
                  width: 1,
                ),
              )
            : null,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: _scrolled
              ? ImageFilter.blur(sigmaX: 20, sigmaY: 20)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Row(
              children: [
                Flexible(
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: Text(
                      AppStrings.name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: isDesktop ? 18 : 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                if (isDesktop)
                  ...AppStrings.navItems.asMap().entries.map((e) {
                    return NavbarItem(
                      label: e.value,
                      isActive: _activeIndex == e.key,
                      onTap: () => _scrollToSection(e.key),
                    );
                  }),
                if (isDesktop) const SizedBox(width: 16),
                const NavbarThemeToggle(),
                const SizedBox(width: 12),
                if (isDesktop)
                  GlowButton(
                    label: 'Resume',
                    icon: Icons.download_rounded,
                    height: 40,
                    onPressed: _downloadResume,
                  ),
                if (!isDesktop)
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                      onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                    ),
                  ),
              ],
            ),
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
