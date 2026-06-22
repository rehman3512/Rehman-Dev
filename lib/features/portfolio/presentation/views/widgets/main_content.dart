import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class MainContent extends ConsumerWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(portfolioProvider);
    final isDesktop = Responsive.isDesktop(context);

    if (!isDesktop) return _MobileHero(data: data);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlackText(
            text: "HI THERE! I'M REHMAN",
            fontSize: 16,
            textColor: AppColors.secondaryText,
          ),
          const SizedBox(height: 10),
          const BlackText(
            text: "Productive Flutter Developer",
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          BlackText(
            text: data.summary,
            fontSize: 16,
            textColor: AppColors.secondaryText,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => data.downloadResume(),
            icon: const Icon(Icons.download_rounded, size: 20),
            label: const BlackText(
              text: "Download CV",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Projects Grid
          const BlackText(
            text: "Recent Projects",
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.projects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final project = data.projects[index];
              return _ProjectCard(project: project);
            },
          ),
        ],
      ),
    );
  }
}

class _MobileHero extends StatelessWidget {
  final PortfolioData data;
  const _MobileHero({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const BlackText(
            text: "HI THERE!",
            fontSize: 14,
            textColor: AppColors.secondaryText,
          ),
          const SizedBox(height: 10),
          const BlackText(
            text: "Productive\nFlutter Developer",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          BlackText(
            text: data.summary,
            fontSize: 14,
            textColor: AppColors.secondaryText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () => data.downloadResume(),
            icon: const Icon(Icons.download_rounded, size: 18),
            label: const BlackText(
              text: "Download CV",
              fontSize: 13,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Mobile Projects
          const Align(
            alignment: Alignment.centerLeft,
            child: BlackText(
              text: "Recent Projects",
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.projects.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final project = data.projects[index];
              return _ProjectCard(project: project, isMobile: true);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isMobile;
  const _ProjectCard({required this.project, this.isMobile = false});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          final data = ProviderContainer().read(portfolioProvider);
          data.launchURL(widget.project['url']);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered
                  ? Colors.white24
                  : Colors.white.withOpacity(0.05),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Cover Image
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Image.network(
                    widget.project['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlackText(
                      text: widget.project['tech'],
                      fontSize: 10,
                      textColor: Colors.blueAccent,
                    ),
                    const SizedBox(height: 5),
                    BlackText(
                      text: widget.project['title'],
                      fontSize: widget.isMobile ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 5),
                    if (!widget.isMobile)
                      BlackText(
                        text: widget.project['desc'],
                        fontSize: 12,
                        textColor: AppColors.secondaryText,
                        maxLines: 2,
                      ),
                  ],
                ),
              ),
              // Link Icon
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.link, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
