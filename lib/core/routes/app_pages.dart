import 'package:get/get.dart';
import 'package:rehmandev/features/portfolio/presentation/bindings/portfolio_binding.dart';
import 'package:rehmandev/features/portfolio/presentation/views/portfolio_view.dart';

class AppPages {
  static const INITIAL = '/';

  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => const PortfolioView(),
      binding: PortfolioBinding(),
    ),
  ];
}
