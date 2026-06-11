import '../models/experience_model.dart';

class ExperienceRepository {
  ExperienceRepository._();

  static List<ExperienceModel> getAll() => [
        ExperienceModel(
          title: 'Head Vice — Mobile Developer Track',
          organization: 'GDG SCU (Google Developer Groups)',
          period: 'Dec 2025 – Present',
          description:
              'Leading the mobile development track, helping students understand '
              'Flutter fundamentals and guiding them through building real-world apps.',
          type: 'work',
        ),
        ExperienceModel(
          title: 'Flutter Trainee',
          organization: 'Octals SCU Flutter Team',
          period: 'Oct 2025 – Mar 2026',
          description:
              'Contributed to Flutter app features within a collaborative team '
              'environment, practicing agile workflows and code reviews.',
          type: 'work',
        ),
        ExperienceModel(
          title: 'Mentor — Competitive Programming',
          organization: 'ICPC SCU Community',
          period: 'Oct 2025 – Present',
          description:
              'Setting problems for beginners and participating in competitive '
              'programming training sessions. Codeforces handle:',
          linkLabel: 'Mahmoud_Sameh',
          linkUrl: 'https://codeforces.com/profile/Mahmoud_Sameh',
          type: 'achievement',
        ),
        ExperienceModel(
          title: 'Flutter Trainee',
          organization: 'Microsoft Student Club SCU Flutter Team',
          period: 'Feb 2025 – Jul 2025',
          description:
              'Learned Flutter fundamentals through practical sessions and '
              'collaborative team work, building multiple mini-projects.',
          type: 'work',
        ),
        ExperienceModel(
          title: 'Trainee — Problem Solving',
          organization: 'ICPC SCU Community',
          period: 'Oct 2024 – Present',
          description:
              'Covered core problem-solving techniques: Frequency Array, Prefix Sum, '
              'Two Pointers, and Binary Search. Active competitive programmer.',
          type: 'work',
        ),
      ];
}
