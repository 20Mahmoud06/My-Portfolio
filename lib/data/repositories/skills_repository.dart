import 'package:flutter/material.dart';
import '../models/skill_model.dart';
import '../../core/constants/app_colors.dart';

class SkillsRepository {
  SkillsRepository._();

  static List<SkillCategory> getCategories() => [
        SkillCategory(
          title: 'Mobile Development',
          icon: Icons.phone_android_rounded,
          color: AppColors.skillMobile,
          skills: [
            SkillModel(
              name: 'Flutter',
              icon: Icons.flutter_dash,
              category: 'Mobile',
              color: AppColors.skillMobile,
            ),
            SkillModel(
              name: 'Dart',
              icon: Icons.code_rounded,
              category: 'Mobile',
              color: AppColors.skillMobile,
            ),
            SkillModel(
              name: 'Responsive UI',
              icon: Icons.devices_rounded,
              category: 'Mobile',
              color: AppColors.skillMobile,
            ),
            SkillModel(
              name: 'BLoC & Cubit',
              icon: Icons.account_tree_rounded,
              category: 'Mobile',
              color: AppColors.skillMobile,
            ),
            SkillModel(
              name: 'Hive / SharedPrefs',
              icon: Icons.storage_rounded,
              category: 'Mobile',
              color: AppColors.skillMobile,
            ),
          ],
        ),
        SkillCategory(
          title: 'Backend & APIs',
          icon: Icons.cloud_rounded,
          color: AppColors.skillBackend,
          skills: [
            SkillModel(
              name: 'Firebase Auth',
              icon: Icons.lock_rounded,
              category: 'Backend',
              color: AppColors.skillBackend,
            ),
            SkillModel(
              name: 'Cloud Firestore',
              icon: Icons.cloud_done_rounded,
              category: 'Backend',
              color: AppColors.skillBackend,
            ),
            SkillModel(
              name: 'Cloud Messaging',
              icon: Icons.notifications_active_rounded,
              category: 'Backend',
              color: AppColors.skillBackend,
            ),
            SkillModel(
              name: 'REST APIs',
              icon: Icons.api_rounded,
              category: 'Backend',
              color: AppColors.skillBackend,
            ),
            SkillModel(
              name: 'Postman',
              icon: Icons.send_rounded,
              category: 'Backend',
              color: AppColors.skillBackend,
            ),
          ],
        ),
        SkillCategory(
          title: 'Programming',
          icon: Icons.terminal_rounded,
          color: AppColors.skillProgramming,
          skills: [
            SkillModel(
              name: 'OOP',
              icon: Icons.hub_rounded,
              category: 'Programming',
              color: AppColors.skillProgramming,
            ),
            SkillModel(
              name: 'SOLID Principles',
              icon: Icons.architecture_rounded,
              category: 'Programming',
              color: AppColors.skillProgramming,
            ),
            SkillModel(
              name: 'Data Structures',
              icon: Icons.data_array_rounded,
              category: 'Programming',
              color: AppColors.skillProgramming,
            ),
            SkillModel(
              name: 'Algorithms',
              icon: Icons.schema_rounded,
              category: 'Programming',
              color: AppColors.skillProgramming,
            ),
            SkillModel(
              name: 'Design Patterns',
              icon: Icons.pattern_rounded,
              category: 'Programming',
              color: AppColors.skillProgramming,
            ),
            SkillModel(
              name: 'C++ / Java / Python',
              icon: Icons.memory_rounded,
              category: 'Programming',
              color: AppColors.skillProgramming,
            ),
          ],
        ),
        SkillCategory(
          title: 'Tools & Workflow',
          icon: Icons.build_rounded,
          color: AppColors.skillTools,
          skills: [
            SkillModel(
              name: 'Git & GitHub',
              icon: Icons.merge_type_rounded,
              category: 'Tools',
              color: AppColors.skillTools,
            ),
            SkillModel(
              name: 'VS Code',
              icon: Icons.code_rounded,
              category: 'Tools',
              color: AppColors.skillTools,
            ),
            SkillModel(
              name: 'Android Studio',
              icon: Icons.android_rounded,
              category: 'Tools',
              color: AppColors.skillTools,
            ),
            SkillModel(
              name: 'Figma',
              icon: Icons.design_services_rounded,
              category: 'Tools',
              color: AppColors.skillTools,
            ),
            SkillModel(
              name: 'Clean Architecture',
              icon: Icons.layers_rounded,
              category: 'Tools',
              color: AppColors.skillTools,
            ),
          ],
        ),
      ];
}
