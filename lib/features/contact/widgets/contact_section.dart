import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_dimensions.dart';
import 'package:my_portfolio/core/constants/app_strings.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/shared/widgets/animated_section.dart';
import 'package:my_portfolio/shared/widgets/section_header.dart';
import 'contact_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveLayout.horizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: Column(
            children: [
              AnimatedSection(
                visibilityKey: 'contact-header',
                child: SectionHeader(
                  label: AppStrings.contactSectionLabel,
                  title: AppStrings.contactSectionTitle,
                  subtitle: AppStrings.contactSubtitle,
                ),
              ),
              const SizedBox(height: 60),
              AnimatedSection(
                visibilityKey: 'contact-card',
                delay: const Duration(milliseconds: 200),
                child: const ContactCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
