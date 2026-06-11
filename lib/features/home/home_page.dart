import 'package:flutter/material.dart';
import '../../features/about/widgets/about_section.dart';
import '../../features/contact/widgets/contact_section.dart';
import '../../features/experience/widgets/experience_section.dart';
import '../../features/footer/widgets/footer_widget.dart';
import '../../features/hero/widgets/hero_section.dart';
import '../../features/navbar/widgets/navbar_widget.dart';
import '../../features/projects/widgets/projects_section.dart';
import '../../features/skills/widgets/skills_section.dart';
import '../../core/constants/app_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  late Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _sectionKeys = {
      for (final item in AppStrings.navItems) item: GlobalKey(),
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToProjects() =>
      _scrollToSection(_sectionKeys['Projects']!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MobileDrawer(
        sectionKeys: _sectionKeys,
        scrollController: _scrollController,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // ── Scrollable content ────────────────────────────────────────
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero (also anchors "Home")
                  SizedBox(key: _sectionKeys['Home'], height: 0),
                  HeroSection(onViewProjects: _scrollToProjects),

                  _SectionWrapper(
                    sectionKey: _sectionKeys['About']!,
                    child: const AboutSection(),
                  ),
                  _SectionWrapper(
                    sectionKey: _sectionKeys['Skills']!,
                    useAltBg: true,
                    child: const SkillsSection(),
                  ),
                  _SectionWrapper(
                    sectionKey: _sectionKeys['Projects']!,
                    child: const ProjectsSection(),
                  ),
                  _SectionWrapper(
                    sectionKey: _sectionKeys['Experience']!,
                    useAltBg: true,
                    child: const ExperienceSection(),
                  ),
                  _SectionWrapper(
                    sectionKey: _sectionKeys['Contact']!,
                    child: const ContactSection(),
                  ),
                  const FooterWidget(),
                ],
              ),
            ),

            // ── Fixed navbar overlay ──────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavbarWidget(
                scrollController: _scrollController,
                sectionKeys: _sectionKeys,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionWrapper extends StatelessWidget {
  final GlobalKey sectionKey;
  final Widget child;
  final bool useAltBg;

  const _SectionWrapper({
    required this.sectionKey,
    required this.child,
    this.useAltBg = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = useAltBg
        ? (isDark ? const Color(0xFF111827) : const Color(0xFFF0F7FF))
        : null;

    return Container(
      key: sectionKey,
      color: bg,
      child: child,
    );
  }
}
