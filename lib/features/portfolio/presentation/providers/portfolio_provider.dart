import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final portfolioProvider = Provider((ref) => PortfolioData());
final activeSectionProvider = StateProvider<int>((ref) => 0);

class PortfolioData {
  final name = "Rehman Khan";
  final role = "Flutter Developer";
  final email = "rehmankh2256@gmail.com";
  final phone = "+92 349 9856995";
  final whatsapp = "+923499856995";
  final location = "Pakistan";

  // Socials
  final githubProfile = "https://github.com/rehman3512";
  final linkedin = "https://linkedin.com/in/rehman-khan-722142354";
  final instagram = "https://instagram.com/rehmanqasuria";
  final twitter = "https://twitter.com/Rehmankhan23406";
  final fiverr = "https://www.fiverr.com/rehmankh23";

  final summary =
      "A Flutter Developer dedicated to building elegant, scalable, and user-focused applications for mobile and web platforms. By combining modern development practices, clean architecture, and efficient problem-solving, I create digital solutions that are not only visually engaging but also reliable, maintainable, and built to perform in real-world environments.";

  final education = [
    {
      "school": "Agriculture University",
      "degree": "Bachelor of Computer Science",
      "period": "Oct 2024 - Oct 2028",
      "details":
          "Relevant Coursework: Object-Oriented Programming (OOP), Data Structures & Algorithms (DSA), Database Management Systems (DBMS), Operating Systems, and Computer Networks.",
    },
  ];

  final experience = [
    {
      "role": "Flutter Developer Intern",
      "company": "Appid Core",
      "period": "Dec 2025 - Feb 2026",
      "location": "Remote",
      "details": [
        "Developed and maintained cross-platform mobile applications using Flutter and Dart.",
        "Integrated Firebase services including Authentication, Firestore, and REST APIs.",
        "Implemented state management and clean architecture for scalable and maintainable apps.",
        "Built real-world features such as user authentication, real-time data handling, and API integration.",
        "Collaborated remotely using Git and followed professional development practices.",
      ],
    },
  ];

  final projects = [
    {
      "title": "AudFam Application",
      "tech": "Flutter, Firebase, Provider",
      "desc":
          "A specialized application for audio-family interactions and management.",
      "url": "https://github.com/rehman3512/AudFam",
      "image":
          "https://images.unsplash.com/photo-1590602846989-e99596d2a6ee?q=80&w=500&auto=format&fit=crop",
    },
    {
      "title": "Real-time Chat App",
      "tech": "Flutter, Firebase Cloud Messaging",
      "desc":
          "Full-featured chat application with real-time messaging and notifications.",
      "url": "https://github.com/rehman3512/Chat-App",
      "image":
          "https://images.unsplash.com/photo-1611746872915-64382b5c76da?q=80&w=500&auto=format&fit=crop",
    },
    {
      "title": "Academy Management App",
      "tech": "Flutter, Firebase, GetX",
      "desc":
          "Developed admin and student applications for managing academic operations.",
      "url": "https://github.com/rehman3512",
      "image":
          "https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=500&auto=format&fit=crop",
    },
    {
      "title": "Responsive Portfolio",
      "tech": "Flutter, Firebase Hosting",
      "desc":
          "High-fidelity responsive portfolio website with Riverpod and custom animations.",
      "url": "https://github.com/rehman3512/rehmandev",
      "image":
          "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=500&auto=format&fit=crop",
    },
  ];

  final skills = [
    {
      "category": "Mobile & Web",
      "items": ["Flutter", "Dart", "Python"],
    },
    {
      "category": "State Management",
      "items": ["GetX", "Riverpod"],
    },
    {
      "category": "Backend",
      "items": ["REST APIs", "Firebase", "Node.js"],
    },
    {
      "category": "Local Database",
      "items": ["GetStorage", "Sqflite"],
    },
    {
      "category": "Concepts",
      "items": ["OOP", "Clean Architecture", "MVC", "Git"],
    },
  ];

  final services = [
    {
      "title": "Mobile App Development",
      "desc":
          "Building high-performance, native-like applications for Android and iOS using Flutter.",
      "icon": Icons.phone_android_rounded,
      "color": Colors.blueAccent,
    },
    {
      "title": "Web Development",
      "desc":
          "Creating responsive and blazing fast web applications with Flutter Web and Firebase.",
      "icon": Icons.web_rounded,
      "color": Colors.cyanAccent,
    },
    {
      "title": "Modern UI/UX Design",
      "desc":
          "Designing intuitive, beautiful, and user-centric interfaces with smooth micro-animations.",
      "icon": Icons.brush_rounded,
      "color": Colors.pinkAccent,
    },
    {
      "title": "Backend Integration",
      "desc":
          "Seamlessly connecting apps with Firebase, REST APIs, and Cloud functions.",
      "icon": Icons.cloud_done_rounded,
      "color": Colors.orangeAccent,
    },
  ];

  final blogPosts = [
    {
      "title": "Mastering Riverpod in 2026",
      "category": "State Management",
      "date": "May 24, 2026",
      "image":
          "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?q=80&w=500&auto=format&fit=crop",
    },
    {
      "title": "The Future of Flutter Web Architecture",
      "category": "Tech Trends",
      "date": "May 18, 2026",
      "image":
          "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=500&auto=format&fit=crop",
    },
    {
      "title": "Clean Architecture: A Pragmatic Guide",
      "category": "Development",
      "date": "May 10, 2026",
      "image":
          "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=500&auto=format&fit=crop",
    },
  ];

  final certificates = [
    "Flutter Development",
    "Diploma in Information Technology (DIT)",
  ];

  final languages = ["English", "Urdu"];

  void launchURL(String url) async {
    final Uri uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void downloadResume() async {
    const url = "https://rehman-portfolio-5beaa.web.app/resume.pdf";
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void sendEmail() async {
    final Uri params = Uri(scheme: 'mailto', path: email);
    if (!await launchUrl(params)) {
      throw Exception('Could not launch $params');
    }
  }

  void launchWhatsApp() async {
    final String url = "https://wa.me/${whatsapp.replaceAll('+', '')}";
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
