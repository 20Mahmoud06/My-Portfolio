import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/theme/theme_provider.dart';
import 'package:my_portfolio/core/utils/file_download.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/shared/widgets/glow_button.dart';
import 'package:provider/provider.dart';

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
                // Logo
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    AppStrings.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                if (isDesktop)
                  ...AppStrings.navItems.asMap().entries.map((e) {
                    return _NavItem(
                      label: e.value,
                      isActive: _activeIndex == e.key,
                      onTap: () => _scrollToSection(e.key),
                    );
                  }),
                if (isDesktop) const SizedBox(width: 16),
                _ThemeToggle(),
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

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = (widget.isActive || _hovered)
        ? AppColors.primary
        : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight:
                      widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: textColor,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface2,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDark),
            size: 20,
            color: isDark ? AppColors.accent : AppColors.primary,
          ),
        ),
        onPressed: themeProvider.toggleTheme,
        tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      ),
    );
  }
}

// ── Mobile Drawer ────────────────────────────────────────────────────────────
class MobileDrawer extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const MobileDrawer({
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

