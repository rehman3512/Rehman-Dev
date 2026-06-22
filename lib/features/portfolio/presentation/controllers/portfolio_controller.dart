import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioController extends GetxController {
  final name = "Rehman Khan".obs;
  final role = "Flutter Developer".obs;
  final email = "rehmankhan2256@gmail.com".obs;
  final phone = "+92 317 9775382".obs;
  final location =
      "Peshawar, Pakistan".obs; // Extrapolated from University info

  final projects = [
    {
      "title": "Academy Management App",
      "tech": "Flutter, Firebase, GetX",
      "desc":
          "Developed admin and student applications for managing academic operations including subjects, enrollment, fees, and payments.",
    },
    {
      "title": "Responsive Portfolio Website",
      "tech": "Flutter, Firestore, Firebase Hosting",
      "desc":
          "Created and deployed a Flutter-based portfolio website integrated with Firestore and hosted on Firebase.",
    },
    {
      "title": "Task Management App",
      "tech": "Flutter, Cloud Firestore",
      "desc":
          "Designed a ToDo application with real-time synchronization using Cloud Firestore.",
    },
    {
      "title": "E-Commerce Groceries App",
      "tech": "Flutter, Firebase Auth, Firestore",
      "desc":
          "Developed an online grocery platform with user authentication, email verification, and Firestore backend.",
    },
  ].obs;

  final skills = [
    "Flutter",
    "Dart",
    "Firebase",
    "REST APIs",
    "GetX",
    "Clean Architecture",
    "Git",
    "Postman",
    "Google Maps SDK",
    "GetStorage",
  ].obs;

  final education = {
    "university": "Agriculture University",
    "degree": "Bachelor of Computer Science",
    "duration": "Oct 2024 - Oct 2028",
  }.obs;

  final experience = {
    "role": "Flutter Developer Intern",
    "company": "Appidcon",
    "duration": "Dec 2025 - Feb 2026",
    "type": "Remote",
  }.obs;

  final certifications = [
    "Flutter Development",
    "Diploma in Information Technology (DIT)",
  ].obs;

  void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void sendEmail() async {
    final Uri params = Uri(scheme: 'mailto', path: email.value);
    if (!await launchUrl(params)) {
      throw Exception('Could not launch $params');
    }
  }
}
