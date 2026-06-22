import 'package:flutter/material.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class SkillsView extends StatelessWidget {
  final PortfolioData data;
  const SkillsView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Technical Skills"),
          const SizedBox(height: 25),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: data.skills.map((skillGroup) {
              final group = skillGroup as Map<String, dynamic>;
              return Container(
                width: 250,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlackText(
                      text: group['category'],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (group['items'] as List)
                          .map(
                            (item) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: BlackText(
                                text: item,
                                fontSize: 10,
                                textColor: AppColors.secondaryText,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 60),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _certificatesSection(data)),
                    const SizedBox(width: 40),
                    Expanded(child: _languagesSection(data)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _certificatesSection(data),
                    const SizedBox(height: 50),
                    _languagesSection(data),
                  ],
                ),
        ],
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

  Widget _certificatesSection(PortfolioData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Certificates"),
        const SizedBox(height: 25),
        ...data.certificates.map(
          (cert) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_outlined,
                  color: Colors.blueAccent,
                  size: 16,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BlackText(
                    text: cert,
                    fontSize: 13,
                    textColor: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _languagesSection(PortfolioData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Languages"),
        const SizedBox(height: 25),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: data.languages
              .map(
                (lang) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: BlackText(
                    text: lang,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
