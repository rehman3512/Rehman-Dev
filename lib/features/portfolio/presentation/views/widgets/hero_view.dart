import 'package:flutter/material.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class HeroView extends StatelessWidget {
  final PortfolioData data;
  const HeroView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 60 : 20),
      child: Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _topInfoBar(context, data),
          const SizedBox(height: 50),
          BlackText(
            text: "HI THERE! I'M REHMAN",
            fontSize: isDesktop ? 16 : 14,
            textColor: AppColors.secondaryText,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          ),
          const SizedBox(height: 10),
          BlackText(
            text: "Productive Flutter Developer",
            fontSize: isDesktop ? 45 : 32,
            fontWeight: FontWeight.bold,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          ),
          const SizedBox(height: 20),
          BlackText(
            text: data.summary,
            fontSize: isDesktop ? 16 : 14,
            textColor: AppColors.secondaryText,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          ),
          const SizedBox(height: 40),
          _skillsGrid(context),
        ],
      ),
    );
  }

  Widget _topInfoBar(BuildContext context, PortfolioData data) {
    final isMobile = Responsive.isMobile(context);
    final style = TextStyle(
      color: Colors.white70,
      fontSize: isMobile ? 10 : 12,
      letterSpacing: 0.5,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 15,
        runSpacing: 10,
        children: [
          _infoItem(Icons.email_outlined, data.email, style),
          _separator(),
          _infoItem(Icons.phone_outlined, data.phone, style),
          _separator(),
          _infoItem(Icons.location_on_outlined, data.location, style),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text, TextStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white54, size: 14),
        const SizedBox(width: 8),
        Text(text, style: style),
      ],
    );
  }

  Widget _separator() {
    return Container(height: 12, width: 1, color: Colors.white10);
  }

  Widget _skillsGrid(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final skills = [
      "Flutter (Android, iOS, Web)",
      "Dart",
      "GetX",
      "Riverpod",
      "Firebase (Firestore, Auth)",
      "REST APIs",
      "Google Maps SDK",
      "Local DB (GetStorage)",
      "OOP & MVC",
      "Clean Architecture",
      "Git & GitHub",
      "Postman",
      "VS Code",
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: skills.map((skill) => _skillPill(skill)).toList(),
    );
  }

  Widget _skillPill(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF151515), // Dark black like the image
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BlackText(
        text: skill,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        textColor: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
