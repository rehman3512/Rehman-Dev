import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class ProjectsView extends StatelessWidget {
  final PortfolioData data;
  const ProjectsView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlackText(
            text: "Recent Projects",
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 30),
          isDesktop
              ? GridView.builder(
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
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.projects.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
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
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Image.network(
                    widget.project['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
