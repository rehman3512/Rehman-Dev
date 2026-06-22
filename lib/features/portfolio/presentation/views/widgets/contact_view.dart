import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class ContactView extends ConsumerWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(portfolioProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlackText(
            text: "Get in Touch",
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 15),
          const BlackText(
            text: "Let's build something extraordinary together.",
            fontSize: 16,
            textColor: AppColors.secondaryText,
          ),
          const SizedBox(height: 60),

          if (Responsive.isDesktop(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _BentoCard(
                              icon: Icons.chat_bubble_rounded,
                              title: "WhatsApp",
                              subtitle: data.whatsapp,
                              onTap: () => data.launchWhatsApp(),
                              color: const Color(0xFF25D366),
                            ),
                          ),
                          const SizedBox(width: 25),
                          Expanded(
                            child: _BentoCard(
                              icon: Icons.alternate_email_rounded,
                              title: "Gmail",
                              subtitle: data.email,
                              onTap: () => data.sendEmail(),
                              color: const Color(0xFFEA4335),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const _MessageFormBento(),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _BentoCard(
                        icon: Icons.chat_bubble_rounded,
                        title: "WhatsApp",
                        subtitle: data.whatsapp,
                        onTap: () => data.launchWhatsApp(),
                        color: const Color(0xFF25D366),
                        isMobile: true,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _BentoCard(
                        icon: Icons.alternate_email_rounded,
                        title: "Gmail",
                        subtitle: data.email,
                        onTap: () => data.sendEmail(),
                        color: const Color(0xFFEA4335),
                        isMobile: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const _MessageFormBento(),
              ],
            ),
        ],
      ),
    );
  }
}

class _BentoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  final bool isMobile;

  const _BentoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
    this.isMobile = false,
  });

  @override
  State<_BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<_BentoCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          height: widget.isMobile ? 180 : 220,
          padding: EdgeInsets.all(widget.isMobile ? 15 : 30),
          decoration: BoxDecoration(
            color: isHovered
                ? widget.color.withOpacity(0.12)
                : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(widget.isMobile ? 25 : 40),
            border: Border.all(
              color: isHovered
                  ? widget.color.withOpacity(0.5)
                  : Colors.white.withOpacity(0.05),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: isHovered ? widget.color : Colors.white24,
                size: widget.isMobile ? 30 : 45,
              ),
              const SizedBox(height: 15),
              BlackText(
                text: widget.title,
                fontSize: widget.isMobile ? 14 : 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: BlackText(
                  text: widget.subtitle,
                  fontSize: widget.isMobile ? 10 : 13,
                  textColor: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageFormBento extends StatelessWidget {
  const _MessageFormBento();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlackText(
            text: "Quick Message",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(child: _field("First Name")),
              const SizedBox(width: 20),
              Expanded(child: _field("Last Name")),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _field("Email Address")),
              const SizedBox(width: 20),
              Expanded(child: _field("Phone Number")),
            ],
          ),
          const SizedBox(height: 20),
          _field("Description", maxLines: 3),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const BlackText(
                text: "Submit",
                textColor: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 12),
        filled: true,
        fillColor: Colors.white.withOpacity(0.02),
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white24),
        ),
      ),
    );
  }
}
