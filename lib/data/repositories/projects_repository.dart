import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectsRepository {
  ProjectsRepository._();

  static List<ProjectModel> getAll() => [
    ProjectModel(
      id: 'aura',
      title: 'AURA',
      shortDescription:
          'A high-end application demonstrating complex UI patterns and animations.',
      fullDescription:
          'AURA is a feature-rich Flutter media player with music & video '
          'playback, Picture-in-Picture (PiP), background audio, playlist '
          'management, media search, gesture controls, and a modern '
          'Liquid Glass inspired interface.',
      imagePath: 'assets/images/aura_screenshot.png',
      technologies: ['Flutter', 'Dart', 'Media Playback'],
      githubUrl: 'https://github.com/20Mahmoud06/AURA',
      apkUrl:
          'https://drive.google.com/file/d/1MdaSHLsFjhYbhw8qAy9VFlEpxClUdUa3/view?usp=drive_link',
      isFeatured: true,
      accentColor: const Color(0xFF42A5F5),
    ),

    ProjectModel(
      id: 'kutuku',
      title: 'Kutuku',
      shortDescription:
          'Modern e-commerce application with a polished shopping experience.',
      fullDescription:
          'Kutuku is a modern e-commerce application built with Flutter, '
          'focused on delivering exceptional mobile shopping experiences '
          'through performant code, smooth UI interactions, and clean app structure.',
      imagePath: 'assets/images/kutuku_screenshot.jpg',
      technologies: ['Flutter', 'Provider', 'Clean UI'],
      githubUrl: 'https://github.com/20Mahmoud06/Kutuku',
      apkUrl:
          'https://drive.google.com/file/d/1MOi8CstKi6prsiX6sMRQ3YIDxYc6hwPd/view?usp=drive_link',
      isFeatured: true,
      accentColor: const Color(0xFF34D399),
    ),
    
    ProjectModel(
      id: 'flash_chat',
      title: 'Flash Chat',
      shortDescription:
          'Real-time messaging application with secure authentication and rich animations.',
      fullDescription:
          'Flash Chat is a modern Flutter chat app with Firebase real-time '
          'messaging, secure authentication, smart contact sync, push '
          'notifications, media & voice-note sharing, and voice & video calls.',
      imagePath: 'assets/images/flashchat_screenshot.jpg',
      technologies: ['Flutter', 'Firebase', 'Push Notifications'],
      githubUrl: 'https://github.com/20Mahmoud06/Flash-Chat',
      apkUrl:
          'https://drive.google.com/file/d/1JDGU0CLXgxVvMGc6h5x6wJVsq6_XCK9K/view?usp=drive_link',
      isFeatured: true,
      accentColor: const Color(0xFF818CF8),
    ),
    ProjectModel(
      id: 'muslim',
      title: 'Muslim App',
      shortDescription:
          'A comprehensive Islamic application featuring prayer times, Quran, Hadith & more.',
      fullDescription:
          'Muslim App is a complete Flutter Islamic app featuring Prayer '
          'Times, Qibla Compass, Quran reading, Hadith collection, '
          'Morning & Evening Azkar, 99 Names of Allah, Hijri Calendar, '
          'Notifications, and a Digital Tasbih counter.',
      imagePath: 'assets/images/muslim_screenshot.jpg',
      technologies: ['Flutter', 'Dart', 'Local Features'],
      githubUrl: 'https://github.com/20Mahmoud06/muslim',
      apkUrl:
          'https://drive.google.com/file/d/1tMFDtmO15ZbDQzcm7BGgS1NRidNC5wqI/view?usp=drive_link',
      isFeatured: true,
      accentColor: const Color(0xFF22D3EE),
    ),
  ];

  static List<ProjectModel> getFeatured() =>
      getAll().where((p) => p.isFeatured).toList();
}
