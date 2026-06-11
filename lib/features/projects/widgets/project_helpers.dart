import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

Widget projectImageError(BuildContext context, Object error, StackTrace? stack) {
  return Container(
    color: AppColors.darkSurface2,
    child: const Center(
      child: Icon(Icons.image_rounded, size: 48, color: AppColors.darkBorder),
    ),
  );
}

Future<void> launchProjectUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
