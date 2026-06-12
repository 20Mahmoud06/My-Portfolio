import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectIconLinkButton extends StatefulWidget {
  final IconData? icon;
  final String? assetPath;
  final String url;
  final Color color;
  final String tooltip;
  const ProjectIconLinkButton({
    super.key,
    this.icon,
    this.assetPath,
    required this.url,
    required this.color,
    required this.tooltip,
  });

  @override
  State<ProjectIconLinkButton> createState() => _ProjectIconLinkButtonState();
}

class _ProjectIconLinkButtonState extends State<ProjectIconLinkButton> {
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
            width: 20,
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

Future<void> _launch(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
