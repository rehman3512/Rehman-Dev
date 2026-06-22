import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class BlogView extends ConsumerWidget {
  const BlogView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(portfolioProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlackText(
            text: "Latest Blog",
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          const BlackText(
            text: "Sharing knowledge and insights from my journey in tech.",
            fontSize: 15,
            textColor: AppColors.secondaryText,
          ),
          const SizedBox(height: 40),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.blogPosts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 30),
            itemBuilder: (context, index) {
              return _BlogCard(post: data.blogPosts[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _BlogCard extends StatefulWidget {
  final Map<String, dynamic> post;
  const _BlogCard({required this.post});

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(isDesktop ? 35 : 25),
          border: Border.all(
            color: isHovered ? Colors.white24 : Colors.white.withOpacity(0.05),
            width: 1,
          ),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: !isDesktop
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _blogImage(isHovered, double.infinity, 220),
                  _blogContent(!isDesktop),
                ],
              )
            : Row(
                children: [
                  _blogImage(isHovered, 300, 250),
                  Expanded(child: _blogContent(false)),
                ],
              ),
      ),
    );
  }

  Widget _blogImage(bool isHovered, double width, double height) {
    return Stack(
      children: [
        AnimatedScale(
          scale: isHovered ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 800),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.post['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _blogContent(bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 25 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: BlackText(
                  text: widget.post['category'].toString().toUpperCase(),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  textColor: Colors.blueAccent,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 15),
              BlackText(
                text: widget.post['date'],
                fontSize: 12,
                textColor: AppColors.secondaryText.withOpacity(0.6),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlackText(
            text: widget.post['title'],
            fontSize: isMobile ? 20 : 26,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          const SizedBox(height: 25),
          _readMoreButton(isHovered),
        ],
      ),
    );
  }

  Widget _readMoreButton(bool hovered) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: hovered ? Colors.white : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: hovered ? Colors.white : Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlackText(
            text: "Read Article",
            fontSize: 13,
            fontWeight: FontWeight.bold,
            textColor: hovered ? Colors.black : Colors.white,
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: hovered ? Colors.black : Colors.white,
            size: 14,
          ),
        ],
      ),
    );
  }
}
