import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/core/utils/responsive.dart';
import 'package:rehmandev/core/widgets/black_text.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/profile_card.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/hero_view.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/projects_view.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/resume_view.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/skills_view.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/custom_nav_bar.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/contact_view.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/services_view.dart';
import 'package:rehmandev/features/portfolio/presentation/views/widgets/blog_view.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class PortfolioView extends ConsumerStatefulWidget {
  const PortfolioView({super.key});

  @override
  ConsumerState<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends ConsumerState<PortfolioView> {
  final ScrollController _scrollController = ScrollController();

  // Keys for all 7 sections
  final Map<int, GlobalKey> _sectionKeys = {
    0: GlobalKey(), // Home
    1: GlobalKey(), // Projects
    2: GlobalKey(), // Resume
    3: GlobalKey(), // Skill
    4: GlobalKey(), // Services
    5: GlobalKey(), // Contact
    6: GlobalKey(), // Blog
  };

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
        alignment: 0.0, // Start at the TOP
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final data = ref.watch(portfolioProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Row(
            children: [
              if (!isMobile)
                Expanded(
                  flex: isTablet ? 3 : 3,
                  child: const SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ProfileCard(),
                  ),
                ),

              Expanded(
                flex: isMobile ? 10 : (isTablet ? 5 : 6),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 15 : (isTablet ? 30 : 40),
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      if (isMobile) const ProfileCard(),

                      // 1. Home
                      HeroView(key: _sectionKeys[0], data: data),
                      const SizedBox(height: 40),

                      // 2. Projects
                      ProjectsView(key: _sectionKeys[1], data: data),
                      const SizedBox(height: 40),

                      // 3. Resume
                      ResumeView(key: _sectionKeys[2], data: data),
                      const SizedBox(height: 40),

                      // 4. Skill
                      SkillsView(key: _sectionKeys[3], data: data),
                      const SizedBox(height: 40),

                      // 5. Services
                      ServicesView(key: _sectionKeys[4]),
                      const SizedBox(height: 40),

                      // 6. Contact
                      ContactView(key: _sectionKeys[5]),
                      const SizedBox(height: 40),

                      // 7. Blog
                      BlogView(key: _sectionKeys[6]),

                      const SizedBox(height: 60),
                      const BlackText(
                        text: "© 2026 RehmanDev. All rights reserved.",
                        fontSize: 12,
                        textColor: AppColors.secondaryText,
                      ),
                      SizedBox(height: isMobile || isTablet ? 100 : 20),
                    ],
                  ),
                ),
              ),

              if (Responsive.isDesktop(context))
                CustomNavBar(onTap: _scrollToSection),
            ],
          ),

          if (isMobile || isTablet)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _MobileFloatingNav(onTap: _scrollToSection),
            ),
        ],
      ),
    );
  }
}

class _MobileFloatingNav extends ConsumerWidget {
  final Function(int) onTap;
  const _MobileFloatingNav({required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(activeSectionProvider);

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.95),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navIcon(context, ref, 0, Icons.home_rounded, activeIndex == 0),
          _navIcon(context, ref, 1, Icons.grid_view_rounded, activeIndex == 1),
          _navIcon(
            context,
            ref,
            2,
            Icons.description_rounded,
            activeIndex == 2,
          ),
          _navIcon(context, ref, 3, Icons.bolt_rounded, activeIndex == 3),
          _navIcon(context, ref, 4, Icons.work_rounded, activeIndex == 4),
          _navIcon(
            context,
            ref,
            5,
            Icons.chat_bubble_rounded,
            activeIndex == 5,
          ),
          _navIcon(context, ref, 6, Icons.edit_note_rounded, activeIndex == 6),
        ],
      ),
    );
  }

  Widget _navIcon(
    BuildContext context,
    WidgetRef ref,
    int index,
    IconData icon,
    bool isActive,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final compact = screenWidth < 380;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(activeSectionProvider.notifier).state = index;
          onTap(index);
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 6 : 10,
            vertical: 8,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.blueAccent : Colors.white70,
            size: compact ? 20 : 24,
          ),
        ),
      ),
    );
  }
}
