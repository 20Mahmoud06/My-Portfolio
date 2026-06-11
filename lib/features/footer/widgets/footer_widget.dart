import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'footer_layouts.dart';

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
          child: isDesktop ? const FooterDesktopLayout() : const FooterMobileLayout(),
        ),
      ),
    );
  }
}
