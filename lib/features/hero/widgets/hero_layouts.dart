import 'package:flutter/material.dart';
import 'hero_profile_image.dart';
import 'hero_text.dart';

class HeroDesktopLayout extends StatelessWidget {
  final AnimationController glowController;
  final VoidCallback onViewProjects;
  final Future<void> Function(String) onLaunch;
  final double titleSize;
  final double roleSize;
  final Offset mouseOffset;

  const HeroDesktopLayout({
    super.key,
    required this.glowController,
    required this.onViewProjects,
    required this.onLaunch,
    required this.titleSize,
    required this.roleSize,
    required this.mouseOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: HeroText(
              onViewProjects: onViewProjects,
              onLaunch: onLaunch,
              titleSize: titleSize,
              roleSize: roleSize,
            ),
          ),
        ),
        const SizedBox(width: 60),
        HeroProfileImage(glowController: glowController, mouseOffset: mouseOffset),
      ],
    );
  }
}

class HeroMobileLayout extends StatelessWidget {
  final AnimationController glowController;
  final VoidCallback onViewProjects;
  final Future<void> Function(String) onLaunch;
  final double imageSize;
  final double titleSize;
  final double roleSize;
  final Offset mouseOffset;

  const HeroMobileLayout({
    super.key,
    required this.glowController,
    required this.onViewProjects,
    required this.onLaunch,
    required this.imageSize,
    required this.titleSize,
    required this.roleSize,
    required this.mouseOffset,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          HeroProfileImage(glowController: glowController, size: imageSize, mouseOffset: mouseOffset),
          const SizedBox(height: 32),
          HeroText(
            onViewProjects: onViewProjects,
            onLaunch: onLaunch,
            centerAlign: true,
            titleSize: titleSize,
            roleSize: roleSize,
          ),
        ],
      ),
    );
  }
}
