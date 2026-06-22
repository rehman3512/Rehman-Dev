import 'package:flutter/material.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class ResumeView extends StatelessWidget {
  final PortfolioData data;
  const ResumeView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 40 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BlackText(
                text: "Resume",
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              if (isDesktop) _cvButton(data),
            ],
          ),
          if (!isDesktop) ...[const SizedBox(height: 15), _cvButton(data)],
          const SizedBox(height: 40),
          _sectionTitle("Professional Summary"),
          const SizedBox(height: 15),
          BlackText(
            text: data.summary,
            fontSize: 14,
            textColor: AppColors.secondaryText,
            height: 1.6,
          ),
          const SizedBox(height: 50),
          !isDesktop
              ? Column(
                  children: [
                    _academicSection(data),
                    const SizedBox(height: 50),
                    _workSection(data),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _academicSection(data)),
                    const SizedBox(width: 40),
                    Expanded(flex: 4, child: _workSection(data)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _cvButton(PortfolioData data) {
    return ElevatedButton.icon(
      onPressed: () => data.downloadResume(),
      icon: const Icon(Icons.download_rounded, size: 16),
      label: const BlackText(
        text: "Download CV",
        fontSize: 12,
        fontWeight: FontWeight.bold,
        textColor: Colors.black,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlackText(text: title, fontSize: 18, fontWeight: FontWeight.bold),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _academicSection(PortfolioData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Education"),
        const SizedBox(height: 25),
        ...data.education.map(
          (edu) => _timelineItem(
            title: edu['school']!,
            subtitle: edu['degree']!,
            period: edu['period']!,
            details: edu['details']!,
            icon: Icons.school_outlined,
          ),
        ),
      ],
    );
  }

  Widget _workSection(PortfolioData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Work Experience"),
        const SizedBox(height: 25),
        ...data.experience.map(
          (exp) => _timelineItem(
            title: exp['company'] as String,
            subtitle: exp['role'] as String,
            period: exp['period'] as String,
            details: (exp['details'] as List).join("\n• "),
            icon: Icons.work_history_outlined,
            isWork: true,
          ),
        ),
      ],
    );
  }

  Widget _timelineItem({
    required String title,
    required String subtitle,
    required String period,
    required String details,
    required IconData icon,
    bool isWork = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlackText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 4),
                    BlackText(
                      text: subtitle,
                      fontSize: 12,
                      textColor: AppColors.secondaryText,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BlackText(
                  text: period,
                  fontSize: 10,
                  textColor: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlackText(
            text: isWork ? "• $details" : details,
            fontSize: 12,
            textColor: AppColors.secondaryText,
            height: 1.6,
          ),
        ],
      ),
    );
  }
}
