import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(portfolioProvider);

    return Container(
      width: 310, // More compact
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content
        children: [
          // Top Row: Star and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.star_outline, color: Colors.white70, size: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const BlackText(
                      text: "Working on 2 Projects",
                      fontSize: 8,
                      textColor: Colors.white70,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Profile Image
          Container(
            height: 260, // Shorter image
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                image: AssetImage('assets/images/rehman.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Email
          BlackText(
            text: data.email,
            fontSize: 12,
            textColor: AppColors.secondaryText,
          ),
          const SizedBox(height: 15),

          // Social Icons - Branded with real logos
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _socialIcon(
                FontAwesomeIcons.github,
                () => data.launchURL(data.githubProfile),
              ),
              _socialIcon(
                FontAwesomeIcons.linkedinIn,
                () => data.launchURL(data.linkedin),
              ),
              _socialIcon(
                FontAwesomeIcons.instagram,
                () => data.launchURL(data.instagram),
              ),
              _socialIcon(
                FontAwesomeIcons.xTwitter,
                () => data.launchURL(data.twitter),
              ),
              _socialIcon(
                Icons.work,
                () => data.launchURL(data.fiverr),
                isFiverr: true,
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Get Started Button - Slim and Elegant
          GestureDetector(
            onTap: () {
              ref.read(activeSectionProvider.notifier).state = 5;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: BlackText(
                        text: "Get Started",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.call_made_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(
    IconData icon,
    VoidCallback onTap, {
    bool isFiverr = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.035),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Center(
          child: isFiverr
              ? Image.network(
                  'https://cdn.worldvectorlogo.com/logos/fiverr-2.svg',
                  width: 22,
                  height: 22,
                  color: Colors.white.withOpacity(0.7),
                  errorBuilder: (context, error, stackTrace) => const BlackText(
                    text: "Fi",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white70,
                  ),
                )
              : FaIcon(icon, size: 18, color: Colors.white.withOpacity(0.7)),
        ),
      ),
    );
  }
}
