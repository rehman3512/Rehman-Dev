import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class ServicesView extends ConsumerWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(portfolioProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlackText(
            text: "My Services",
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          const BlackText(
            text: "Transforming your vision into scalable digital solutions.",
            fontSize: 15,
            textColor: AppColors.secondaryText,
          ),
          const SizedBox(height: 40),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
              mainAxisExtent: Responsive.isDesktop(context) ? 250 : 180,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              return _ServiceCard(
                service: data.services[index],
                isMobile: !Responsive.isDesktop(context),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final Map<String, dynamic> service;
  final bool isMobile;
  const _ServiceCard({required this.service, this.isMobile = false});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color color = widget.service['color'];

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: EdgeInsets.all(widget.isMobile ? 15 : 30),
        decoration: BoxDecoration(
          color: isHovered ? color.withOpacity(0.12) : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(widget.isMobile ? 25 : 35),
          border: Border.all(
            color: isHovered
                ? color.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.service['icon'],
                color: color,
                size: widget.isMobile ? 20 : 28,
              ),
            ),
            const SizedBox(height: 15),
            BlackText(
              text: widget.service['title'],
              fontSize: widget.isMobile ? 14 : 18,
              fontWeight: FontWeight.bold,
            ),
            if (!widget.isMobile) ...[
              const SizedBox(height: 10),
              BlackText(
                text: widget.service['desc'],
                fontSize: 12,
                textColor: AppColors.secondaryText,
                height: 1.5,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
