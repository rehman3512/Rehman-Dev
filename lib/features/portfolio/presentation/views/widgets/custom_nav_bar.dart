import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rehmandev/core/theme/app_colors.dart';
import 'package:rehmandev/features/portfolio/presentation/providers/portfolio_provider.dart';

class CustomNavBar extends ConsumerWidget {
  final Function(int) onTap;
  const CustomNavBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 60,
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _navItem(ref, 0, Icons.home_rounded),
          _navItem(ref, 1, Icons.grid_view_rounded),
          _navItem(ref, 2, Icons.description_rounded),
          _navItem(ref, 3, Icons.bolt_rounded),
          _navItem(ref, 4, Icons.work_rounded),
          _navItem(ref, 5, Icons.chat_bubble_rounded),
          _navItem(ref, 6, Icons.edit_note_rounded),
        ],
      ),
    );
  }

  Widget _navItem(WidgetRef ref, int index, IconData icon) {
    final activeIndex = ref.watch(activeSectionProvider);
    final isSelected = activeIndex == index;

    return InkWell(
      onTap: () {
        ref.read(activeSectionProvider.notifier).state = index;
        onTap(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blueAccent.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? Colors.blueAccent.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.blueAccent : Colors.white70,
          size: 20,
        ),
      ),
    );
  }
}
