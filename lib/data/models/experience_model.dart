class ExperienceModel {
  final String title;
  final String organization;
  final String period;
  final String description;
  final String? linkLabel;
  final String? linkUrl;
  final String? type; // 'work', 'education', 'achievement'

  const ExperienceModel({
    required this.title,
    required this.organization,
    required this.period,
    required this.description,
    this.linkLabel,
    this.linkUrl,
    this.type,
  });
}
